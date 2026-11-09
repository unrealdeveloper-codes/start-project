import 'package:desa/features/water/controllers/water_intake_controller.dart';
import 'package:desa/utils/components/container/customeContiner.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WaterMoniterTodayIntakeSection extends StatelessWidget {
  const WaterMoniterTodayIntakeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = Get.put(WaterIntakeController(context));
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.horizontal15,
        vertical: AppSizer.vertical10,
      ),
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.01,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.08),
              blurRadius: 6,
            )
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.01),
              MyManropeText(
                text: "Today's Intake",
                color: AppColor.primaryColor1,
                fontWeight: FontWeight.w900,
                fontSize: AppSizer.fontSize14,
              ),
              SizedBox(height: height * 0.02),
              if (controller.isLoading) ...[
                SizedBox(
                  height: height * 0.2,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor1,
                    ),
                  ),
                )
              ] else if (controller.errorMessage != "") ...[
                ErrorDisplay(
                  onTap: () => controller.fetchWaterGoal(context),
                  errorMessage: controller.errorMessage,
                  boxHeight: height * 0.2,
                ),
              ] else if (controller.waterIntake.data == null ||
                  controller.waterIntake.data!.isEmpty) ...[
                Container(
                  width: width,
                  padding: EdgeInsets.symmetric(
                    vertical: AppSizer.vertical10,
                    horizontal: width * 0.16,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width * 0.02),
                      border: Border.all(
                          color: AppColor.greyTextColor.withOpacity(0.2))),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        AppSvg.glassIcon,
                        width: width * 0.14,
                      ),
                      SizedBox(height: height * 0.012),
                      MyManropeText(
                        text:
                            "No Water Logged Yet \nTime to Hydrate Your Body!",
                        color: AppColor.primaryColor1,
                        height: width * 0.0044,
                        fontWeight: FontWeight.w900,
                        fontSize: AppSizer.fontSize14,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                SizedBox(height: height * 0.01),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: controller.viewAllLogs
                      ? controller.waterIntake.data?.length
                      : (controller.waterIntake.data!.length > 5
                          ? 5
                          : controller.waterIntake.data!.length),
                  //   itemCount: controller.waterIntake.data?.length,
                  itemBuilder: (context, index) {
                    final data = controller.waterIntake.data![index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(AppSvg.glass),
                            SizedBox(width: width * 0.03),
                            MyManropeText(
                              text: data.time ?? "",
                              fontSize: AppSizer.fontSize14,
                              fontWeight: FontWeight.w800,
                            ),
                            const Spacer(),
                            MyManropeText(
                              text: data.glassSize ?? "",
                              fontSize: AppSizer.fontSize14,
                              color: AppColor.bodyTextColor,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                        Visibility(
                          visible: controller.viewAllLogs
                              ? index != controller.waterIntake.data!.length - 1
                              : index < 4
                                  ? index !=
                                      controller.waterIntake.data!.length - 1
                                  : index != 4,
                          child: Divider(
                            thickness: 1.5,
                            color: AppColor.bodyTextColor.withOpacity(0.2),
                            height: height * 0.04,
                          ),
                        ),
                      ],
                    );
                  },
                ),
                if (controller.waterIntake.data!.length > 5) ...[
                  SizedBox(height: height * 0.01),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: controller.toogleViewAllLogs,
                      child: MyManropeText(
                        text:
                            controller.viewAllLogs ? "Show Less" : "View More",
                        color: AppColor.primaryColor1,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSizer.fontSize12,
                      ),
                    ),
                  ),
                ] else
                  SizedBox(height: height * 0.01),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
