import 'package:desa/features/water/controllers/water_intake_graph_controller.dart';
import 'package:desa/features/water/view/widgets/water_summary_chart.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class WaterMoniterGraphSection extends StatefulWidget {
  const WaterMoniterGraphSection({super.key});

  @override
  State<WaterMoniterGraphSection> createState() => _WaterMoniterGraphSectionState();
}

class _WaterMoniterGraphSectionState extends State<WaterMoniterGraphSection> {
  late WaterIntakeGraphController controller;

  @override
  void initState() {
    controller = Get.put(WaterIntakeGraphController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;


    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizer.horizontal15,
        vertical: AppSizer.vertical10,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
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
            children: [
              // -- Heading and Select Week Button
              Row(
                children: [
                  MyManropeText(
                    text: "Water Summary",
                    color: AppColor.primaryColor1,
                    fontWeight: FontWeight.w900,
                    fontSize: AppSizer.fontSize14,
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () => controller.selectWeek(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColor.cardBackGroundBlueColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.01),
                          SvgPicture.asset(
                            AppSvg.calenderIcon,
                            width: width * 0.045,
                          ),
                          SizedBox(width: width * 0.02),
                          MyManropeText(
                            text: "Select Week",
                            color: AppColor.selectDateCalendarFontColor,
                            height: width * 0.004,
                            fontWeight: FontWeight.w700,
                            fontSize: AppSizer.fontSize12,
                          ),
                          SizedBox(width: width * 0.01),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // -- If Loading
              if (controller.isLoading) ...[
                SizedBox(
                  height: height * 0.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              ]
              // If Error
              else if (controller.errorMessage != "") ...[
                ErrorDisplay(
                  onTap: () => controller.fetchWaterIntake(context),
                  errorMessage: controller.errorMessage,
                  boxHeight: height * 0.3,
                )
              ] else if (controller.waterIntake.chartConfig == null ||
                  controller.waterIntake.chartConfig!.data == null ||
                  controller.waterIntake.chartConfig!.data!.isEmpty) ...[
                WarningDisplay(
                  boxHeight: height * 0.3,
                  iconPath: 'assets/progress/svgs/noWaterYet.svg',
                  warningMessage: 'No Water Data Yet!',
                  subWarningMessage:
                  'Track your daily water intake to maintain hydration.',
                ),
              ]
              // -- Content
              else ...[
                SizedBox(height: height * 0.026),
                Visibility(
                  visible: controller.weekStartDate != "",
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: AppSizer.width * 0.28,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.cardBackGroundBlueColor),
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColor.primaryColor1,
                        ),
                        child: Center(
                          child: MyManropeText(
                            text: controller.weekStartDate,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: AppSizer.fontSize12,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: MyManropeText(
                          text: "To",
                          fontWeight: FontWeight.w800,
                          fontSize: AppSizer.fontSize14,
                        ),
                      ),
                      Container(
                        width: AppSizer.width * 0.28,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 7),
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: AppColor.cardBackGroundBlueColor),
                          borderRadius: BorderRadius.circular(8.0),
                          color: AppColor.primaryColor1,
                        ),
                        child: Center(
                          child: MyManropeText(
                            text: controller.weekEndDate,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: AppSizer.fontSize12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.01),
                const WaterSummaryChart(),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
