import 'package:desa/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:desa/features/authentication/repositories/auth_repo.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  // Variables
  final email = TextEditingController(text: "");
  final _authRepo = AuthRepo();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Send Reset Password Email
  resetPassword(BuildContext context) async {
    try {
      if (!formKey.currentState!.validate()) {
        return;
      }

      if (context.mounted) context.loaderOverlay.show();

      final body = {"email": email.text};

      await _authRepo.resetPassword(body).then((val) {
        if (context.mounted) {
          AppSnackBar.showSnackbar(
            context: context,
            title: 'Success',
            message: val['message'],
          );
        }
      });
      email.clear();
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
