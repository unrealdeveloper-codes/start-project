import 'package:desa/features/water/controllers/water_goal_controller.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterProgressSection extends StatelessWidget {
  const WaterProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = WaterGoalController.intance;
    return Obx(() {
      final data = controller.waterGoal.data;
      return Column(
        children: [
          SizedBox(height: height * 0.1),
          MySofiaSansText(
            text: "${Utils.mlToLiters(data?.completedGoal ?? 0)} L",
            fontSize: AppSizer.fontSize34,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF009DEE),
          ),
          SizedBox(height: height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyManropeText(
                text: "${controller.waterGoal.data?.percentage}% Completed",
                color: AppColor.bodyTextColor.withOpacity(0.5),
                height: width * 0.004,
                fontWeight: FontWeight.w600,
                fontSize: AppSizer.fontSize13,
              ),
              SizedBox(width: width * 0.02),
              MyManropeText(
                text: "Goal: ${Utils.mlToLiters(data?.totalGoal ?? 0)}L",
                color: AppColor.bodyTextColor,
                height: width * 0.004,
                fontWeight: FontWeight.w800,
                fontSize: AppSizer.fontSize13,
              ),
            ],
          ),
        ],
      );
    });
  }
}
