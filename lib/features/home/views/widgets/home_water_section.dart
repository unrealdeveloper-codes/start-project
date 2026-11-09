import 'package:desa/features/home/controllers/home_controller.dart';
import 'package:desa/features/home/controllers/home_water_controller.dart';
import 'package:desa/features/home/views/widgets/LinearProgressIndicator.dart';
import 'package:desa/features/home/views/widgets/water_intake_circle.dart';
import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/container/customeContiner.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:desa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeWaterSection extends StatelessWidget {
  const HomeWaterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController.instance;
    final waterGoalController = Get.put(HomeWaterController(context));
    waterGoalController.fetchWaterGoal();

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return CustomContainer(
      color: AppColor.cardBackGroundBlueColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(
                AppStrings.waterMonitorTitle,
                AppStrings.viewReport,
                width,
                () {
                  context.push(AppRoutes.waterMonitorScreen);
                },
              ),
              SizedBox(height: height * 0.007),
              SizedBox(
                width: width * 0.8,
                child: MyManropeText(
                  text: AppStrings.waterMonitorSubtitle,
                  color: AppColor.greyTextColor,
                  fontSize: AppSizer.fontSize13,
                ),
              ),
              SizedBox(height: height * 0.03),
              if (waterGoalController.isGoalLoading) ...[
                SizedBox(
                  height: height * 0.068,
                  child: Shimmer.fromColors(
                    baseColor: AppColor.shimmerBaseColor,
                    highlightColor: AppColor.shimmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.shimmerContentColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.024),
                SizedBox(
                  height: height * 0.026,
                  child: Shimmer.fromColors(
                    baseColor: AppColor.shimmerBaseColor,
                    highlightColor: AppColor.shimmerHighlightColor,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColor.shimmerContentColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.024),
                Align(
                  alignment: Alignment.bottomRight,
                  child: SizedBox(
                    height: height * 0.05,
                    child: Shimmer.fromColors(
                      baseColor: AppColor.shimmerBaseColor,
                      highlightColor: AppColor.shimmerHighlightColor,
                      child: Container(
                        width: width * 0.4,
                        decoration: BoxDecoration(
                          color: AppColor.shimmerContentColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                ),
              ] else if (waterGoalController.waterGoalErrorMessage != "") ...[
                ErrorDisplay(
                  onTap: () => waterGoalController.fetchWaterGoal(),
                  errorMessage: waterGoalController.waterGoalErrorMessage,
                  boxHeight: height * 0.28,
                )
              ] else ...[
                // -- Glass Selection + Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    controller.waterAmounts.length,
                    (index) {
                      return GestureDetector(
                        onTap: () =>
                            waterGoalController.updateSelectedIndex(index),
                        child: WaterIntakeCircle(
                          waterAmount:
                              waterGoalController.waterGlassSize[index],
                          isSelected:
                              waterGoalController.selectedIndex.value == index,
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: height * 0.03),
                const LinearProgressExample(),
                SizedBox(height: height * 0.016),
                // -- Record Button + Total
                Obx(() {
                  final total = Utils.mlToLiters(
                      waterGoalController.waterGoal.data?.completedGoal ?? 0);
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyManropeText(
                        text: "Total: $total L",
                        color: AppColor.greyTextColor,
                      ),
                      waterGoalController.isRecordingWater
                          ? SizedBox(
                              height: height * 0.054,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(
                                    width: width * 0.05,
                                    height: width * 0.05,
                                    child: const CircularProgressIndicator(
                                      color: AppColor.primaryColor1,
                                      strokeWidth: 3,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.04),
                                  MyManropeText(
                                    text: "Recording Water...",
                                    fontSize: AppSizer.fontSize10,
                                    color: AppColor.primaryColor1,
                                  )
                                ],
                              ),
                            )
                          : CustomeButton(
                              text: AppStrings.recordWaterButtonText
                                  .toUpperCase(),
                              colour:
                                  waterGoalController.selectedIndex.value == -1
                                      ? AppColor.primaryColor4
                                      : null,
                              textColour:
                                  waterGoalController.selectedIndex.value == -1
                                      ? AppColor.primaryColor1
                                      : null,
                              onPressed: () =>
                                  waterGoalController.recordWater(),
                              horizontalPadding: width * 0.035,
                              verticalPadding: AppSizer.height * 0.001,
                              transparent:
                                  waterGoalController.selectedIndex.value != -1,
                              borderRadius: width * 0.012,
                              borderWidth: width * 0.002,
                              textSize: AppSizer.fontSize10,
                            ),
                    ],
                  );
                })
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    String title,
    String actionText,
    double width,
    VoidCallback ontap,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyManropeText(
          text: title,
          fontWeight: FontWeight.w800,
          fontSize: AppSizer.fontSize18,
          height: 0,
        ),
        InkWell(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: MyManropeText(
              text: actionText,
              fontWeight: FontWeight.w800,
              fontSize: AppSizer.fontSize11,
              color: AppColor.primaryColor2,
            ),
          ),
        ),
      ],
    );
  }
}
