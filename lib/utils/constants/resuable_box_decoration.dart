import 'package:desa/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ReusableDecoration {
  static BoxDecoration reusableBoxDecoration({
    Color? color,
    required BuildContext context,
  }) {
    final defaultWidth = MediaQuery.of(context).size.width;
    return BoxDecoration(
      color: color ?? AppColor.baseWhiteColor,
      borderRadius: BorderRadius.circular(defaultWidth * 0.025),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.16),
          blurRadius: 8,
        ),
      ],
    );
  }
}
