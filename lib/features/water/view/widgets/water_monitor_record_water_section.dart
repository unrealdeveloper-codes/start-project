import 'package:desa/features/water/controllers/water_goal_controller.dart';
import 'package:desa/features/water/controllers/wave_animation_controller.dart';
import 'package:desa/features/water/view/widgets/record_water_section.dart';
import 'package:desa/features/water/view/widgets/water_progess_section.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_images.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/loaders/loader/animated_loader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WaterMonitorRecordWaterSection extends StatelessWidget {
  const WaterMonitorRecordWaterSection({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    // final controller = Get.put(WaterGoalController(context));
    final controller = WaterGoalController.intance;
    final waveController = Get.put(WaveController(context));
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.04),
      child: Obx(() {
        return SizedBox(
          height: controller.isGoalLoading ? height * 0.8 : height * 0.5,
          child: Column(
            children: [
              if (controller.isGoalLoading) ...[
                // const AnimatedLoading(
                //   text: "Loading Water Intake...",
                // )
                SizedBox(
                  height:
                      controller.isGoalLoading ? height * 0.65 : height * 0.5,
                  child: const Center(
                    child: AnimatedLoading(
                      text: "Loading Water Intake",
                    ),
                  ),
                )
              ] else if (controller.waterGoalErrorMessage != "") ...[
                ErrorDisplay(
                  onTap: () => controller.fetchWaterGoal(context),
                  errorMessage: controller.waterGoalErrorMessage,
                  boxHeight: height * 0.5,
                )
              ] else
                Expanded(
                  child: Stack(
                    children: [
                      // Animated Wave 1
                      AnimatedBuilder(
                        animation: waveController.wave1Controller,
                        builder: (context, child) {
                          final offset =
                              (waveController.wave1Controller.value * width) -
                                  width;
                          return AnimatedBuilder(
                            animation: waveController.waveHeightAnimation,
                            builder: (context, child) {
                              return Positioned(
                                left: offset,
                                bottom:
                                    waveController.waveHeightAnimation.value,
                                child: Image.asset(
                                  AppImages.wave1,
                                  width: width * 2,
                                  height: height * 0.24,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      // Animated Wave 2
                      AnimatedBuilder(
                        animation: waveController.wave2Controller,
                        builder: (context, child) {
                          final offset =
                              (1 - waveController.wave2Controller.value) *
                                  width;
                          return AnimatedBuilder(
                            animation: waveController.waveHeightAnimation,
                            builder: (context, child) {
                              return Positioned(
                                left: offset - width,
                                bottom:
                                    waveController.waveHeightAnimation.value,
                                child: Image.asset(
                                  AppImages.wave2,
                                  width: width * 2,
                                  height: height * 0.24,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          );
                        },
                      ),
                      // -- Background Animated Container
                      // Positioned(
                      //   bottom: 0,
                      //   child: AnimatedBuilder(
                      //     animation: waveController.containerHeightAnimation,
                      //     builder: (context, child) {
                      //       return Container(
                      //         width: width,
                      //         height: height *
                      //             waveController.containerHeightAnimation.value,
                      //         decoration: BoxDecoration(
                      //           gradient: LinearGradient(
                      //             begin: Alignment.topCenter,
                      //             end: Alignment.bottomCenter,
                      //             colors: [
                      //               const Color(0xFF26A6FE).withOpacity(0.0),
                      //               const Color(0xFF26A6FE).withOpacity(0.0),
                      //               const Color(0xFF26A6FE).withOpacity(0.2),
                      //               const Color(0xFF26A6FE).withOpacity(0.2),
                      //               const Color(0xFF26A6FE).withOpacity(0.1),
                      //               const Color(0xFF26A6FE).withOpacity(0.1),
                      //               const Color(0xFF26A6FE).withOpacity(0.05),
                      //               const Color(0xFF26A6FE).withOpacity(0.01),
                      //             ],
                      //           ),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                      // -- Progress
                      const WaterProgressSection(),

                      // -- Record Water
                      Positioned(
                        bottom: height * 0.02,
                        left: AppSizer.horizontal20,
                        right: AppSizer.horizontal20,
                        child: const RecordWaterSection(),
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
      }),
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
