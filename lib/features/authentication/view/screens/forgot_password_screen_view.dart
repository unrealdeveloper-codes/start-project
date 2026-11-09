import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/textfields/customeTextField.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:desa/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../controllers/forgot_password_screen_controller.dart';

class ForgotPasswordScreenView extends StatelessWidget {
  const ForgotPasswordScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = Get.put(ForgotPasswordController());
    return ReusableScreenStructure(
      title: "Reset Password",
      description:
          'Enter your email to receive instructions for resetting your password.',
      onBack: () {
        Get.delete<ForgotPasswordController>();
        context.pop();
      },
      bodyContent: Column(
        children: [
          Form(
            key: controller.formKey,
            child: NewMyTextFeild(
              controller: controller.email,
              hintText: 'Enter Email',
              validator: Validator.validateEmail,
            ),
          ),
          SizedBox(height: height * 0.035),
          Center(
            child: CustomeButton(
              text: 'Send Reset Link',
              onPressed: () => controller.resetPassword(context),
              horizontalPadding: width * 0.1,
            ),
          ),
        ],
      ),
    );
  }
}



  //  Stack(
    //   children: [
    //     Image.asset(
    //       'assets/backGroundImages/forgotPassword.png',
    //       width: width,
    //       height: height,
    //     ),
    //     Scaffold(
    //         backgroundColor: Colors.transparent,
    //         appBar: AppBar(
    //           backgroundColor: Colors.transparent,
    //           leading: IconButton(
    //             icon: Icon(
    //               Icons.arrow_back_ios_new,
    //               size: width * 0.045,
    //             ),
    //             onPressed: () {
    //               context.pop();
    //             },
    //           ),
    //         ),

    //         body: SafeArea(
    //           child: Padding(
    //             padding: EdgeInsets.symmetric(
    //                 horizontal: width * 0.055, vertical: height * 0.015),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 MyManropeText(
    //                   text: 'Reset Password',
    //                   color: AppColor.primaryColor1,
    //                   fontSize: width * 0.06,
    //                   fontWeight: FontWeight.w900,
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.01,
    //                 ),
    //                 MyManropeText(
    //                   text:
    //                       'Enter your email to receive instructions for resetting your password.',
    //                   color: AppColor.primaryColor1,
    //                   fontWeight: FontWeight.w500,
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.03,
    //                 ),
    //                 MyTextFeild(
    //                   controller: controller.emailController,
    //                   hintText: 'Enter Email',
    //                   validator: 'Email', // Consider adding validation logic
    //                 ),
    //                 SizedBox(
    //                   height: height * 0.035,
    //                 ),
    //                 Center(
    //                   child: CustomeButton(
    //                     text: 'Send Reset Link',
    //                     onPressed: () {},
    //                     horizontalPadding: width * 0.1,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         )),
    //   ],
    // );