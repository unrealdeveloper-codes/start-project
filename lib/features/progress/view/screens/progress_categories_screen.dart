import 'package:desa/utils/components/headings/heading_subheading_widget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_images.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProgressCategoriesScreen extends StatelessWidget {
  const ProgressCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15,
          vertical: AppSizer.vertical10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.02),
            const HeadingSubheadingWidget(
              heading: AppStrings.progressHeading,
              subHeading: AppStrings.progressSubheading,
            ),
            SizedBox(height: height * 0.03),
            buildSections(
              context,
              AppStrings.myNutritionDiaryHeading,
              AppStrings.myNutritionDiarySubheading,
              AppImages.nutritionBanner,
              () => context.push(AppRoutes.myNutritionDiaryScreen),
            ),
            //   SizedBox(height: height * 0.02),
            buildSections(
              context,
              AppStrings.waterMoniter,
              AppStrings.waterMoniterSubHeading,
              AppImages.waterBanner,
              () => context.push(AppRoutes.waterMonitorScreen),
            )
          ],
        ),
      ),
    );
  }

  Widget buildSections(
    BuildContext context,
    String heading,
    String subHeading,
    String image,
    VoidCallback onTap,
  ) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.21,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          // -- Gradient
          Container(
            width: double.infinity,
            height: height * 0.21,
            margin: EdgeInsets.only(bottom: height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2D4854).withOpacity(0.0),
                  const Color(0xFF203139).withOpacity(0.5),
                  const Color(0xFF1B262C),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.018,
            child: Padding(
              padding: EdgeInsets.all(AppSizer.horizontal15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    child: MySofiaSansText(
                      text: heading.appCapitalize,
                      fontSize: AppSizer.fontSize14,
                      height: width * 0.0027,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  SizedBox(
                    width: width * 0.8,
                    child: MyManropeText(
                      text: subHeading.appCapitalize,
                      height: width * 0.0036,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSizer.fontSize11,
                      color: AppColor.white.withOpacity(0.8),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
