import 'package:desa/features/profile/controllers/change_password_controller.dart';
import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/textfields/customeTextField.dart';
import 'package:desa/utils/components/widgets/forgot_password_widget.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:desa/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());
    return ReusableScreenStructure(
        title: 'Change Password',
        description: 'Secure your account by updating your password regularly.',
        onBack: () {
          Get.delete<ChangePasswordController>();
          context.pop();
        },
        bodyContent: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: controller.changepasswordFromKey,
              child: Column(
                children: [
                  NewMyTextFeild(
                    hintText: 'Enter Old Password',
                    controller: controller.oldPassword,
                    // validator: Validator.validatePassword,
                    // isPasswordField: true,
                  ),
                  SizedBox(
                    height: AppSizer.height * 0.02,
                  ),
                  NewMyTextFeild(
                    hintText: 'Enter New Password',
                    controller: controller.newPassword,
                    validator: Validator.validatePassword,
                    isPasswordField: true,
                  ),
                  SizedBox(
                    height: AppSizer.height * 0.02,
                  ),
                  NewMyTextFeild(
                    hintText: 'Confirm New Password',
                    controller: controller.confrimPassword,
                    isPasswordField: true,
                    validator: (value) {
                      return Validator.validateConfirmPassword(
                        value: value,
                        valController: controller.newPassword.text,
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: AppSizer.height * 0.01,
            ),
            const ForgotPasswordWidget(),
            SizedBox(
              height: AppSizer.height * 0.02,
            ),
            CustomeButton(
              text: 'Update Password',
              onPressed: () => controller.changePassword(context),
              horizontalPadding: AppSizer.width * 0.08,
            )
          ],
        ));
  }
}
