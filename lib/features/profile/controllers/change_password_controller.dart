import 'package:desa/features/authentication/repositories/auth_repo.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ChangePasswordController extends GetxController {
  static ChangePasswordController get instance => Get.find();

  // Variables
  final oldPassword = TextEditingController();
  final newPassword = TextEditingController();
  final confrimPassword = TextEditingController();
  final _authRepo = AuthRepo();

  GlobalKey<FormState> changepasswordFromKey = GlobalKey<FormState>();

  void clearAll() {
    // Clearing Fields
    newPassword.clear();
    oldPassword.clear();
    confrimPassword.clear();
  }

  // Send Reset Password Email
  changePassword(BuildContext context) async {
    try {
      if (!changepasswordFromKey.currentState!.validate()) {
        return;
      }

      // Verify Password is Changed or not
      if (oldPassword.text.trim() == newPassword.text.trim()) {
        AppSnackBar.showSnackbar(
          context: context,
          type: SnackbarType.error,
          title: "Same Password",
          message: "New Password should be different from the old password",
        );

        return;
      }

      if (context.mounted) context.loaderOverlay.show();

      final body = {
        "old_password": oldPassword.text,
        "new_password": newPassword.text,
        "confirm_password": confrimPassword.text,
      };

      await _authRepo.changePassword(body);

      if (context.mounted) {
        AppSnackBar.showSnackbar(
          context: context,
          title: 'Password Changed!',
          message:
              "Your password has been changed successfully. Please login with your new password.",
        );
      }
      clearAll();
    } catch (e) {
      if (context.mounted) {
        AppSnackBar.showSnackbar(
          type: SnackbarType.error,
          context: context,
          title: "Oh Snap",
          message: e.toString(),
        );
      }
    } finally {
      if (context.mounted) context.loaderOverlay.hide();
    }
  }
}
