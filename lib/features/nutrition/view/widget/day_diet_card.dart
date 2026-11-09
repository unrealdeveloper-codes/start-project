import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DayDietCard extends StatelessWidget {
  final String iconPath;
  final String title;

  const DayDietCard({
    super.key,
    required this.iconPath,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.1),
            offset: Offset.zero,
            blurRadius: 1.0,
            spreadRadius: 0.5,
          ),
        ],
      ),
      child: SizedBox(
        width: width * 0.001,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath),
            SizedBox(height: height * 0.01),
            MySofiaSansText(
              text: title,
              fontSize: AppSizer.fontSize15,
              fontWeight: FontWeight.w800,
              maxLines: 1,
            ),

          ],
        ),
      ),
    );
  }
}
