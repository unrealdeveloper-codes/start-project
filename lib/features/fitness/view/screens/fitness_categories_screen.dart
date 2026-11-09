import 'package:desa/features/fitness/controllers/fitness_categories_controller.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/headings/heading_subheading_widget.dart';
import 'package:desa/utils/components/image/app_cache_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/loaders/shimmer/fitness_categories_shimmer.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class FitnessCategoriesScreen extends StatefulWidget {
  const FitnessCategoriesScreen({super.key});

  @override
  State<FitnessCategoriesScreen> createState() =>
      _FitnessCategoriesScreenState();
}

class _FitnessCategoriesScreenState extends State<FitnessCategoriesScreen> {
  late FitnessCategoriesController controller;

  @override
  void initState() {
    controller = Get.put(FitnessCategoriesController());
    controller.fetchCategories(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    // Example refresh function
    Future<void> refreshData() async {
      controller.fetchCategories(context);
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColor.appBackgroundColor,
        surfaceTintColor: AppColor.appBackgroundColor,
      ),
      body: Column(
        children: [
          SizedBox(height: height * 0.045),
          const HeadingSubheadingWidget(
            heading: AppStrings.exericesMeditationHeading,
            subHeading: AppStrings.exericesMeditationSubHeading,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizer.horizontal15,
                vertical: AppSizer.vertical10,
              ),
              child: Obx(
                () => RefreshIndicator(
                  onRefresh: refreshData,
                  color: AppColor.primaryColor1,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      if (controller.isLoading) ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return const FitnessCategoriesShimmerCard();
                          },
                        ),
                      ] else if (controller.errorMessage.isNotEmpty) ...[
                        ErrorDisplay(
                          onTap: () => controller.fetchCategories(context),
                          errorMessage: controller.errorMessage,
                          boxHeight: height * 0.55,
                        ),
                      ] else if (controller.categories.isEmpty) ...[
                        WarningDisplay(
                          boxHeight: height * 0.55,
                          iconPath: 'assets/fitness/noFitness.svg',
                          warningMessage: 'Find Your Balance',
                          subWarningMessage:
                              'No active sessions yet. Join a fitness or mindfulness program to begin your journey.',
                        ),
                      ] else
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.categories.length,
                          itemBuilder: (context, index) {
                            final category = controller.categories[index];
                            return buildSections(
                              context,
                              category.heading ?? "",
                              category.subHeading ?? "",
                              category.image ?? "",
                              () {
                                context.push(
                                  AppRoutes.fitnessCategoryScreen,
                                  extra: category.id.toString(),
                                );
                              },
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSections(
    BuildContext context,
    String heading,
    String subHeading,
    String image,
    VoidCallback onTap,
  ) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.22,
            margin: EdgeInsets.only(bottom: height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AppCacheImage(
                image: image,
                isNetworkImage: true,
                errorWidget: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.image_not_supported,
                        size: width * 0.1,
                        color: Colors.red.withOpacity(0.4),
                      ),
                      SizedBox(height: height * 0.012),
                      MyManropeText(
                        text: "Image not found",
                        fontSize: AppSizer.fontSize16,
                        color: Colors.red.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          // -- Gradient
          Container(
            width: double.infinity,
            height: height * 0.22,
            margin: EdgeInsets.only(bottom: height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF2D4854).withOpacity(0.0),
                  const Color(0xFF203139).withOpacity(0.5),
                  const Color(0xFF1B262C),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.02,
            child: Padding(
              padding: EdgeInsets.all(AppSizer.horizontal15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: width * 0.8,
                    child: MySofiaSansText(
                      text: heading.appCapitalize,
                      fontSize: AppSizer.fontSize14,
                      height: width * 0.0027,
                      fontWeight: FontWeight.bold,
                      color: AppColor.white,
                    ),
                  ),
                  SizedBox(height: height * 0.005),
                  SizedBox(
                    width: width * 0.8,
                    child: MyManropeText(
                      text: subHeading.appCapitalize,
                      height: width * 0.0036,
                      fontWeight: FontWeight.w500,
                      fontSize: AppSizer.fontSize11,
                      color: AppColor.white.withOpacity(0.8),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
