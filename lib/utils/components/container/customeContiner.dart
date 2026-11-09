import 'package:desa/utils/constants/resuable_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:desa/utils/constants/app_colors.dart';

class CustomContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? color;

  const CustomContainer({
    super.key,
    this.width,
    this.height,
    required this.child,
    this.padding,
    this.margin,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.95,
      // default width if not provided
      // height: height ?? MediaQuery.of(context).size.height * 0.2,
      // default height if not provided
      padding: padding,
      margin: margin,
      decoration: ReusableDecoration.reusableBoxDecoration(color: color,context: context),
      // decoration: BoxDecoration(
      //   color: color ?? AppColor.baseWhiteColor,
      //   // default color if not provided
      //   borderRadius: BorderRadius.circular(
      //       (width ?? MediaQuery.of(context).size.width) * 0.025),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.3),
      //       spreadRadius: 0.5,
      //       blurRadius: 0.5,
      //       offset: Offset(0, 0),
      //     ),
      //   ],
      //
      // ),
      child: child,
    );
  }
}
