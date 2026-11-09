import 'package:desa/features/water/controllers/water_goal_controller.dart';
import 'package:desa/features/water/view/widgets/water_moniter_graph_section.dart';
import 'package:desa/features/water/view/widgets/water_moniter_today_intake_section.dart';
import 'package:desa/features/water/view/widgets/water_monitor_record_water_section.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/buttons/how_we_make_recommendations_button.dart';
import 'package:desa/utils/components/container/disclaimer_container.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/loaders/loader/animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class WaterMonitorScreen extends StatelessWidget {
  const WaterMonitorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final waterGoalController = Get.put(WaterGoalController());

    waterGoalController.fetchWaterGoal(context);
    // Example refresh function
    Future<void> refreshData() async {
      waterGoalController.refershAllData(context);
    }

    return Scaffold(
      appBar: const TransparentAppBar(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: AppColor.primaryColor1,
        child: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: Obx(
            () {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // -- Headings
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizer.horizontal15,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MySofiaSansText(
                          text: AppStrings.waterMoniter,
                          fontSize: AppSizer.fontSize30,
                          fontWeight: FontWeight.w800,
                        ),
                        SizedBox(height: height * 0.01),
                        MyManropeText(
                          text: AppStrings.waterMoniterSubHeading,
                          color: AppColor.bodyTextColor,
                          height: width * 0.004,
                          fontWeight: FontWeight.w700,
                          fontSize: AppSizer.fontSize12,
                        ),
                      ],
                    ),
                  ),
                  if (waterGoalController.isGoalLoading) ...[
                    SizedBox(
                      height: height * 0.75,
                      child: const Center(
                        child: AnimatedLoading(
                          text: "Loading Water Intake",
                        ),
                      ),
                    )
                  ] else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // -- Water Monitor
                        const WaterMonitorRecordWaterSection(),
                        // -- Today Intake
                        const WaterMoniterTodayIntakeSection(),
                        const DisclaimerContainer(
                            disclaimer:
                                'If on any fluid restrictions due to other medical conditions follow those guides'),
                        // -- Graph Section
                        const WaterMoniterGraphSection(),
                        const RecommendationsButton(),
                        SizedBox(height: height * 0.03),
                      ],
                    )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildHeading(String text) {
    return MyManropeText(
      text: text,
      color: AppColor.primaryColor1,
      fontWeight: FontWeight.w900,
      fontSize: AppSizer.fontSize14,
    );
  }
}
