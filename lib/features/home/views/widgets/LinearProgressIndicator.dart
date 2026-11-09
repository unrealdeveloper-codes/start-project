import 'package:desa/features/home/controllers/home_water_controller.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class LinearProgressExample extends StatelessWidget {
  const LinearProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomeWaterController.intance;
    return Obx(() {
      final data = controller.waterGoal.data;
      final progress = controller.waterGoal.data?.percentage;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyManropeText(
                text:
                    '${Utils.formateProgress(controller.waterGoal.data?.percentage ?? 0)}% Completed',
                color: AppColor.greyTextColor,
              ),
              MyManropeText(
                text: 'Goal: ${Utils.mlToLiters(data?.totalGoal ?? 0)} L',
                color: AppColor.greyTextColor,
              ),
            ],
          ),
          SizedBox(height: AppSizer.height * 0.01),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: LinearProgressIndicator(
              value: (progress ?? 0) / 100,
              minHeight: AppSizer.height * .013,
              backgroundColor: AppColor.primaryColor4,
              color: AppColor.primaryColor2,
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ],
      );
    });
  }
}
