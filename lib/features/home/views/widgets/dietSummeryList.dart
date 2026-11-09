import 'package:desa/features/home/controllers/home_controller.dart';
import 'package:desa/features/home/views/widgets/diet_summery_container.dart';
import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DietSummaryList extends StatelessWidget {
  final PageController _pageController = PageController(viewportFraction: 0.88);
  final List<Color> progressColors = [
    AppColor.caloriesRed,
    AppColor.proteinBlue,
    AppColor.fatsYellow,
    AppColor.carbsGreen,
  ];

  DietSummaryList({super.key});

  @override
  Widget build(BuildContext context) {
    MyNutritionDiaryController controller =
        Get.put(MyNutritionDiaryController());
    Future.microtask(() => controller.fetchTodayDietSummaryData()); // Ensure data fetch starts immediately
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          width: width,
          height: height * 0.14,
          child: Obx(() {
            if (controller.isLoadingTodayDietSummary.value) {
              // Shimmer effect for loading
              return _buildShimmerEffect(width, height);
            } else if (controller.errorMessageTodayDietSummary.isNotEmpty) {
              // Error state with retry logic
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyManropeText(
                    text: 'Oops! Something Went Wrong.',
                    fontWeight: FontWeight.w800,
                    fontSize: AppSizer.fontSize14,
                    color: Colors.red,
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: MyManropeText(
                      text: controller.errorMessageTodayDietSummary.value,
                      textAlign: TextAlign.center,
                      fontSize: AppSizer.fontSize11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.greyTextColor,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),

                  SizedBox(
                    height: height * 0.04,
                    child: CustomeButton(
                      text: "Try Again".toUpperCase(),
                      colour: AppColor.primaryColor4,
                      textColour: AppColor.primaryColor1,
                      onPressed: () {
                        controller.fetchTodayDietSummaryData();
                      },
                      // Pass the onTap callback
                      horizontalPadding: width * 0.035,
                      verticalPadding: height * 0.00,
                      transparent: true,
                      borderRadius: width * 0.012,
                      borderWidth: width * 0.002,
                      textSize: AppSizer.fontSize10,
                    ),
                  ),
                  // ErrorDisplay(
                  //   boxHeight: height*0.4,
                  //   errorMessage: controller.errorMessageDietSummary.value,
                  //   onTap: () => controller.fetchDietSummaryData(),
                  // ),
                ],
              );
            } else if (controller.dietSummaries.isEmpty) {
              // No data state
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyManropeText(
                    text: 'No diet summaries available',
                    fontWeight: FontWeight.w800,
                    fontSize: AppSizer.fontSize14,
                    color: Colors.yellow.shade900,
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  SizedBox(
                    width: width * 0.6,
                    child: MyManropeText(
                      text: "Please check back later or try again.",
                      textAlign: TextAlign.center,
                      fontSize: AppSizer.fontSize11,
                      fontWeight: FontWeight.w600,
                      color: AppColor.greyTextColor,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                ],
              );

              //   const WarningDisplay(
              //   warningMessage: "No diet summaries available.",
              // );
            } else {
              // Data rendering state

              return PageView.builder(
                controller: _pageController,
                padEnds: false,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: controller.dietSummaries.length,
                itemBuilder: (context, index) {
                  final summary = controller.dietSummaries[index];
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DietSummaryContainer(
                          title: summary.title,
                          mainContent: summary.mainContent,
                          subtitle: summary.subtitle,
                          progress: summary.progress,
                          progressColor: progressColors[index],
                        ),
                        if (index != controller.dietSummaries.length - 1) ...[
                          SizedBox(width: width * 0.012),
                          VerticalDivider(
                            indent: height * 0.016,
                            endIndent: height * 0.016,
                          ),
                        ],
                      ],
                    ),
                  );
                },
              );
            }
          }),
        ),

        SizedBox(height: height * 0.02),
        Obx(() {
          int itemCount = controller.dietSummaries.isEmpty
              ? 0
              : controller.dietSummaries.length;

          // Ensure itemCount is not NaN or Infinity
          itemCount = itemCount.isFinite ? itemCount : 0;

          return controller.isLoadingTodayDietSummary.value
              ? SizedBox()
              : SmoothPageIndicator(
                  controller: _pageController,
                  count: itemCount, // Ensure count is a valid integer
                  effect: ExpandingDotsEffect(
                    expansionFactor: 3,
                    dotHeight: 4,
                    dotWidth: 10,
                    activeDotColor: AppColor.primaryColor1,
                    dotColor: AppColor.primaryColor2.withOpacity(0.3),
                  ),
                );
        }),

        // Obx(() {
        //   return SmoothPageIndicator(
        //     controller: _pageController,
        //     count: controller.dietSummaries.length,
        //     effect: ExpandingDotsEffect(
        //       expansionFactor: 3,
        //       dotHeight: 4,
        //       dotWidth: 10,
        //       activeDotColor: AppColor.primaryColor1,
        //       dotColor: AppColor.primaryColor2.withOpacity(0.3),
        //     ),
        //   );
        // }),
      ],
    );
  }

  Widget _buildShimmerEffect(double width, double height) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: width * 0.02),
          child: Shimmer.fromColors(
            baseColor: AppColor.shimmerBaseColor,
            highlightColor: AppColor.shimmerHighlightColor,
            child: Container(
              width: width * 0.67,
              decoration: BoxDecoration(
                color: AppColor.shimmerContentColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
