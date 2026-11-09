import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordWidget extends StatelessWidget {
  const ForgotPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            context.push(AppRoutes.FORGOT_PASSWORD_SCREEN);
          },
          child: MyManropeText(
            text: 'Forgot Password?',
            color: AppColor.primaryColor1,
            fontSize: width * 0.034,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
