import 'package:desa/features/fitness/controllers/fitness_sessions_controller.dart';
import 'package:desa/utils/components/background/custom_background_widget.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/loaders/shimmer/fitness_sessions_shimmer.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FitnessSessionsScreen extends StatefulWidget {
  final String id;

  const FitnessSessionsScreen({super.key, required this.id});

  @override
  State<FitnessSessionsScreen> createState() => _FitnessSessionsScreenState();
}

class _FitnessSessionsScreenState extends State<FitnessSessionsScreen> {
  late FitnessSessionsController controller;

  @override
  void initState() {
    controller = Get.put(FitnessSessionsController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchSessions(context, widget.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return CustomWidgetFromBackGround(
      backgroundImage: AppSvg.workoutSessionsBg,
      child: Obx(
        () {
          // If loading
          if (controller.isLoading) {
            return const FitnessSessionsShimmer();
          }
          // If error
          else if (controller.errorMessage != "") {
            return ErrorDisplay(
              onTap: () => controller.fetchSessions(context, widget.id),
              errorMessage: controller.errorMessage,
              boxHeight: height * 0.7,
            );
          }
          // If No Data
          else if (controller.sessions.sessions == null ||
              controller.sessions.sessions!.isEmpty) {
            return WarningDisplay(
              boxHeight: height * 0.75,
              iconPath: 'assets/fitness/noFitness.svg',
              warningMessage: 'Find Your Balance',
              subWarningMessage:
                  'No active sessions yet. Join a fitness or mindfulness program to begin your journey.',
            );
          }
          // If Data
          else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.012),
                MySofiaSansText(
                  text: controller.sessions.heading?.appCapitalize ?? "",
                  fontSize: AppSizer.fontSize20,
                  height: width * 0.0027,
                  fontWeight: FontWeight.w800,
                  maxLines: 6,
                ),
                SizedBox(height: height * 0.03),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.sessions.sessions?.length ?? 0,
                    itemBuilder: (context, index) {
                      final session = controller.sessions.sessions?[index];
                      return buildSections(
                        context: context,
                        svg: AppSvg.book,
                        heading: session?.title ?? "",
                        subHeading: session?.description ?? "",
                        onTap: () => context.push(
                          AppRoutes.fitnessSessionScreen,
                          extra: session!.id.toString(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildSections({
    required BuildContext context,
    required String svg,
    required String heading,
    required String subHeading,
    required VoidCallback onTap,
  }) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15,
          vertical: height * 0.02,
        ),
        margin: EdgeInsets.only(bottom: AppSizer.vertical10),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(8),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.7,
                  child: MySofiaSansText(
                    text: heading,
                    fontSize: AppSizer.fontSize15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(height: height * 0.004),
                SizedBox(
                  width: width * 0.7,
                  child: MyManropeText(
                    text: subHeading,
                    color: AppColor.bodyTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizer.fontSize10,
                  ),
                ),
              ],
            ),
            const Spacer(),
            SvgPicture.asset(AppSvg.arrow),
          ],
        ),
      ),
    );
  }
}
