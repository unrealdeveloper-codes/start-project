import 'package:desa/features/nutrition/controller/weak_diet_meal_controller.dart';
import 'package:desa/utils/cards/title_card.dart';

import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class WeakDietMealPlanScreen extends StatelessWidget {
  final String id;
  final String weak;

  const WeakDietMealPlanScreen(
      {super.key, required this.id, required this.weak});

  @override
  Widget build(BuildContext context) {
    final WeakDietMealController controller = Get.put(WeakDietMealController());
    // Fetch data on initialization
    Future.microtask(() => controller.fetchWeakDietMeal(id, weak));

    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: const TransparentAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          // Show shimmer loading effect
          return _buildShimmerList(width, height);
        } else if (controller.errorMessage.isNotEmpty) {
          // Show error display
          return Center(
            child: ErrorDisplay(
              errorMessage: controller.errorMessage.value,
              onTap: () =>
                  controller.fetchWeakDietMeal(id, weak), // Retry logic
            ),
          );
        } else if (controller.weakDietMealData.value?.data == null) {
          // Show warning if no data is available
          return WarningDisplay(
            boxHeight: AppSizer.height * 0.7,
            iconPath: 'assets/nutritionIcons/dietPlanSvg.svg',
            warningMessage: "No Diet Plan Yet",
            subWarningMessage:
                'Create your nutrition plan to achieve your health goals.',
          );
        } else {
          // Render actual content
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizer.horizontal22,
                  vertical: AppSizer.vertical10,
                ),
                child: MyManropeText(
                  text: controller
                      .weakDietMealData.value!.data!.heading!.appCapitalize,
                  fontSize: AppSizer.fontSize22,
                  fontWeight: FontWeight.w900,
                  maxLines: 2,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.days.length,
                  itemBuilder: (context, index) {
                    // List<String> responseDays = controller
                    //         .weakDietMealData.value?.data?.days
                    //         ?.map((day) => day.day ?? '')
                    //         .toList() ??
                    //     [];
                    //
                    // // Safely get 'day' value from weakDietMealData, fallback to null if out of range
                    // var day = index <
                    //         int.parse((controller
                    //                 .weakDietMealData.value?.data?.days!.length)
                    //             .toString())
                    //     ? controller
                    //         .weakDietMealData.value!.data!.days![index].day
                    //     : null;
                    //
                    // // Convert day to num (double) safely
                    // num dayValue = (day != null && day.isNotEmpty)
                    //     ? (double.tryParse(day) ?? 0) // Parse string to num
                    //     : 0; // If day is null or empty, fallback to 0
                    return TitleCard(
                      heading: controller.days[index],
                      onTap: () {
                        /*   if (day != null) {*/
                        // If day is available, navigate to the next screen
                        context.push(
                          AppRoutes.DAY_DIET_MEAL_PLAN_SCREEN,
                          extra: {
                            'id': id,
                            'weak': weak,
                            'day': controller.days[index],
                            // Use the 'dayValue' (which is num) here
                          },
                        );
                        // } else {
                        //   // If the day is NOT available in weakDietMealData, show a snackbar
                        //   AppSnackBar.showSnackbar(
                        //     context: context,
                        //     title: "This day is not available.",
                        //     type: SnackbarType.warning,
                        //   );
                        // }
                      },
                    );
                  },
                ),
              )

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: controller.days.length,
              //     itemBuilder: (context, index) {
              //       // Extract responseDays from the controller's weakDietMealData
              //       List<String> responseDays = controller.weakDietMealData
              //           .value?.data?.days
              //           ?.map((day) => day.day ?? '')
              //           .toList() ?? [];
              //
              //       return TitleCard(
              //         heading: controller.days[index],
              //         // Pass each day as heading
              //         onTap: () {
              //           // Check if the current day is in the responseDays list
              //           if (responseDays.contains(controller.days[index])) {
              //             // If the day is in the responseDays list, navigate to the next screen
              //             context.push(
              //               AppRoutes.DAY_DIET_MEAL_PLAN_SCREEN,
              //               extra: {
              //                 'id': id,
              //                 'weak': weak,
              //                 'day': controller.weakDietMealData.value!.data!
              //                     .days![index].day!,
              //               },
              //             );
              //           } else {
              //             // If the day is NOT in the responseDays list, show a snackbar or handle the error
              //             AppSnackBar.showSnackbar(
              //               context: context,
              //               title: "This day is not available.",
              //               type: SnackbarType.warning,
              //             );
              //           }
              //         },
              //       );
              //     },
              //   ),
              // ),

              // Expanded(
              //   child: ListView.builder(
              //     itemCount: controller.days.length,
              //     // Use the length of the days list
              //     itemBuilder: (context, index) {
              //       return TitleCard(
              //         heading: controller.days[index],
              //         // Pass each day as heading
              //         onTap: () {
              //
              //
              //             context.push(
              //               AppRoutes.DAY_DIET_MEAL_PLAN_SCREEN,
              //               extra: {
              //                 'id': id,
              //                 'weak': weak,
              //                 'day': controller.weakDietMealData.value!.data!
              //                     .days![index].day!
              //               },
              //             );
              //
              //           //
              //           // else{
              //           //   AppSnackBar.showSnackbar(context: context, title: "title",type: SnackbarType.warning);
              //           // }
              //         },
              //       );
              //     },
              //   ),
              // ),
            ],
          );
        }
      }),
    );
  }

  /// Builds a shimmer effect for the loading state
  Widget _buildShimmerList(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.horizontal22,
            vertical: AppSizer.vertical6,
          ),
          child: Shimmer.fromColors(
            baseColor: AppColor.shimmerBaseColor,
            highlightColor: AppColor.shimmerHighlightColor,
            child: Container(
              height: height * 0.04,
              width: width * 0.6,
              decoration: BoxDecoration(
                color: AppColor.shimmerContentColor,
                borderRadius: BorderRadius.circular(width * 0.02),
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: AppSizer.horizontal22,
          ),
          itemCount: 5, // Simulate 7 days
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: AppSizer.vertical2),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  height: height * 0.08,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(width * 0.02),
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

// class WeakDietMealPlanScreen extends StatelessWidget {
//   final String id;
//   final String weak;
//   const WeakDietMealPlanScreen({super.key, required this.id, required this.weak});
//
//
//   @override
//   Widget build(BuildContext context) {
//     WeakDietMealController controller  = Get.put(WeakDietMealController());
//     controller.fetchWeakDietMeal(id, weak);
//     var width = MediaQuery.sizeOf(context).width;
//     var height = MediaQuery.sizeOf(context).height;
//
//     // List of days
//     final List<String> days = [
//       "Monday",
//       "Tuesday",
//       "Wednesday",
//       "Thursday",
//       "Friday",
//       "Saturday",
//       "Sunday"
//     ];
//
//     return Scaffold(
//
//       appBar: const TransparentAppBar(),
//       body: Obx(()=> Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: AppSizer.horizontal22,
//               vertical: AppSizer.vertical10,
//
//             ),
//             child: MyManropeText(
//               text: controller.weakDietMealData.value!.data!.heading!,
//               fontSize: AppSizer.fontSize22,
//               fontWeight: FontWeight.w900,
//             ),
//           ),
//           // Expanded(
//           //   child: ListView.builder(
//           //     physics: const NeverScrollableScrollPhysics(),
//           //     itemCount: days.length, // Use the length of the days list
//           //     itemBuilder: (context, index) {
//           //       return TitleCard(
//           //         heading: days[index], // Pass each day as heading
//           //         onTap: () {
//           //           context.push(AppRoutes.DAY_DIET_MEAL_PLAN_SCREEN);
//           //         },
//           //       );
//           //     },
//           //   ),
//           // ),
//         ],
//       ),)
//     );
//   }
// }
