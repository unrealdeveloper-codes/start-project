import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';

class DietCard extends StatelessWidget {
  final String heading;
  final String heading2;
  final double value;
  final String value2;
  final Color color;

  const DietCard(
      {super.key,
      required this.heading,
      required this.heading2,
      required this.value,
      required this.value2,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: AppSizer.vertical8,
        horizontal: AppSizer.horizontal15,
      ),
      margin: EdgeInsets.only(bottom: height * 0.024),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: AppColor.black.withOpacity(0.08),
            blurRadius: 4,
          )
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyManropeText(
                text: heading,
                color: AppColor.bodyTextColor,
                fontWeight: FontWeight.w700,
                fontSize: AppSizer.fontSize13,
                maxLines: 1,
              ),
              SizedBox(
                width: AppSizer.width * 0.4,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: MyManropeText(
                    text: value >= 100.0
                        ? "100 %"
                        : "${value.toStringAsFixed(1)} %",
                    color: AppColor.primaryColor1,
                    fontSize: AppSizer.fontSize14,
                    fontWeight: FontWeight.w900,
                    maxLines: 1,
                  ),

                  // child: MyManropeText(
                  //   text: "${value.toString()}%",
                  //   color: AppColor.primaryColor1,
                  //   fontWeight: FontWeight.w900,
                  //   fontSize: AppSizer.fontSize14,
                  //   maxLines: 1,
                  // ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * 0.015),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizer.width * 0.025),
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: AppSizer.height * .013,
              backgroundColor: color.withOpacity(0.3),
              // Background color of the bar
              color: color,
              // Color of the progress bar
              borderRadius: BorderRadius.circular(AppSizer.width * 0.025),
            ),
          ),
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: AppSizer.width * 0.41,
                child: MyManropeText(
                  text: heading2,
                  color: AppColor.primaryColor1,
                  fontWeight: FontWeight.w700,
                  fontSize: AppSizer.fontSize13,
                  maxLines: 1,
                ),
              ),
              SizedBox(
                width: AppSizer.width * 0.41,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: MyManropeText(
                    text: value2.toString(),
                    color: color,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizer.fontSize13,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
