import 'package:desa/features/nutrition/controller/food_list_plan_controller.dart';
import 'package:desa/features/nutrition/models/food_list_plan_model.dart';
import 'package:desa/utils/cards/Image_title_subtitle_card.dart';

import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/container/disclaimer_container.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class FoodListPlanScreen extends StatelessWidget {
  final String id;
  final String weak;
  final String mealType;
  final String day;

  const FoodListPlanScreen({
    super.key,
    required this.id,
    required this.weak,
    required this.mealType,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    final FoodListPlanController controller = Get.put(FoodListPlanController());
    // Fetch data dynamically
    Future.microtask(
        () => controller.fetchFoodListPlanData(id, mealType, weak, day));

    var height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: const TransparentAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.horizontal22,
            vertical: AppSizer.vertical10,
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              // Show shimmer effect during loading
              return _buildShimmerEffect(height);
            } else if (controller.errorMessage.isNotEmpty) {
              // Show error display
              return ErrorDisplay(
                errorMessage: controller.errorMessage.value,
                boxHeight: height * 0.75,
                onTap: () => controller.fetchFoodListPlanData(
                    id, mealType, weak, day), // Retry logic
              );
            } else if (controller.foodListPlanData.value?.data == null ||
                controller.foodListPlanData.value!.data!.meals!.isEmpty) {
              // Show warning if no data is available
              return WarningDisplay(
                boxHeight: AppSizer.height * 0.7,
                iconPath: 'assets/nutritionIcons/dietPlanSvg.svg',
                warningMessage: "No Diet Plan Yet",
                subWarningMessage:
                    'Create your nutrition plan to achieve your health goals.',
              );
            } else {
              Data? data = controller.foodListPlanData.value?.data;
              // Render the actual content
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyManropeText(
                    text: data?.heading ?? "",
                    fontSize: AppSizer.fontSize20,
                    fontWeight: FontWeight.w900,
                    maxLines: 2,
                  ),
                  SizedBox(height: height * 0.01),
                  ExpandableText(description: data?.subheading ?? ""),
                  if (data?.heading != null &&
                      data!.heading!.contains("Snacks")) ...[
                    SizedBox(height: height * 0.01),
                    RichText(
                      text: TextSpan(
                        style: GoogleFonts.manrope(
                          fontSize: AppSizer.fontSize13,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87, // Matches text color
                        ),
                        children: [
                          TextSpan(
                            text: 'Note: ',
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSizer.fontSize13,
                            ),
                          ),
                          const TextSpan(
                            text:
                                'Consume a single piece of fruit for morning tea, and reserve afternoon tea for vegetables only.',
                          ),
                        ],
                      ),
                    ),
                  ],
                  SizedBox(height: height * 0.035),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller
                          .foodListPlanData.value!.data!.meals!.length,
                      itemBuilder: (context, index) {
                        final meal = controller
                            .foodListPlanData.value!.data!.meals![index];
                        return ImageTitleSubtitleCard(
                          onTap: () {
                            context.push(AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
                                extra: {
                                  'id': meal.id.toString(),
                                  'mealType': mealType
                                });
                          },
                          heading: meal.meal!,
                          subHeading: '${meal.calories!} kcal',
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  /// Builds the shimmer effect for loading state
  Widget _buildShimmerEffect(double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer for heading
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: AppRes.width * 0.6, // Adjust width for heading
            height: height * 0.03,
            margin: EdgeInsets.only(bottom: height * 0.01),
            decoration: BoxDecoration(
              color: AppColor.shimmerContentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // Shimmer for subheading
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: AppRes.width * 0.45, // Adjust width for heading
            height: height * 0.02,
            margin: EdgeInsets.only(bottom: height * 0.035),
            decoration: BoxDecoration(
              color: AppColor.shimmerContentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // Shimmer for list items
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3, // Simulate three list items
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: height * 0.02),
              child: Shimmer.fromColors(
                baseColor: AppColor.shimmerBaseColor,
                highlightColor: AppColor.shimmerHighlightColor,
                child: Container(
                  width: AppSizer.width, // Adjust width for list item heading
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: AppColor.shimmerContentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
