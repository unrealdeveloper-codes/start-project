import 'package:desa/features/home/controllers/home_controller.dart';
import 'package:desa/features/home/views/widgets/Info_card.dart';
import 'package:desa/features/home/views/widgets/custome_listTile.dart';
import 'package:desa/features/home/views/widgets/dietSummeryList.dart';
import 'package:desa/features/home/views/widgets/home_appbar.dart';
import 'package:desa/features/home/views/widgets/home_quotes_section.dart';
import 'package:desa/features/home/views/widgets/home_water_section.dart';
import 'package:desa/utils/components/container/customeContiner.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/loaders/loader/animated_loader.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    controller.fetchSessionData();
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    final spacer = SizedBox(height: height * 0.03);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppSizer.appBarHeight),
        child: const HomeAppBar(),
      ),
      body: RefreshIndicator(
          color: AppColor.primaryColor1,
          onRefresh: () async {
            await controller.refreshMethod(context);
          },
          child: Obx(
            () => controller.isLoadingAnimation.value
                ? SizedBox(
                    width: width,
                    height: height * 0.9,
                    child: const AnimatedLoading())
                : ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.02,
                      horizontal: AppSizer.horizontal15,
                    ),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const HomeQuotesSection(),
                      // _buildMotivationCard(width, height),
                      spacer,
                      _buildDietSummaryCard(width, height, context),
                      spacer,
                      const HomeWaterSection(),
                      spacer,
                      controller.showSessionCard.value
                          ? _buildExerciseRoutineCard(width, height, controller)
                          : const SizedBox(),
                      controller.showSessionCard.value
                          ? spacer
                          : const SizedBox(),
                      // _buildCalmCornerCard(width, height, context),
                      // spacer,
                      controller.showBlogsCard.value
                          ? _buildDiscoverMoreCard(
                              width, height, controller, context)
                          : const SizedBox(),
                      spacer,
                    ],
                  ),
          )),
    );
  }

  Widget _buildDietSummaryCard(
    double width,
    double height,
    BuildContext context,
  ) {
    return CustomContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(
              AppStrings.dietSummaryTitle,
              AppStrings.viewReport,
              width,
              () {
                context.push(AppRoutes.myNutritionDiaryScreen);
              },
            ),
            SizedBox(height: height * 0.007),
            MyManropeText(
              text: AppStrings.dietSummarySubtitle,
              color: AppColor.greyTextColor,
              fontSize: AppSizer.fontSize13,
            ),
            SizedBox(height: height * 0.03),
            DietSummaryList(),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseRoutineCard(
    double width,
    double height,
    HomeController controller,
  ) {
    return CustomContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.02,
        ),
        child: Obx(() {
          if (controller.isLoadingSession.value) {
            // Show shimmer effect when loading
            return _buildShimmerList(width, height);
          } else if (controller.errorMessageSession.value.isNotEmpty) {
            // Show error message if there's an error
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.showSessionCard.value = false;
            });
            return const SizedBox();
//             return ErrorDisplay(
//               errorMessage: controller.errorMessageSession.value,
//               onTap: () => controller.fetchSessionData(),
//               boxHeight: height * 0.43,
// // Retry on tap
//             );
          } else if (controller.sessionData.value?.data?.sessions == null ||
              controller.sessionData.value?.data?.sessions?.isEmpty == true) {
            // No data available
            // return SizedBox();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              controller.showSessionCard.value = false;
            });
            return const SizedBox();
          } else {
            // Data rendering state
            final workoutSessions =
                controller.sessionData.value!.data!.sessions;
            final isExpanded = controller.isExpanded.value;
            final remainingItemCount = workoutSessions!.length - 4;

            // Calculate the number of items based on the expanded state
            int calculateItemCount() {
              return isExpanded
                  ? workoutSessions.length + 1
                  : (workoutSessions.length > 4 ? 5 : workoutSessions.length);
            }

            bool shouldShowViewMoreButton(int index) =>
                !isExpanded && index == 4 && workoutSessions.length > 4;

            bool shouldShowShowLessButton(int index) =>
                isExpanded && index == workoutSessions.length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyManropeText(
                  text: controller
                          .sessionData.value?.data?.heading?.appCapitalize ??
                      '',
                  fontWeight: FontWeight.w800,
                  fontSize: AppSizer.fontSize18,
                  maxLines: 2,
                ),
                SizedBox(height: height * 0.007),
                ExpandableText(
                    description: controller.sessionData.value?.data?.subHeading
                            ?.appCapitalize ??
                        ''),
                // MyManropeText(
                //   text: "" ?? '',
                //   color: AppColor.greyTextColor,
                //   fontSize: AppSizer.fontSize13,
                // ),
                SizedBox(height: height * 0.02),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: calculateItemCount(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    // Display the "View More" button
                    if (shouldShowViewMoreButton(index)) {
                      return ActionListTile(
                        title: '+ $remainingItemCount More Activities',
                        onTap: () =>
                            context.push(AppRoutes.VIEW_MORE_FITZONE_SCREEN),
                        //    onTap: () => controller.isExpanded.value = true,
                        iconSize: width * 0.035,
                      );
                    }
                    // // Display the "Show Less" button
                    // if (shouldShowShowLessButton(index)) {
                    //   return ActionListTile(
                    //     title: 'Show less',
                    //     onTap: () => controller.isExpanded.value = false,
                    //     iconSize: width * 0.035,
                    //   );
                    // }
                    // Display the workout session item
                    final session = workoutSessions[index];
                    return Column(
                      children: [
                        CustomListTile(
                            iconPath: session.image ??
                                'https://pragya.dbtechserver.online/desaconsulting/public/error.svg',
                            // Fallback icon path
                            title: session.title?.appCapitalize ??
                                'Untitled Session',
                            // Fallback text
                            subtitle: session.description?.appCapitalize ??
                                'No description available.',
                            onTap: () {
                              context.push(
                                AppRoutes.fitnessSessionScreen,
                                extra: session.id.toString(),
                              );
                            }),
                        if (index + 1 != workoutSessions.length) const Divider()
                      ],
                    );
                  },
                ),
              ],
            );
          }
        }),
      ),
    );
  }

// Shimmer effect for loading state
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

  Widget _buildDiscoverMoreCard(double width, double height,
      HomeController controller, BuildContext context) {
    controller.fetchBlogsCategoryList();
    return CustomContainer(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyManropeText(
              text: AppStrings.discoverMoreTitle,
              fontWeight: FontWeight.w800,
              fontSize: AppSizer.fontSize18,
            ),
            SizedBox(height: height * 0.005),

            // ExpandableText(
            //   description:
            //       ,
            // ),
            MyManropeText(
              text: AppStrings.discoverMoreSubtitle,
              color: AppColor.greyTextColor,
              fontSize: AppSizer.fontSize13,
            ),
            SizedBox(height: height * 0.03),
            _buildGridInfoCards(width, height, controller, context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
      String title, String actionText, double width, VoidCallback ontap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyManropeText(
          text: title,
          fontWeight: FontWeight.w800,
          fontSize: AppSizer.fontSize18,
          height: 0,
        ),
        InkWell(
          onTap: ontap,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: MyManropeText(
              text: actionText,
              fontWeight: FontWeight.w800,
              fontSize: AppSizer.fontSize11,
              color: AppColor.primaryColor2,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGridInfoCards(double width, double height,
      HomeController controller, BuildContext context) {
    return Obx(
      () {
        if (controller.isLoading.value) {
          // Show shimmer effect while loading
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.all(width * 0.02),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: width * 0.045,
              mainAxisSpacing: height * 0.02,
              childAspectRatio: width / (height * 0.445),
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
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                ),
              );
            },
          );
        } else if (controller.errorMessage.isNotEmpty) {
          // Show error message if there's an error
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.showBlogsCard.value = false;
          });
          return const SizedBox();
          // return ErrorDisplay(
          //   onTap: controller.fetchBlogsCategoryList,
          //   errorMessage: controller.errorMessage.value,
          //   boxHeight: height * 0.25,
          // );
        } else if (controller.blogCategoryList.value?.data == null ||
            controller.blogCategoryList.value!.data!.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.showBlogsCard.value = false;
          });
          return const SizedBox();
        } else {
          // Show actual grid when data is loaded
          List categoryList = controller.blogCategoryList.value!.data!;

          // Determine the number of items to display initially
          // List visibleItems = categoryList.take(4).toList(); // Show first 4 items

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.all(width * 0.02),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: width * 0.045,
                  mainAxisSpacing: height * 0.02,
                  childAspectRatio: width / (height * 0.445),
                ),
                itemCount: controller.viewLessForGridView.value
                    ? categoryList.length < 4
                        ? categoryList.length
                        : 4
                    : categoryList.length,
                itemBuilder: (context, index) {
                  final category = categoryList[index];
                  return InkWell(
                    onTap: () {
                      context.push(
                        AppRoutes.DISCOVER_MORE_SCREEN,
                        extra: {
                          'id': category.id.toString(),
                        }, // Pass the id as an extra argument
                      );
                    },
                    child: InfoCard(
                      iconPath: category.image!,
                      title: category.title!,
                      description: category.description!,
                    ),
                  );
                },
              ),
              // Show "View more" button if there are more than 4 items
              if (categoryList.length > 4)
                ActionListTile(
                    title: 'View More',
                    onTap: () {
                      context.push(AppRoutes.VIEW_DISCOVER_MORE_SCREEN);
                    }),

              // TextButton(
              //   onPressed: () {
              //   },
              //   child: MyManropeText(
              //     text: controller.viewLessForGridView.value
              //         ? "View more"
              //         : "View less",
              //   ),
              // ),
            ],
          );
        }
      },
    );
  }
}
