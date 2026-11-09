import 'package:desa/features/nutrition/controller/food_detail_controller.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'widget/food_detail_widget.dart';
import 'package:desa/features/nutrition/controller/food_detail_controller.dart';

class FoodDetailScreen extends StatelessWidget {
  final bool isApproved;
  final String id;
  final String programId;

  const FoodDetailScreen({
    super.key,
    required this.isApproved,
    required this.id,
    required this.programId,
  });

  @override
  Widget build(BuildContext context) {
    FoodDetailController controller = Get.put(FoodDetailController());
    controller.fetchFoodDetails(
      id,
      isApproved,
      programId,
    );

    return Scaffold(
      backgroundColor: AppColor.appBackgroundColor,
      appBar: const TransparentAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: AppSizer.vertical6,
            horizontal: AppSizer.horizontal20,
          ),
          child: Obx(() {
            if (controller.isLoading.value) {
              // Show shimmer effect while loading
              return _buildShimmerEffect();
            } else if (controller.errorMessage.isNotEmpty) {
              // Display error message
              return ErrorDisplay(
                errorMessage: controller.errorMessage.value,
                boxHeight: AppSizer.height * 0.8,
                onTap: () => controller.fetchFoodDetails(
                  id,
                  isApproved,
                  programId,
                ), // Retry logic
              );
              ;
            } else if (controller.foodDetailDataList.value?.data == null ||
                controller.foodDetailDataList.value!.data!.chart!.isEmpty) {
              // Handle no data case
              return WarningDisplay(
                boxHeight: AppSizer.height * 0.7,
                iconPath: 'assets/nutritionIcons/noMealSvg.svg',
                warningMessage: "No Meals Planned Yet!",
                subWarningMessage:
                    'Start by adding your meals for the day to stay on track with your nutrition goals.',
              );
            } else {
              // Show the actual content once data is available
              return FoodDetailWidget(
                title: controller.foodDetailDataList.value!.data!.title!,
                isApproved: false,
                description:
                    controller.foodDetailDataList.value!.data!.description!,
                listOfFood: controller.foodDetailDataList.value!.data!.chart!,
              );
            }
          }),
        ),
      ),
    );
  }

  Widget _buildShimmerEffect() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Shimmer effect for Title
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          //   color: AppColor.shimmerContentColor,
          child: Container(
            height: AppSizer.height * 0.035,
            width: AppSizer.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizer.width * 0.015),
              color: AppColor.shimmerContentColor,
            ),
          ),
        ),
        SizedBox(height: AppSizer.height * 0.005),

        // Shimmer effect for Description
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          child: Container(
            height: AppSizer.height * 0.022,
            width: AppSizer.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizer.width * 0.015),
              color: AppColor.shimmerContentColor,
            ),
          ),
        ),

        SizedBox(height: AppSizer.height * 0.03),
        // Shimmer effect for Table Header and Rows
        Shimmer.fromColors(
          baseColor: AppColor.shimmerBaseColor,
          highlightColor: AppColor.shimmerHighlightColor,
          //   color: AppColor.shimmerContentColor,
          child: Container(
            height: AppSizer.height * 0.2,
            width: AppSizer.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppSizer.width * 0.015),
              color: AppColor.shimmerContentColor,
            ),
          ),
        ),
      ],
    );
  }
}
// Error screen widget

// class FoodDetailScreen extends StatelessWidget {
//   final bool isApproved;
//   final String id;
//
//   const FoodDetailScreen({
//     super.key,
//     required this.isApproved,
//     required this.id,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     FoodDetailController controller  = Get.put(FoodDetailController());
//    controller.fetchFoodDetails(id, isApproved);
//
//     return FoodDetailWidget(
//       title: controller.foodDetailDataList.value!.data!.title!,
//       isApproved: isApproved,
//       description: controller.foodDetailDataList.value!.data!.description!,
//       listOfFood: controller.foodDetailDataList.value!.data!.chart!,
//     );
//   }
// }

// final title = isApproved ? 'Approved Foods' : 'Non-Approved Foods';
// final description = isApproved
//     ? 'Hydration is key for metabolism and energy levels. Stick to water, herbal teas, and black coffee to keep you hydrated without added sugars.'
//     : 'List of non-approved foods to avoid for better health.';

// Approved food list
// final approvedFoodList = [
//   FoodDetailModel(name: 'Mineral Water', quantity: '8-10 cups per day'),
//   FoodDetailModel(name: 'Milk', quantity: '30mls per day'),
//   FoodDetailModel(name: 'Herbal Tea', quantity: '1-2 cups per day'),
//   FoodDetailModel(name: 'Black Coffee', quantity: '1-2 cups per day'),
// ];
//
// // Non-approved food list
// final nonApprovedFoodList = [
//   FoodDetailModel(name: 'Sugary Drinks'),
//   FoodDetailModel(name: 'Fried Foods'),
//   FoodDetailModel(name: 'High-fat Dairy Products'),
//   FoodDetailModel(name: 'Processed Snacks'),
// ];

// final listOfFood = isApproved ? approvedFoodList : nonApprovedFoodList;

// Updated FoodDetailModel class with optional quantity

// FoodDetailModel class for defining food details

// class FoodDetailScreen extends StatelessWidget {
//   const FoodDetailScreen({
//     Key? key,
//   }) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return FoodDetailWidget(
//       title: 'Fluids',
//       isApproved: true,
//       description:
//           'Hydration is key for metabolism and energy levels. Stick to water, herbal teas, and black coffee to keep you hydrated without added sugars.',
//       listOfFood: [
//         FoodDetailModel(name: 'Mineral Water', quantity: '8-10 cups per day'),
//         FoodDetailModel(name: 'Milk', quantity: '30mls per day'),
//         FoodDetailModel(name: 'Thin Slice of Ginger', quantity: '1-2 pieces per day'),
//         FoodDetailModel(name: 'Herbal Tea', quantity: '1-2 cups per day'),
//         FoodDetailModel(name: 'Black Coffee', quantity: '1-2 cups per day'),
//         FoodDetailModel(name: 'Soda Water', quantity: '1-2 cups per day'),
//         FoodDetailModel(name: 'Soda Water', quantity: '1-2 cups per day'),
//         FoodDetailModel(name: 'Soda Water', quantity: '1-2 cups per day'),
//         FoodDetailModel(name: 'Soda Water', quantity: '1-2 cups per day'),
//         FoodDetailModel(name: 'Soda Water', quantity: '1-2 cups per day'),
//       ],
//     );
//   }
// }
// class FoodDetailWidget extends StatelessWidget {
//   final String title;
//   final String description;
//   final List<FoodDetailModel> listOfFood;
//
//   const FoodDetailWidget({
//     Key? key,
//     required this.title,
//     required this.description,
//     required this.listOfFood,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.appBackgroundColor,
//       appBar: const TransparentAppBar(),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//           vertical: AppSizer.vertical6,
//           horizontal: AppSizer.horizontal20,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Title and Description
//             MyManropeText(
//               text: title,
//               fontSize: AppSizer.fontSize22,
//               fontWeight: FontWeight.w900,
//             ),
//             SizedBox(height: AppSizer.height * 0.01),
//             MyManropeText(
//               text: description,
//               color: AppColor.greyTextColor,
//               fontWeight: FontWeight.w500,
//             ),
//             SizedBox(height: AppSizer.height * 0.025),
//
//             // Custom Table with Borders
//             Table(
//               border: TableBorder(
//                 top: BorderSide(color: AppColor.primaryColor1, width: 1.5),
//                 bottom: BorderSide(color: AppColor.primaryColor1, width: 1.5),
//                 left: BorderSide(color: AppColor.primaryColor1, width: 1.5),
//                 right: BorderSide(color: AppColor.primaryColor1, width: 1.5),
//                 horizontalInside: BorderSide(
//                   color: AppColor.primaryColor1.withOpacity(0.9),
//                   // Horizontal inner borders
//                   width: 1.5,
//                 ),
//                 verticalInside: BorderSide(
//                   color: AppColor.primaryColor1.withOpacity(0.9),
//                   // Vertical inner borders
//                   width: 1.5,
//                 ),
//               ),
//               columnWidths: const {
//                 0: FlexColumnWidth(1), // Adjusts width of the 'Name' column
//                 1: FlexColumnWidth(1), // Adjusts width of the 'Quantity' column
//               },
//               children: [
//                 // Header Row
//                 TableRow(
//                   decoration: BoxDecoration(
//                     color: AppColor.primaryColor1,
//                   ),
//                   children: [
//                     Center(
//                       child: Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: AppSizer.vertical2),
//                         child: MySofiaSansText(
//                           text: 'Name',
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: AppSizer.fontSize14,
//                         ),
//                       ),
//                     ),
//                     Center(
//                       child: Padding(
//                         padding:
//                             EdgeInsets.symmetric(vertical: AppSizer.vertical2),
//                         child: MySofiaSansText(
//                           text: 'Quantity',
//                           color: Colors.white,
//                           fontWeight: FontWeight.w700,
//                           fontSize: AppSizer.fontSize14,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 // Data Rows
//                 ...listOfFood.map((food) {
//                   return TableRow(
//                     decoration: BoxDecoration(
//                       color: AppColor.primaryColor4.withOpacity(0.7),
//                     ),
//                     children: [
//                       Center(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: AppSizer.vertical6),
//                           child: MyManropeText(
//                             text: food.name,
//                             color: AppColor.primaryColor1,
//                             fontSize: AppSizer.fontSize12,
//                           ),
//                         ),
//                       ),
//                       Center(
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                               vertical: AppSizer.vertical6),
//                           child: MyManropeText(
//                             text: food.quantity,
//                             color: AppColor.primaryColor1,
//                             fontSize: AppSizer.fontSize12,
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 }).toList(),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Model class to hold fluid data
// class FoodDetailModel {
//   final String name;
//   final String quantity;
//
//   FoodDetailModel({
//     required this.name,
//     required this.quantity,
//   });
// }
