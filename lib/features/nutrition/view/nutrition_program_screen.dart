import 'package:desa/features/nutrition/controller/nutrition_program_controller.dart';
import 'package:desa/utils/cards/Image_title_subtitle_card.dart';

import 'package:desa/utils/components/buttons/how_we_make_recommendations_button.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_images.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../utils/components/warning_dispaly.dart';

class NutritionProgramScreen extends StatelessWidget {
  final String id;

  const NutritionProgramScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NutritionProgramController());
    Future.microtask(() => controller.fetchNutritionPrograms(id));
    return Obx(() {
      return ReusableScreenStructure(
        title: controller.isLoading.value
            ? ""
            : controller.nutritionProgramData.value?.data?.heading ?? "",
        isHeadingVisible: controller.isLoading.value == false,
        bgSvg: AppSvg.fitnessCategoryBg,
        bodyContent: _buildBodyContent(context, controller),
      );
    });
  }

  Widget _buildBodyContent(
    BuildContext context,
    NutritionProgramController controller,
  ) {
    if (controller.isLoading.value) {
      // Shimmer Loading
      return _buildShimmerScreen(AppSizer.height, AppRes.width);
    } else if (controller.errorMessage.isNotEmpty) {
      // Error Display
      return ErrorDisplay(
        errorMessage: controller.errorMessage.value,
        onTap: () => controller.fetchNutritionPrograms(id), // Retry logic
      );
    } else if (controller.nutritionProgramData.value?.data == null) {
      // Warning Display
      return const WarningDisplay(
        warningMessage: "No nutrition program data available.",
      );
    } else {
      // Actual Content
      return _buildNutritionProgramContent(context, controller);
    }
  }

  Widget _buildShimmerScreen(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer for heading
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: AppRes.width * 0.7, // Adjust width for heading
            height: height * 0.05,
            margin: EdgeInsets.only(bottom: height * 0.01),
            decoration: BoxDecoration(
              color: AppColor.shimmerContentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        SizedBox(height: height * 0.02),
        // Shimmer for subheading
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4, // Simulate three list items
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: height * 0.02),
              child: Shimmer.fromColors(
                baseColor: AppColor.shimmerBaseColor,
                highlightColor: AppColor.shimmerHighlightColor,
                child: Container(
                  width: AppSizer.width, // Adjust width for list item heading
                  height: height * 0.09,
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

  Widget _buildNutritionProgramContent(
    BuildContext context,
    NutritionProgramController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: AppSizer.height * 0.012),
        _buildIntroductionSection(context),
        _buildApprovedFoodsSection(context),
        _buildNonApprovedFoodsSection(context),
        _buildDietMealPlanSection(context),
        SizedBox(height: AppSizer.height * 0.01),
        const RecommendationsButton(),
      ],
    );
  }

  Widget _buildIntroductionSection(BuildContext context) {
    return ImageTitleSubtitleCard(
      svg: AppSvg.introductionIcon,
      heading: AppStrings.introductionHeading,
      subHeading: AppStrings.introductionSubheading,
      onTap: () => context.push(
        AppRoutes.introductionScreen,
        extra: {
          'from': "nutrition",
          'id': id.toString(),
        },
      ),
      //     context.push(
      //   AppRoutes.introductionScreen,
      //   extra: id,
      // ),
      // onTap: () =>
      //     context.push(AppRoutes.introductionScreen, extra: {'id': id}),
    );
  }

  Widget _buildApprovedFoodsSection(BuildContext context) {
    return ImageTitleSubtitleCard(
      svg: AppSvg.approvedFoodIcon,
      heading: AppStrings.approvedFoodsHeading,
      subHeading: AppStrings.approvedFoodsSubheading,
      onTap: () => context.push(
        AppRoutes.APPROVE_NON_APPROVE_FOOD_SCREEN,
        extra: {'isApproved': true, "id": id.toString()},
      ),
    );
  }

  Widget _buildNonApprovedFoodsSection(BuildContext context) {
    return ImageTitleSubtitleCard(
      svg: AppSvg.nonApprovedFoodIcon,
      heading: AppStrings.nonApprovedFoodsHeading,
      subHeading: AppStrings.nonApprovedFoodsSubheading,
      onTap: () => context.push(
        AppRoutes.APPROVE_NON_APPROVE_FOOD_SCREEN,
        extra: {'isApproved': false, "id": id.toString()},
      ),
    );
  }

  Widget _buildDietMealPlanSection(BuildContext context) {
    return ImageTitleSubtitleCard(
      svg: AppSvg.dietMealPlanIcon,
      heading: AppStrings.dietMealPlanHeading,
      subHeading: AppStrings.dietMealPlanSubheading,
      onTap: () => context.push(
        AppRoutes.DIET_MEAL_PLAN_RECIPES_SCREEN,
        extra: {'id': id}, // Pass the id as an extra argument
      ),
    );
  }
}
