import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:flutter/material.dart';

class HeadingSubheadingWidget extends StatelessWidget {
  final String heading, subHeading;

  const HeadingSubheadingWidget(
      {super.key, required this.heading, required this.subHeading});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MySofiaSansText(
          text: heading,
          fontSize: AppSizer.fontSize30,
          fontWeight: FontWeight.w800,
          maxLines: 2,
        ),
        SizedBox(height: height * 0.004),
        ExpandableText(description: subHeading),

        // MyManropeText(
        //   text: subHeading,
        //   color: AppColor.bodyTextColor,
        //   height: width * 0.004,
        //   fontWeight: FontWeight.w700,
        //   fontSize: AppSizer.fontSize12,
        // ),
      ],
    );
  }
}
