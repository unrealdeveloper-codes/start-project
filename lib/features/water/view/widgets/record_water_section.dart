import 'package:desa/features/water/controllers/water_goal_controller.dart';
import 'package:desa/features/water/view/widgets/water_intake_circle.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecordWaterSection extends StatelessWidget {
  const RecordWaterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = WaterGoalController.intance;
    return Obx(
      () {
        final isSelected = controller.selectedIndex.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyManropeText(
              text: "Select Glass Size",
              color: AppColor.primaryColor1,
              fontWeight: FontWeight.w900,
              fontSize: AppSizer.fontSize14,
            ),
            SizedBox(
              height: height * 0.1,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: controller.waterGlassSize.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: width * 0.035),
                    child: WaterIntakeCircle(
                      onTap: () => controller.updateSelectedIndex(index),
                      waterAmount: controller.waterGlassSize[index],
                      isSelected: isSelected == index,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: height * 0.02),
            Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: () => controller.recordWater(context),
                child: controller.isRecordingWater
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
                    : Container(
                        width: width * 0.4,
                        height: height * 0.054,
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizer.horizontal20,
                          vertical: AppSizer.vertical5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: isSelected != -1
                                ? AppColor.primaryColor1
                                : AppColor.primaryColor1.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                          color: isSelected != -1
                              ? AppColor.cardBackGroundBlueColor
                              : null,
                        ),
                        child: Center(
                          child: MyManropeText(
                            text: "Record Water",
                            color: isSelected != -1
                                ? AppColor.primaryColor1
                                : AppColor.primaryColor1.withOpacity(0.4),
                            fontWeight: FontWeight.w800,
                            fontSize: AppSizer.fontSize14,
                          ),
                        ),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
