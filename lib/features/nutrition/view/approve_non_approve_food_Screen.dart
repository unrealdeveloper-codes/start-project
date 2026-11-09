import 'package:desa/features/nutrition/controller/approve_non_approve_food_controller.dart';
import 'package:desa/utils/cards/image_title_card.dart';

import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/resuableScreenStructure/resuable_screen_structure.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/constants/app_colors.dart';

class ApproveNonApproveFoodScreen extends StatelessWidget {
  final bool isApprove;
  final String id;

  const ApproveNonApproveFoodScreen({
    super.key,
    required this.isApprove,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApproveNonApproveFoodController());
    Future.microtask(
        () => controller.fetchApproveNonApproveFood(id, isApprove));

    return ReusableScreenStructure(
      title: isApprove ? "Approved Food" : "Non Approved Food",
      bodyContent: Obx(() {
        if (controller.isLoading.value) {
          // Loading state
          return _buildShimmerList();
        } else if (controller.errorMessage.isNotEmpty) {
          // Error state
          return ErrorDisplay(
            errorMessage: controller.errorMessage.value,
            onTap: () => controller.fetchApproveNonApproveFood(
                id, isApprove), // Retry logic
          );
        } else if (controller.approveNonApproveFoodDataList.value?.data ==
                null ||
            controller.approveNonApproveFoodDataList.value!.data!.isEmpty) {
          // No data state
          return WarningDisplay(
            boxHeight: AppSizer.height * 0.7,
            iconPath: 'assets/nutritionIcons/noMealSvg.svg',
            warningMessage: "No Meals Planned Yet!",
            subWarningMessage:
                'Start by adding your meals for the day to stay on track with your nutrition goals.',
          );
        } else {
          // Data rendering state
          final items = controller.approveNonApproveFoodDataList.value!.data!;
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
                    AppRoutes.FOOD_DETAIL_SCREEN,
                    extra: {
                      'isApproved': isApprove,
                      'id': item.id.toString(),
                      'programId': id.toString(),
                    },
                  );
                },
                heading: item.name!,
                svg: item.image!,
              );
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
            baseColor: AppColor.shimmerBaseColor,
            highlightColor: AppColor.shimmerHighlightColor,
            child: Container(
              height: AppSizer.height * 0.078,
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
