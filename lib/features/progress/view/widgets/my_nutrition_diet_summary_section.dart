import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
import 'package:desa/features/progress/view/widgets/dite_card.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/datePicker/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class MyNutritionDietSummarySection extends StatelessWidget {
  final MyNutritionDiaryController controller;

  const MyNutritionDietSummarySection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    // Default to the current date

    Future<void> selectDate(BuildContext context) async {
      final String? startDateString =
          controller.dietSummaryData.value?.data?.date;
      DateTime firstDate = DateTime(2000); // Default value

      if (startDateString != null) {
        // Convert the `date` string to a DateTime object
        firstDate = DateTime.parse(startDateString);
      }

      DateTime currentSelectedDate =
          DateTime.parse(controller.selectedDate.value);

      final DateTime? pickedDate = await showAppDatePicker(
        context: context,
        initialDate: currentSelectedDate,
        firstDate: firstDate,
        lastDate: DateTime.now(),
        switchToInputEntryModeIcon: Icon(
          Icons.edit,
          color: AppColor.white,
          size: width * 0.06,
        ),
        switchToCalendarEntryModeIcon: Icon(
          Icons.calendar_today,
          color: AppColor.white,
          size: width * 0.06,
        ),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColor.primaryColor1,
                onPrimary: Colors.white,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      if (pickedDate != null) {
        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        controller.selectedDate.value = formattedDate;
        controller.fetchDietSummaryData();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Always visible Row
        Row(
          children: [
            MyManropeText(
              text: "Diet Summary",
              color: AppColor.primaryColor2,
              fontWeight: FontWeight.w900,
              fontSize: AppSizer.fontSize16,
            ),
            const Spacer(),
            InkWell(
              onTap: () => selectDate(context),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColor.cardBackGroundBlueColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  children: [
                    SizedBox(width: width * 0.01),
                    SvgPicture.asset(
                      AppSvg.calenderIcon,
                      width: width * 0.045,
                    ),
                    SizedBox(width: width * 0.02),
                    MyManropeText(
                      text: "Select date",
                      color: AppColor.selectDateCalendarFontColor,
                      height: width * 0.004,
                      fontWeight: FontWeight.w700,
                      fontSize: AppSizer.fontSize12,
                    ),
                    SizedBox(width: width * 0.01),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: height * 0.015),

        // Dynamic content with Obx
        Obx(() {
          if (controller.isLoadingDietSummary.value) {
            // Show shimmer effect while loading
            return _buildShimmerList(height);
          } else if (controller.errorMessageDietSummary.value.isNotEmpty) {
            // Show error message if there's an error
            return ErrorDisplay(
              boxHeight: height * 0.4,
              errorMessage: controller.errorMessageDietSummary.value,
              onTap: () => controller.fetchDietSummaryData(
                 ), // Retry logic
            );
          } else if (controller.dietSummaryData.value?.data == null) {
            // Show "No Data" message when the data is null
            return WarningDisplay(
              boxHeight: height * 0.4,
              iconPath: 'assets/nutritionIcons/dietPlanSvg.svg',
              warningMessage: 'No Diet Summary Yet!',
              subWarningMessage:
                  'Create your nutrition plan to achieve your health goals.',
            );
          } else {
            // Show actual diet summary data
            final dietData = controller.dietSummaryData.value!.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DietCard(
                  heading: "Calories Consumed:",
                  value: _parsePercentage(dietData.calories?.percentage ?? '0'),
                  heading2: 'Consumed: ${dietData.calories?.consumed ?? '0'}',
                  value2: 'Goal: ${dietData.calories?.goal ?? '0'}',
                  color: AppColor.caloriesRed,
                ),
                DietCard(
                  heading: "Protein Consumed:",
                  value: _parsePercentage(dietData.protein?.percentage ?? '0'),
                  heading2: 'Consumed: ${dietData.protein?.consumed ?? '0'}',
                  value2: 'Goal: ${dietData.protein?.goal ?? '0'}',
                  color: AppColor.proteinBlue,
                ),
                DietCard(
                  heading: "Fat Consumed:",
                  value: _parsePercentage(dietData.fat?.percentage ?? '0'),
                  heading2: 'Consumed: ${dietData.fat?.consumed ?? '0'}',
                  value2: 'Goal: ${dietData.fat?.goal ?? '0'}',
                  color: AppColor.fatsYellow,
                ),
                DietCard(
                  heading: "Carbs Consumed:",
                  value: _parsePercentage(dietData.carbs?.percentage ?? '0'),
                  heading2: 'Consumed: ${dietData.carbs?.consumed ?? '0'}',
                  value2: 'Goal: ${dietData.carbs?.goal ?? '0'} ',
                  color: AppColor.carbsGreen,
                ),
              ],
            );
          }
        }),
      ],
    );
  }

  double _parsePercentage(String percentage) {
    try {
      // Remove '%' symbol and parse as a double
      return double.parse(percentage.replaceAll('%', '').trim());
    } catch (e) {
      // Return 0.0 if parsing fails
      print('Error parsing percentage: $e');
      return 0.0;
    }
  }

  // double _parsePercentage(String percentage) {
  //   try {
  //     // Remove '%' symbol and parse as a double, then convert to int
  //     return double.parse(percentage.replaceAll('%', '')).round();
  //   } catch (e) {
  //     // Return 0 if parsing fails
  //     print('Error parsing percentage: $e');
  //     return 0;
  //   }
  // }

  // Shimmer effect for loading state
  Widget _buildShimmerList(double height) {
    return ListView.builder(
      itemCount: 4, // Number of shimmer items
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: height * 0.01),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: height * 0.155,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        );
      },
    );
  }
}

// class MyNutritionDietSummarySection extends StatelessWidget {
//   final MyNutritionDiaryController controller;
//
//   const MyNutritionDietSummarySection({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//
//     // Default to the current date
//     final selectedDate = DateTime.now().toLocal().toString().split(' ')[0];
//
//     Future<void> selectDate(BuildContext context) async {
//       final DateTime? pickedDate = await showAppDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(2000),
//         lastDate: DateTime(2100),
//         switchToInputEntryModeIcon: Icon(
//           Icons.edit,
//           color: AppColor.white,
//           size: width * 0.06,
//         ),
//         switchToCalendarEntryModeIcon: Icon(
//           Icons.calendar_today,
//           color: AppColor.white,
//           size: width * 0.06,
//         ),
//         builder: (BuildContext context, Widget? child) {
//           return Theme(
//             data: ThemeData.light().copyWith(
//               colorScheme: const ColorScheme.light(
//                 primary: AppColor.primaryColor1,
//                 onPrimary: Colors.white,
//                 onSurface: Colors.black,
//               ),
//               dialogBackgroundColor: Colors.white,
//             ),
//             child: child!,
//           );
//         },
//       );
//
//       // if (pickedDate != null) {
//       //   controller.fetchDietSummaryData(pickedDate.toLocal().toString().split(' ')[0]);
//       // }
//     }
//
//     return Obx(() {
//       if (controller.isLoadingDietSummary.value) {
//         // Show shimmer effect while loading
//         return _buildShimmerList(height);
//       } else if (controller.errorMessageDietSummary.value.isNotEmpty) {
//         // Show error message if there's an error
//         return ErrorDisplay(
//           errorMessage: controller.errorMessageDietSummary.value,
//           onTap: () {}, // Retry logic
//         );
//       } else if (controller.dietSummaryData.value?.data == null) {
//         // Show "No Data" message when the data is null
//         return const WarningDisplay(
//             warningMessage: 'No data available for the selected date.');
//       } else {
//         // Show actual diet summary data
//         final dietData = controller.dietSummaryData.value!.data!;
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 MyManropeText(
//                   text: "Diet Summary",
//                   color: AppColor.primaryColor2,
//                   fontWeight: FontWeight.w900,
//                   fontSize: AppSizer.fontSize16,
//                 ),
//                 const Spacer(),
//                 InkWell(
//                   onTap: () => selectDate(context),
//                   child: Container(
//                     padding: const EdgeInsets.all(6),
//                     decoration: BoxDecoration(
//                       color: AppColor.cardBackGroundBlueColor,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Row(
//                       children: [
//                         SizedBox(width: width * 0.01),
//                         SvgPicture.asset(
//                           AppSvg.calenderIcon,
//                           width: width * 0.045,
//                         ),
//                         SizedBox(width: width * 0.02),
//                         MyManropeText(
//                           text: "Select date",
//                           color: AppColor.selectDateCalendarFontColor,
//                           height: width * 0.004,
//                           fontWeight: FontWeight.w700,
//                           fontSize: AppSizer.fontSize12,
//                         ),
//                         SizedBox(width: width * 0.01),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: height * 0.024),
//
//             DietCard(
//               heading: "Calories Consumed:",
//               value: _parsePercentage(dietData.calories?.percentage ?? '0'),
//               heading2: '${dietData.calories?.consumed ?? '0'} consumed',
//               value2: '${dietData.calories?.goal ?? '0'} goal',
//               color: AppColor.calories,
//             ),
//             DietCard(
//               heading: "Carbs Consumed:",
//               value: _parsePercentage(dietData.carbs?.percentage ?? '0'),
//               heading2: '${dietData.carbs?.consumed ?? '0'} consumed',
//               value2: '${dietData.carbs?.goal ?? '0'} goal',
//               color: AppColor.cabs,
//             ),
//             DietCard(
//               heading: "Fat Consumed:",
//               value: _parsePercentage(dietData.fat?.percentage ?? '0'),
//               heading2: '${dietData.fat?.consumed ?? '0'} consumed',
//               value2: '${dietData.fat?.goal ?? '0'} goal',
//               color: AppColor.fat,
//             ),
//             DietCard(
//               heading: "Protein Consumed:",
//               value: _parsePercentage(dietData.protein?.percentage ?? '0'),
//               heading2: '${dietData.protein?.consumed ?? '0'} consumed',
//               value2: '${dietData.protein?.goal ?? '0'} goal',
//               color: AppColor.primaryColor2,
//             ),
//           ],
//         );
//       }
//     });
//   }
//
//   int _parsePercentage(String percentage) {
//     try {
//       // Remove '%' symbol and parse as a double, then convert to int
//       return double.parse(percentage.replaceAll('%', '')).round();
//     } catch (e) {
//       // Return 0 if parsing fails
//       print('Error parsing percentage: $e');
//       return 0;
//     }
//   }
//
//   // Shimmer effect for loading state
//   Widget _buildShimmerList(double height) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 width: AppSizer.width * 0.4,
//                 height: height * 0.03,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//             Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 width: AppSizer.width * 0.4,
//                 height: height * 0.03,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: height * 0.005,
//         ),
//         ListView.builder(
//           itemCount: 4, // Number of shimmer items
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: EdgeInsets.symmetric(vertical: height * 0.01),
//               child: Shimmer.fromColors(
//                 baseColor: Colors.grey[300]!,
//                 highlightColor: Colors.grey[100]!,
//                 child: Container(
//                   height: height * 0.1,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
