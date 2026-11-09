import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/authentication/controllers/auth_controller.dart';
import 'package:desa/features/profile/repository/notification_repository.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NotificationController extends GetxController {
  static NotificationController get instance => Get.find();

  BuildContext context;
  NotificationController(this.context);

  @override
  void onInit() {
    setInitial();
    super.onInit();
  }

  // -- Variables
  final _repo = NotificationRepository();
  final authController = AuthController.instance;
  final apiCallHandler = ApiCallHandler();

  final _isLoading = false.obs;
  final _erroMessage = "".obs;
  final _isNotificationOn = false.obs;

  // -- Getter
  bool get isLoading => _isLoading.value;
  String get errorMessage => _erroMessage.value;
  bool get isNotificationOn => _isNotificationOn.value;

  // -- Helper Functions
  // -- SetInitial State of Notifcation
  void setInitial() {
    _isNotificationOn.value = authController.user.notificationStatus ?? false;
    authController.user.notificationStatus!.log("Notification User stus");
    _erroMessage.value = "";
  }

  void toogleNotificationStatus(Map<String, dynamic> data) {
    AppSnackBar.showSnackbar(
      context: context,
      title: "Success",
      message: data['message'],
    );
    authController.toggleNotification();
    _isNotificationOn.value = !_isNotificationOn.value;
  }

  // -- API Functions
  Future<void> toogleNotification(BuildContext con) async {
    try {
      // -- Start Overlay Loading
      con.loaderOverlay.show();
      await apiCallHandler.apiHandler(
        context: con,
        apiCall: () => _repo.toggle(),
        onSuccess: (result) => toogleNotificationStatus(result),
        errorMessage: _erroMessage,
        isLoading: _isLoading,
      );
      if (con.mounted) con.loaderOverlay.hide();
    } catch (error, stackTrace) {
      "error $error, stackTrace $stackTrace".log();
    }
  }

  Future<void> fetchNotifcations() async {
    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.fetchNotifications(),
      onSuccess: (result) => toogleNotificationStatus(result),
      errorMessage: _erroMessage,
      isLoading: _isLoading,
    );
  }
}
