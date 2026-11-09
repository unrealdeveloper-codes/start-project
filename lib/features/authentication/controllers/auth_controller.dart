import 'package:desa/data/datasources/local/user_prefrence.dart';
import 'package:desa/data/notificationSection/NotificationService.dart';
import 'package:desa/features/authentication/models/user_model.dart';
import 'package:desa/features/authentication/repositories/auth_repo.dart';
import 'package:desa/features/static/bottomNavigationBar/controllers/bottom_navigation_bar_controller.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../utils/components/snackbar/app_snackbar.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  BuildContext context;
  AuthController(this.context);

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 2), () {
      screenRedirect();
    });

    super.onInit();
  }

  // -- Variables
  final deviceStorage = GetStorage();
  final prefs = UserPreferences();
  final _authRepo = AuthRepo();
  final _user = User.empty().obs;

  final emailController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  final formkey = GlobalKey<FormState>();

  RxBool isSignInLoading = false.obs;
  RxBool isLogoutLoading = false.obs;

  RxBool isTNCAccepted = false.obs;

  // -- Getters
  User get user => _user.value;

  // --------------------- Helper Functions ----------------------
  void toggleTNCAccepted() {
    isTNCAccepted.value = !isTNCAccepted.value;
  }

  void setUser(User u) {
    _user.value = u;
    _user.refresh();
  }

  void setSignInLoading(bool value) {
    isSignInLoading.value = value;
    isSignInLoading.refresh();
  }

  void setLogoutLoading(bool value) {
    isLogoutLoading.value = value;
    isLogoutLoading.refresh();
  }

  void toggleNotification() {
    _user.value.notificationStatus = !_user.value.notificationStatus!;
  }

  void onErrorHandler(Object? error, StackTrace stackTrace) {
    ("$error $stackTrace").log("Auth Controller");
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
  }

  // --------------------- Screen Redirect ------------------------------
  Future<void> screenRedirect() async {
    final isAuth = await authentication();
    final isFirstTime = await prefs.getIsFirstTime();
    if (isAuth) {
      if (context.mounted) {
        context.pushReplacement(AppRoutes.BOTTOM_NAVIGATION_BAR);
        // context.pushReplacement(AppRoutes.LOGIN_SCREEN);
      }
    } else {
      if (isFirstTime) {
        if (context.mounted) {
          context.pushReplacement(AppRoutes.ONBORDING_SCREEN);
        }
      } else {
        if (context.mounted) context.pushReplacement(AppRoutes.LOGIN_SCREEN);
        // context.pushReplacement(AppRoutes.BOTTOM_NAVIGATION_BAR);
      }
    }
  }

  // --------------------- Authentication ------------------------------
  Future<bool> authentication() async {
    try {
      final token = await prefs.getToken();
      if (token == null || token.isEmpty) return false;
      // -- Calling API for Sign Up
      return await _authRepo.auth().then((value) {
        ("Token Verified 🔥🔥🔥🔥🔥").log("Auth-Auth_Controller");
        ("User: $value").log("User Data"); // Print User Data
        prefs.printToken();
        setUser(User.fromJson(value['data'])); // Set User Data
        return true;
      }).onError((error, stackTrace) {
        onErrorHandler(error, stackTrace);
        return false;
      });
    } catch (e) {
      printError(info: "Catch Error: $e");
      return false;
    }
  }

  // --------------------- Sign In ------------------------------
  Future<void> signIn(BuildContext context) async {
    String? deviceToken = await NotificationService().getToken();

    try {
      // -- Form Validation
      if (!formkey.currentState!.validate()) {
        return;
      }

      // -- Start Overlay Loading
      context.loaderOverlay.show();

      // -- Prepare Body
      final body = {
        "email": emailController.text,
        "password": passwordController.text,
        "device_token": deviceToken ?? "",
      };

      // -- Calling API for Sign In
   await _authRepo.login(body).then((value) async {
        setUser(User.fromJson(value['data'])); // Set User Data
        await prefs.setToken(value['token']); // Save Token
     
        await prefs.setUserId(value['data']['id'].toString());
      });

      if (context.mounted) {
        context.pushReplacement(AppRoutes.BOTTOM_NAVIGATION_BAR);
      }
      if (context.mounted) {
        AppSnackBar.showSnackbar(
          context: context,
          title: "Welcome Back!",
          message: user.name ?? "Guest",
        );
      }
      clearControllers();
    } catch (error, stackTrace) {
      if (context.mounted) {
        AppSnackBar.showSnackbar(
          type: SnackbarType.error,
          context: context,
          title: "Oh Snap!",
          message: error.toString(),
        );
      }
      onErrorHandler(error, stackTrace);
    } finally {
      if (context.mounted) context.loaderOverlay.hide();
    }
  }

  // ----------------- Logout ---------------------
  Future<void> logout(BuildContext context) async {
    String deviceToken = await prefs.getDeviceToken() ?? "text";

    try {
      final body = {"device_token": deviceToken};
      context.loaderOverlay.show();
      await _authRepo.logout(body);
      await prefs.clearAll().then((val) {
        ("Local Cleared").log("Logut Auth Controller");
      }); // Clear All Local Data
      if (context.mounted) {
        AppSnackBar.showSnackbar(
          context: context,
          title: "Success",
          message: "User Logged Out Successfully",
        );
      }
      if (Get.isRegistered<BottomNavigationBarController>()) {
        Get.delete<BottomNavigationBarController>();
      }

      if (context.mounted) context.pushReplacement(AppRoutes.LOGIN_SCREEN);
    } catch (error, stackTrace) {
      printError(info: "Catch Error: $error");
      onErrorHandler(error, stackTrace);
    } finally {
      // -- Stop Overlay Loading
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
