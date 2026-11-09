import 'package:desa/features/home/controllers/home_controller.dart';
import 'package:desa/features/home/views/widgets/custome_listTile.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/components/appbar/transparent_appBar.dart';

class HomeFitnessSectionMore extends StatelessWidget {
  const HomeFitnessSectionMore({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = HomeController.instance;
    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: const TransparentAppBar(),
      body: Obx(
        () {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
            child: Column(
              children: [
                if (controller.isLoading.value)
                  _buildShimmerList(width, height)
                else if (controller.errorMessage.isNotEmpty)
                  // Show error message if there's an error
                  ErrorDisplay(
                    errorMessage: controller.errorMessageSession.value,
                    onTap: () => controller.fetchSessionData(),
                    boxHeight: height * 0.65,
                  )
                else if (controller.sessionData.value?.data?.sessions == null ||
                    controller.sessionData.value?.data?.sessions?.isEmpty ==
                        true)
                  // Show "No Data" message when the list is empty
                  WarningDisplay(
                    warningMessage: "No sessions available.",
                    boxHeight: height * 0.65,
                  )
                else
                  Obx(
                    () {
                      final workoutSessions =
                          controller.sessionData.value!.data!.sessions;

                      return Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyManropeText(
                              text:
                                  controller.sessionData.value?.data?.heading ??
                                      '',
                              fontSize: AppSizer.fontSize30,
                              fontWeight: FontWeight.w800,
                              maxLines: 5,
                            ),
                            SizedBox(height: height * 0.016),
                            ExpandableText(
                              description: controller
                                      .sessionData.value?.data?.subHeading ??
                                  '',
                            ),
                            SizedBox(height: height * 0.04),
                            Expanded(
                              child: ListView.builder(
                                itemCount: workoutSessions!.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  final session = workoutSessions[index];
                                  return Column(
                                    children: [
                                      CustomListTile(
                                        iconPath: session.image ??
                                            'https://pragya.dbtechserver.online/desaconsulting/public/error.svg',
                                        title:
                                            session.title ?? 'Untitled Session',
                                        subtitle: session.description ??
                                            'No description available.',
                                        onTap: () => context.push(
                                          AppRoutes.fitnessSessionScreen,
                                          extra: session.id.toString(),
                                        ),
                                      ),
                                      if (index + 1 != workoutSessions.length)
                                        const Divider()
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildShimmerList(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: AppRes.width * 0.6, // Adjust width for heading
            height: height * 0.03,
            margin: EdgeInsets.only(bottom: height * 0.01),
            decoration: BoxDecoration(
              color: AppColor.shimmerContentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // Shimmer for subheading
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            width: AppRes.width * 0.45, // Adjust width for heading
            height: height * 0.02,
            margin: EdgeInsets.only(bottom: height * 0.01),
            decoration: BoxDecoration(
              color: AppColor.shimmerContentColor,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 3,
          // Display a few dummy items during loading
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: height * 0.01),
              child: Shimmer.fromColors(
                baseColor: AppColor.shimmerBaseColor,
                highlightColor: AppColor.shimmerHighlightColor,
                child: Container(
                  height: height * 0.1,
                  decoration: BoxDecoration(
                    color: AppColor.shimmerContentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
