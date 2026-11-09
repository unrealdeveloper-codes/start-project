import 'package:desa/features/authentication/controllers/auth_controller.dart';
import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/textfields/customeTextField.dart';
import 'package:desa/utils/components/widgets/forgot_password_widget.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class LoginScreenView extends StatelessWidget {
  const LoginScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AuthController(context));
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: AppSizer.vertical10,
              horizontal: AppSizer.horizontal20,
            ),
            child: Column(
              children: [
                SizedBox(height: height * 0.075),
                _buildHeaderText(width),
                SizedBox(height: height * 0.04),
                Form(
                  key: controller.formkey,
                  child: Column(
                    children: [
                      MyTextFeild(
                        controller: controller.emailController,
                        hintText: 'Enter Email',
                        validator: 'Email',
                      ),
                      const SizedBox(height: 20),
                      MyTextFeild(
                        controller: controller.passwordController,
                        hintText: 'Enter Password',
                        validator: 'Password',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.015),
                const ForgotPasswordWidget(),
                SizedBox(height: height * 0.01),
                CustomeButton(
                  text: 'Login',
                  onPressed: () => controller.signIn(context),
                ),
                SizedBox(height: height * 0.02),
                // Spacing before terms and conditions
                _buildTermsAndConditionsText(context),
              ],
            ),
          ),
          Image.asset(
            'assets/onbordingScreen/Login.png',
            width: width,
            // height: height * 0.34,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }

  // Private method for header text to improve readability
  Widget _buildHeaderText(double width) {
    return Column(
      children: [
        MySofiaSansText(
          text: "Continue your journey".toUpperCase(),
          fontSize: width * 0.1,
          height: width * 0.0027,
          fontWeight: FontWeight.w800,
        ),
        SizedBox(height: width * 0.025),
        MyManropeText(
          text: "Log in to continue your journey towards better health.",
          color: AppColor.primaryColor1,
          height: width * 0.004,
          fontWeight: FontWeight.w700,
          fontSize: width * 0.035,
        ),
      ],
    );
  }

  // Private method for terms and conditions text with clickable links
  Widget _buildTermsAndConditionsText(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // Handle overall area tap if necessary
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 14,
            color: AppColor.primaryColor1,
          ),
          children: [
            TextSpan(
              text: 'By logging in, you agree to our ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: 'Terms and Conditions',
              style: TextStyle(
                color: AppColor.primaryColor1,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigate to Terms and Conditions page
                  context.push(AppRoutes.TERMS_AND_CONDITION_SCREEN);
                },
            ),
            TextSpan(
              text: ' and ',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: AppColor.primaryColor1,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  // Navigate to Privacy Policy page
                  context.push(AppRoutes.PRIVACY_POLICY_SCREEN);
                },
            ),
            TextSpan(
              text: '.',
              style: TextStyle(fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}

// class LoginScreenView extends StatelessWidget {
//   const LoginScreenView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(AuthController(context));
//     final size = MediaQuery.of(context).size;
//     final height = size.height;
//     final width = size.width;
//
//     return Scaffold(
//       backgroundColor: AppColor.appBackgroundColor,
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: AppSizer.vertical10,
//                 horizontal: AppSizer.horizontal20,
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: height * 0.075),
//                   _buildHeaderText(width),
//                   SizedBox(height: height * 0.04),
//                   Form(
//                     key: controller.formkey,
//                     child: Column(
//                       children: [
//                         MyTextFeild(
//                           controller: controller.emailController,
//                           hintText: 'Enter Email',
//                           validator: 'Email',
//                         ),
//                         const SizedBox(height: 20),
//                         MyTextFeild(
//                           controller: controller.passwordController,
//                           hintText: 'Enter Password',
//                           validator: 'Password',
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: height * 0.015),
//                   const ForgotPasswordWidget(),
//                   SizedBox(height: height * 0.01),
//                   CustomeButton(
//                     text: 'Login',
//                     onPressed: () => controller.signIn(context),
//                   ),
//                 ],
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Image.asset(
//                 'assets/onbordingScreen/Login.png',
//                 width: width,
//                 fit: BoxFit.fill,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Private method for header text to improve readability
//   Widget _buildHeaderText(double width) {
//     return Column(
//       children: [
//         MySofiaSansText(
//           text: "Continue your journey".toUpperCase(),
//           fontSize: width * 0.1,
//           height: width * 0.0027,
//           fontWeight: FontWeight.w800,
//         ),
//         SizedBox(height: width * 0.025),
//         MyManropeText(
//           text: "Log in to continue your journey towards better health.",
//           color: AppColor.primaryColor1,
//           height: width * 0.004,
//           fontWeight: FontWeight.w700,
//           fontSize: width * 0.035,
//         ),
//       ],
//     );
//   }
// }
