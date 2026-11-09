import 'package:desa/features/fitness/controllers/fitness_category_controller.dart';
import 'package:desa/utils/components/buttons/how_we_make_recommendations_button.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_images.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/loaders/shimmer/fitness_category_shimmer.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';

import '../../../../utils/components/warning_dispaly.dart';

class FitnessCategoryScreen extends StatefulWidget {
  final String id;

  const FitnessCategoryScreen({
    super.key,
    required this.id,
  });

  @override
  State<FitnessCategoryScreen> createState() => _FitnessCategoryScreenState();
}

class _FitnessCategoryScreenState extends State<FitnessCategoryScreen> {
  late FitnessCategoryController controller;

  @override
  void initState() {
    controller = Get.put(FitnessCategoryController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchCategory(context, widget.id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            AppSvg.fitnessCategoryBg,
            fit: BoxFit.fill,
            width: width,
            height: height,
          ),
          Obx(
            () {
              // If loading
              if (controller.isLoading) {
                return const FitnessCategoryShimmer();
              }
              // If error
              else if (controller.errorMessage != "") {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
                  child: ErrorDisplay(
                    onTap: () => controller.fetchCategory(context, widget.id),
                    errorMessage: controller.errorMessage,
                    boxHeight: height * 0.7,
                  ),
                );
              } else if (controller.category.categoryHeading == null ||
                  controller.category.categoryHeading == '') {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
                  child: WarningDisplay(
                    boxHeight: height * 0.9,
                    iconPath: 'assets/fitness/noFitness.svg',
                    warningMessage: 'Find Your Balance',
                    subWarningMessage:
                        'No active sessions yet. Join a fitness or mindfulness program to begin your journey.',
                  ),
                );
              }

              // If Data
              else {
                return Column(
                  children: [
                    SizedBox(height: height * 0.14),
                    SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppSizer.horizontal20,
                          vertical: AppSizer.vertical8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MySofiaSansText(
                              text: controller.category.categoryHeading
                                      ?.appCapitalize ??
                                  "",
                              // text: AppStrings.fitzone,
                              fontSize: AppSizer.fontSize20,
                              height: width * 0.0032,
                              fontWeight: FontWeight.w800,
                              maxLines: 4,
                            ),
                            SizedBox(height: height * 0.01),
                            ExpandableText(
                              description: controller.category
                                      .categorySubHeading?.appCapitalize ??
                                  "",
                            ),
                            SizedBox(height: height * 0.04),
                            buildSections(
                              context: context,
                              svg: AppSvg.book,
                              heading: controller.category.introduction?.heading
                                      ?.appCapitalize ??
                                  "Null",
                              subHeading: controller.category.introduction
                                      ?.subHeading?.appCapitalize ??
                                  "Null",
                              onTap: () => context.push(
                                AppRoutes.introductionScreen,
                                extra: {
                                  'from': "fitness",
                                  'id': widget.id.toString(),
                                },
                              ),
                              isDataNull:
                                  controller.category.introduction != null,
                            ),
                            SizedBox(height: height * 0.022),
                            buildSections(
                              context: context,
                              svg: AppSvg.play,
                              heading: controller.category.session?.heading
                                      ?.appCapitalize ??
                                  "Null",
                              subHeading: controller.category.session
                                      ?.subHeading?.appCapitalize ??
                                  "Null",
                              onTap: () => context.push(
                                AppRoutes.fitnessSessionsScreen,
                                extra: widget.id,
                              ),
                              isDataNull: controller.category.session != null,
                            ),
                            SizedBox(height: height * 0.022),
                            const RecommendationsButton(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () => context.pop(),
              child: Padding(
                padding: EdgeInsets.only(
                  top: height * .09,
                  left: width * 0.05,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: width * 0.045,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSections({
    required BuildContext context,
    required String svg,
    required String heading,
    required String subHeading,
    required VoidCallback onTap,
    required bool isDataNull,
  }) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: !isDataNull
          ? () {
              AppSnackBar.showSnackbar(
                type: SnackbarType.warning,
                context: context,
                title: "OnSnap!",
                message: "Data is Null",
              );
            }
          : onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15,
          vertical: AppSizer.vertical8,
        ),
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
            SvgPicture.asset(svg),
            SizedBox(width: width * 0.04),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width * 0.6,
                  child: MySofiaSansText(
                    text: heading,
                    fontSize: AppSizer.fontSize15,
                    fontWeight: FontWeight.w900,
                    maxLines: 1,
                  ),
                ),
                SizedBox(height: height * 0.004),
                SizedBox(
                  width: width * 0.6,
                  child: MyManropeText(
                    text: subHeading,
                    color: AppColor.bodyTextColor,
                    height: width * 0.004,
                    fontWeight: FontWeight.w700,
                    fontSize: AppSizer.fontSize10,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Visibility(
              visible: isDataNull,
              child: SvgPicture.asset(AppSvg.arrow),
            ),
          ],
        ),
      ),
    );
  }
}

// AppCacheImage(
//   image: controller.category.categoryBgImage!,
//   isNetworkImage: controller.category.categoryBgImage != "",
//   width: width,
//   height: height,
//   errorWidget: SvgPicture.asset(
//     AppSvg.meditationLibraryBg,
//     fit: BoxFit.cover,
//   ),
//   // errorWidget: Image.asset(
//   //   "assets/fitness/calmCorner.png",
//   //   //   "assets/fitness/exercies_bg.png",
//   //   width: width,
//   //   height: height,
//   // ),
//   progressIndicatorWidget: Shimmer.fromColors(
//     baseColor: Colors.grey[200]!,
//     highlightColor: Colors.grey[300]!,
//     child: Container(
//       width: width,
//       height: height,
//       color: AppColor.black,
//     ),
//   ),
// ),
