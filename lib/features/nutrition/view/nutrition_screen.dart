import 'package:desa/features/nutrition/controller/nutrition_controller.dart';
import 'package:desa/utils/cards/Image_title_subtitle_card.dart';

import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/headings/heading_subheading_widget.dart';
import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/customeDropDown/custome_dropDown.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/textfields/search_text_fielt.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NutritionController());
    final width = MediaQuery.sizeOf(context).width;
    controller.fetchNutritionAllPrograms();
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: AppColor.appBackgroundColor,
          surfaceTintColor: AppColor.appBackgroundColor,
        ),
        body: Column(
          children: [
            _buildBackButton(controller, width),
            _buildHeadingSection(controller),
            _buildSearchField(controller),
            SizedBox(height: AppSizer.height * 0.01),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => controller.fetchNutritionAllPrograms(),
                child: ListView(
                  children: [
                    _buildMainContent(controller, width, context),
                  ],
                ),
              ),
            ),
          ],
        )
        // SafeArea(
        //   child: RefreshIndicator(
        //     onRefresh: () => controller.fetchNutritionAllPrograms(),
        //     child: LayoutBuilder(builder: (context, constraints) {
        //       return ListView(
        //         physics: const AlwaysScrollableScrollPhysics(),
        //         // crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           _buildBackButton(controller, width),
        //           _buildHeadingSection(controller),
        //           _buildSearchField(controller),
        //           SizedBox(height: AppSizer.height * 0.01),
        //           SingleChildScrollView(
        //               child: _buildMainContent(controller, width, context)),
        //         ],
        //       );
        //     }),
        //   ),
        // ),
        );
  }

  Widget _buildBackButton(NutritionController controller, double width) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(top: AppSizer.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (controller.isSearchFocused.value)
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  size: width * 0.045,
                ),
                onPressed: controller.onSearchFocusLost,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingSection(NutritionController controller) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          top: controller.isSearchFocused.value ? 1.5 : AppSizer.vertical10,
          left: AppSizer.horizontal15,
          right: AppSizer.horizontal15,
        ),
        child: controller.isSearchFocused.value
            ? const SizedBox()
            : FadeTransition(
                opacity: controller.fadeAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingSubheadingWidget(
                      heading: AppStrings.nutritionHeading,
                      subHeading: AppStrings.nutritionSubHeading,
                    ),
                    SizedBox(height: AppSizer.height * 0.03),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildSearchField(NutritionController controller) {
    return SizedBox(
      height: AppSizer.height * 0.066,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: controller.positionAnimation,
              builder: (context, child) {
                return Obx(() => Positioned(
                      top: controller.isSearchFocused.value
                          ? AppSizer.height * controller.positionAnimation.value
                          : 0,
                      left: 0,
                      right: 0,
                      child: child!,
                    ));
              },
              child: Obx(
                () => MySearchTextFeild(
                  controller: controller.searchController,
                  hintText: controller.isSearchFocused.value
                      ? AppStrings.searchHintFocused
                      : AppStrings.searchHintDefault,
                  onTap: controller.onSearchTap,
                  prifix: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSizer.width * 0.025,
                    ),
                    child: SvgPicture.asset(
                      AppSvg.searchIcon,
                      width: AppSizer.width * 0.01,
                      height: AppSizer.height * 0.025,
                    ),
                  ),
                  onChange: (value) {
                    controller.fetchSearchMeal(value);
                  },
                  suffix: controller.isSearchFocused.value
                      ? CustomDropdown(
                          items: const [
                            AppStrings.mealBreakfast,
                            AppStrings.mealLunch,
                            AppStrings.mealDinner
                          ],
                          selectedValue: controller.selectedMealType.value,
                          onSelected: controller.updateMealType,
                        )
                      : const SizedBox(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMainContent(
    NutritionController controller,
    double width,
    BuildContext context,
  ) {
    return Obx(
      () => controller.isSearchFocused.value
          ? _buildSearchResults(controller)
          : _buildGridContent(controller, width, context),
    );
  }

  Widget _buildSearchResults(NutritionController controller) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
        child: controller.isLoadingSearch.value
            // Show shimmer effect while loading
            ? _buildShimmerList()
            // Show error message if there's an error
            : controller.errorMessageSearch.value.isNotEmpty
                ? ErrorDisplay(
                    errorMessage: controller.errorMessageSearch.value,
                    onTap: () {
                      controller
                          .fetchSearchMeal(controller.searchController.text);
                    },
                  )
                // Show warning message if no data available
                : controller.searchMealData.value?.data?.isEmpty ?? true
                    ? SizedBox(
                        width: AppSizer.width,
                        height: AppSizer.height * 0.65,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/nutritionIcons/searchMealIcon.svg',
                              width: AppSizer.width * 0.12,
                            ),
                            SizedBox(
                              height: AppSizer.height *
                                  0.01, // Increased spacing between the icon and text
                            ),
                            MyManropeText(
                              text: 'No Meals Found!',
                              fontWeight: FontWeight.w800,
                              fontSize: AppSizer
                                  .fontSize18, // Larger font size for the heading
                              color: AppColor
                                  .primaryColor1, // Use a primary color to highlight the message
                            ),
                            SizedBox(
                              height: AppSizer.height *
                                  0.005, // Slightly larger spacing for readability
                            ),
                            SizedBox(
                              width: AppSizer.width *
                                  0.7, // Slightly wider for better layout
                              child: MyManropeText(
                                text:
                                    'Try searching for a different meal or adjust your filters.',
                                textAlign: TextAlign.center,
                                fontSize: AppSizer.fontSize12,
                                // Slightly larger text for easier reading
                                fontWeight: FontWeight.w500,
                                color: AppColor
                                    .greyTextColor, // Subtle text color for the description
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.searchMealData.value?.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          final meal =
                              controller.searchMealData.value!.data![index];
                          return ImageTitleSubtitleCard(
                            onTap: () {
                              context.push(AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
                                  extra: {'id': meal.id.toString()});
                              // Handle item tap
                            },
                            heading: meal.mealName!.appCapitalize,
                            subHeading: "${meal.mealName?.appCapitalize} kcal",
                          );
                        },
                      ),
      ),
    );
  }

// Shimmer effect for loading state
  Widget _buildShimmerList() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 3,
      // Number of shimmer items
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizer.height * 0.012),
          child: Shimmer.fromColors(
            baseColor: AppColor.shimmerBaseColor,
            highlightColor: AppColor.shimmerHighlightColor,
            child: Container(
              height: AppSizer.height * 0.078,
              decoration: BoxDecoration(
                color: AppColor.shimmerContentColor,
                borderRadius: BorderRadius.circular(AppSizer.width * 0.025),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridContent(
    NutritionController controller,
    double width,
    BuildContext context,
  ) {
    return FadeTransition(
      opacity: controller.fadeAnimation,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizer.vertical5,
            horizontal: AppSizer.horizontal15,
          ),
          child: _buildGridInfoCards(
            width,
            AppSizer.height,
            context,
            controller,
          ),
        ),
      ),
    );
  }

  Widget _buildGridInfoCards(double width, double height, BuildContext context,
      NutritionController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        // Show shimmer effect while loading
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(width * 0.02),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: width * 0.038,
            mainAxisSpacing: height * 0.018,
            childAspectRatio: width / (height * 0.32),
          ),
          itemCount: 4,
          // Number of shimmer placeholders
          itemBuilder: (context, index) {
            return Shimmer.fromColors(
              baseColor: AppColor.shimmerBaseColor,
              highlightColor: AppColor.shimmerHighlightColor,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.shimmerContentColor,
                  borderRadius: BorderRadius.circular(AppSizer.width * 0.025),
                ),
                // margin: EdgeInsets.symmetric(horizontal: width * 0.01),
              ),
            );
          },
        );
      } else if (controller.errorMessage.isNotEmpty) {
        // Show error message if there's an error
        return ErrorDisplay(
          onTap: controller.fetchNutritionAllPrograms, // Retry callback
          errorMessage: controller.errorMessage.value,
          boxHeight: height * 0.25,
        );
      } else if (controller.nutritionAllProgramData.value?.data == null ||
          controller.nutritionAllProgramData.value!.data!.isEmpty) {
        // Show "No Data" message when the list is empty
        return WarningDisplay(
          boxHeight: height * 0.55,
          iconPath: 'assets/nutritionIcons/no programs.svg',
          warningMessage: 'No Programs Enrolled Yet!',
          subWarningMessage:
              'Explore our programs and start your journey to wellness.',
        );
      } else {
        // Show actual grid when data is loaded
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.all(width * 0.02),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: width * 0.038,
            mainAxisSpacing: height * 0.018,
            childAspectRatio: width / (height * 0.32),
          ),
          itemCount: controller.nutritionAllProgramData.value!.data!.length,
          itemBuilder: (context, index) {
            final program =
                controller.nutritionAllProgramData.value!.data![index];
            return InkWell(
              onTap: () {
                context.push(
                  AppRoutes.NUTRITION_PROGRAM_SCREEN,
                  extra: {
                    'id': controller
                        .nutritionAllProgramData.value!.data![index].id
                        .toString()
                  }, // Pass the id as an extra argument
                );
                // context.push(AppRoutes.NUTRITION_PROGRAM_SCREEN,extra: 'id': cont);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizer.width * 0.025),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSizer.width * 0.025),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      CustomNetworkImage(
                        imageUrl: program.image ?? '',
                        height: height,
                        width: width,
                      ),

                      // -- Gradient
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSizer.width * 0.025),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFF2D4854).withOpacity(0.0),
                              const Color(0xFF203139).withOpacity(0.5),
                              const Color(0xFF1B262C),
                              // -- Previous Gradient
                              // const Color(0xFF193167).withOpacity(0.0),
                              // const Color(0xFF193167),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: width * 0.03,
                        right: width * 0.03,
                        bottom: height * 0.01,
                        child: SizedBox(
                          width: width * 0.4,
                          child: MySofiaSansText(
                            text: program.heading?.appCapitalize ?? '',
                            color: Colors.white,
                            maxLines: 2,
                            fontSize: AppSizer.fontSize14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }
}
