// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:desa/features/home/controllers/quotes_controller.dart';
import 'package:desa/utils/components/container/customeContiner.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/loaders/loader/animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeQuotesSection extends StatelessWidget {
  const HomeQuotesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuotesController(context));
    controller.fetchQuotes();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return CustomContainer(
      color: AppColor.cardBackGroundBlueColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.55,
            child: Stack(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.04, left: width * 0.055),
                  child: Obx(
                    () {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.motivationTitle,
                            style: GoogleFonts.damion(
                              fontSize: width * 0.055,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              color: AppColor.primaryColor1,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: height * 0.028),
                          if (controller.errorMessage != "")
                            MyManropeText(
                              text: controller.errorMessage,
                              color: AppColor.darkGreyColor,
                              fontSize: AppSizer.fontSize15,
                              fontWeight: FontWeight.w600,
                              maxLines: 3,
                            )
                          else
                            Obx(() => controller.isLoading
                                ? const QuotesShimmer()
                                : MyManropeText(
                                    text: controller.quote,
                                    color: AppColor.darkGreyColor,
                                    fontSize: AppSizer.fontSize13,
                                    fontWeight: FontWeight.w600,
                                    maxLines: 3,
                                  ))
                          // MyManropeText(
                          //   text: controller.quote,
                          //   color: AppColor.darkGreyColor,
                          //   fontSize: AppSizer.fontSize13,
                          //   fontWeight: FontWeight.w600,
                          //   maxLines: 3,
                          // ),
                        ],
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.03,
                    horizontal: width * 0.02,
                  ),
                  child: SvgPicture.asset(AppSvg.tuneIcon),
                ),
              ],
            ),
          ),
          Image.asset(
            AppSvg.homeBanner1,
            height: height * 0.21,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}

class QuotesShimmer extends StatelessWidget {
  const QuotesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.015),
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          // baseColor: Colors.blue.shade300,
          // highlightColor: Colors.blue.shade100,
          child: Container(
            width: double.infinity,
            height: height * 0.015,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue.withOpacity(0.5),
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: width * 0.4,
            height: height * 0.015,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue.withOpacity(0.5),
            ),
          ),
        ),
        SizedBox(height: height * 0.01),
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: width * 0.2,
            height: height * 0.018,
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.blue.withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}
