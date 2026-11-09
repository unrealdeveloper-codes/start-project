import 'package:desa/features/nutrition/controller/diet_meal_plan_controller.dart';
import 'package:desa/features/nutrition/models/about_food_model.dart';
import 'package:desa/utils/cards/image_title_card.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class DietMealPlanAndRecipesScreen extends StatelessWidget {
  final String id;

  const DietMealPlanAndRecipesScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final DietMealPlanController controller = Get.put(DietMealPlanController());
    Future.microtask(() => controller.fetchDietMealPlan(id));
    return ReusableScreenStructure(
      title: "Diet Meal Plan / Recipes",
      bodyContent: Obx(() {
        if (controller.isLoading.value) {
          // Loading state
          return _buildShimmerList();
        } else if (controller.errorMessage.isNotEmpty) {
          // Error state
          return ErrorDisplay(
            errorMessage: controller.errorMessage.value,
            onTap: () => controller.fetchDietMealPlan(id), // Retry logic
          );
        } else if (controller.dietMealPlanListData.value?.data == null ||
            controller.dietMealPlanListData.value!.data!.isEmpty) {
          // No data state
          return WarningDisplay(
            boxHeight: AppSizer.height * 0.7,
            iconPath: 'assets/nutritionIcons/dietPlanSvg.svg',
            warningMessage: "No Diet Plan Yet",
            subWarningMessage:
                'Create your nutrition plan to achieve your health goals.',
          );
        } else {
          // Data rendering state
          final items = controller.dietMealPlanListData.value!.data!;
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            itemCount: items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = items[index];
              return ImageTitleCard(
                  onTap: () {
                    context.push(
                      AppRoutes.WEAK_DIET_MEAL_PLAN_SCREEN,
                      extra: {'id': id, 'weak': item.week},
                    );
                  },
                  heading: "${item.week!} week",
                  svg: 'assets/nutritionIcons/index_icon.svg',
                  number: (index + 1).toString());
            },
          );
        }
      }),
    );
  }

  Widget _buildShimmerList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 4,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizer.height * 0.012),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: AppSizer.height * 0.078,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}
