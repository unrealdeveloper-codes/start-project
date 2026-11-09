import 'package:desa/features/fitness/controllers/fitness_session_controller.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/loaders/shimmer/fitness_session_shimmer.dart';
import 'package:desa/utils/videoPlayer/app_video_player_controller.dart';
import 'package:desa/utils/videoPlayer/video_player.dart';
import 'package:desa/utils/videoPlayer/video_player_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FitnessSessionScreen extends StatefulWidget {
  final String id;

  const FitnessSessionScreen({super.key, required this.id});

  @override
  State<FitnessSessionScreen> createState() => _FitnessSessionScreenState();
}

class _FitnessSessionScreenState extends State<FitnessSessionScreen> {
  @override
  void initState() {
    final controller = Get.put(FitnessSessionController());
    Get.put(AppVideoPlayerController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSession(context, widget.id);
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    // Restore orientation lock when leaving the screen
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = FitnessSessionController.instance;

    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            // If loading
            if (controller.isLoading) {
              return const FitnessSessionShimmer();
            }
            // If error
            else if (controller.sessionErrorMesssage != "") {
              return Column(
                children: [
                  const VideoPlayerBackButton(),
                  SizedBox(height: height * 0.04),
                  ErrorDisplay(
                    onTap: () => controller.fetchSession(context, widget.id),
                    errorMessage: controller.sessionErrorMesssage,
                    boxHeight: height * 0.7,
                  ),
                ],
              );
            }
            // If No Data
            else if (controller.session.steps == null ||
                controller.session.steps?.stepsPrograms == null) {
              return Column(
                children: [
                  const VideoPlayerBackButton(),
                  SizedBox(height: height * 0.04),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
                    child: WarningDisplay(
                      boxHeight: height * 0.72,
                      iconPath: 'assets/fitness/noFitness.svg',
                      warningMessage: 'Find Your Balance',
                      subWarningMessage:
                          'No active sessions yet. Join a fitness or mindfulness program to begin your journey.',
                    ),
                  ),
                ],
              );
            }
            // If Data
            else {
              final data = controller.session;
              return Column(
                children: [
                  Stack(
                    children: [
                      // -- Dummy Video Player
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          color: AppColor.grey.withOpacity(0.4),
                          width: width,
                        ),
                      ),
                      // -- Back Button
                      const VideoPlayerBackButton(),
                      // -- Video Player
                      const VideoPlayerScreen(),
                    ],
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizer.horizontal20,
                          vertical: AppSizer.vertical10,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // -- Heading and Time
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.6,
                                  child: MyManropeText(
                                    text: data.title?.appCapitalize ?? "",
                                    color: AppColor.primaryColor1,
                                    fontWeight: FontWeight.w900,
                                    fontSize: AppSizer.fontSize17,
                                  ),
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppSvg.clockIcon,
                                      width: width * 0.042,
                                    ),
                                    SizedBox(width: width * 0.012),
                                    MyManropeText(
                                      text:
                                          controller.getCurrentVideoDuration(),
                                      color: AppColor.bodyTextColor,
                                      fontWeight: FontWeight.w800,
                                      fontSize: AppSizer.fontSize11,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(height: height * 0.02),
                            ExpandableText(
                              description: data.description ?? "",
                              color: AppColor.bodyTextColor,
                              height: height * 0.0022,
                              fontWeight: FontWeight.w400,
                              fontSize: AppSizer.fontSize13,
                            ),
                            // -- Steps of session
                            if (controller
                                .getCurrentDescription()
                                .isNotEmpty) ...[
                              SizedBox(height: height * 0.02),
                              Obx(() {
                                final steps =
                                    controller.getCurrentDescription();
                                final showAll = controller.showAllSteps.value;
                                final visibleSteps =
                                    showAll ? steps : steps.take(2).toList();
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        MyManropeText(
                                          text: "Steps to complete session",
                                          color: AppColor.primaryColor1,
                                          fontWeight: FontWeight.w900,
                                          fontSize: AppSizer.fontSize17,
                                        ),
                                        const Spacer(),
                                        TextButton(
                                          onPressed:
                                              controller.toggleStepsVisibility,
                                          child: MyManropeText(
                                            text: showAll
                                                ? "View Less"
                                                : "View More",
                                            color: AppColor.primaryColor1
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.w700,
                                            fontSize: AppSizer.fontSize12,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.01),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: visibleSteps.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          child: MyManropeText(
                                            text:
                                                visibleSteps[index].steps ?? "",
                                            color: AppColor.greyTextColor,
                                            height: height * 0.0022,
                                            fontWeight: FontWeight.w400,
                                            fontSize: AppSizer.fontSize12,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: height * 0.02),
                                  ],
                                );
                              }),
                            ],

                            Divider(
                              color: AppColor.black.withOpacity(0.15),
                              thickness: 1.8,
                            ),
                            SizedBox(height: height * 0.02),
                            MyManropeText(
                              text: data.steps?.title ?? "",
                              color: AppColor.primaryColor1,
                              fontWeight: FontWeight.w900,
                              fontSize: AppSizer.fontSize17,
                            ),
                            SizedBox(height: height * 0.03),
                            Obx(() {
                              final selectedStep =
                                  controller.selectedStep.value;
                              return ListView.builder(
                                itemCount:
                                    data.steps?.stepsPrograms?.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final step =
                                      data.steps?.stepsPrograms?[index];
                                  return buildSections(
                                    context: context,
                                    index: "${index + 1}",
                                    isSelected: index == selectedStep,
                                    heading: step?.heading?.appCapitalize ?? "",
                                    subHeading: step?.subHeading ?? "",
                                    onTap: () => controller.changeVideo(index),
                                  );
                                },
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildSections({
    required BuildContext context,
    required String index,
    required String heading,
    required String subHeading,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15,
          vertical: height * 0.018,
        ),
        margin: EdgeInsets.only(bottom: AppSizer.vertical10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.cardBackGroundBlueColor : AppColor.white,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: AppColor.primaryColor1, width: 1.8)
              : null,
          boxShadow: [
            BoxShadow(
              color: AppColor.black.withOpacity(0.1),
              offset: Offset.zero,
              blurRadius: 3.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                SvgPicture.asset(
                  AppSvg.indexIcon,
                  width: width * 0.07,
                ),
                Positioned(
                  top: height * 0.008,
                  left: width * 0.02,
                  child: MySofiaSansText(
                    text: index,
                    fontSize: AppSizer.fontSize12,
                    color: AppColor.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(width: width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: MySofiaSansText(
                    text: heading,
                    fontSize: AppSizer.fontSize14,
                    fontWeight: FontWeight.w900,
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: height * 0.004),
                SizedBox(
                  width: width * 0.6,
                  child: MyManropeText(
                    text: subHeading,
                    color: AppColor.bodyTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizer.fontSize10,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            isSelected
                ? Icon(
                    Icons.play_arrow,
                    color: AppColor.primaryColor1,
                    size: width * 0.05,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
