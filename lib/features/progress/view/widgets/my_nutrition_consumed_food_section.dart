import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
import 'package:desa/features/progress/view/widgets/consumed_meal_card_widget.dart';
import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/customeBottomSheet/custome_bottom_sheet.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:desa/utils/constants/resuable_box_decoration.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class MyNutritionConsumedFoodSection extends StatelessWidget {
  final MyNutritionDiaryController controller;

  const MyNutritionConsumedFoodSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.02),
        MyManropeText(
          text: "Consumed Food",
          color: AppColor.primaryColor2,
          fontWeight: FontWeight.w900,
          fontSize: AppSizer.fontSize16,
        ),
        SizedBox(height: height * 0.015),
        Obx(() {
          if (controller.isLoadingConsumedMeal.value) {
            return _buildShimmerList(height);
          } else if (controller.errorMessageConsumedMeal.value.isNotEmpty) {
            return ErrorDisplay(
              boxHeight: height * 0.424,
              errorMessage: controller.errorMessageConsumedMeal.value,
              onTap: controller.fetchConsumedMealData,
            );
          } else if (controller.consumedMealData.value?.data == null ||
              controller.consumedMealData.value!.data!.isEmpty) {
            return _buildNoDataMessage(width, height, context);
          } else {
            final meals = controller.consumedMealData.value!.data!;
            // final displayedMeals =
            //     meals.take(2).toList(); // Show first 2 meals initially

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  itemCount: controller.consumedMealData.value!.data!.length > 2
                      ? 2
                      : controller.consumedMealData.value!.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final meal = meals[index];
                    return ConsumedMealCardWidget(
                      imageUrl: meal.image!,
                      title: meal.mealName!,
                      calories: meal.calories!.toString(),
                      carbs: meal.carbs!.toString(),
                      fats: meal.fat!.toString(),
                      protein: meal.protein!.toString(),
                      quantity: meal.quantity!,
                      onTapDelete: () {
                        controller.deleteConsumedMealData(
                            meal.id.toString(), index);
                      },
                      // onChange: (value) {
                      //   String quantity = value.replaceAll(RegExp(r'\s|g'), '');
                      //
                      //   if (quantity == meal.quantity.toString()) {
                      //     AppSnackBar.showSnackbar(
                      //         type: SnackbarType.warning,
                      //         title:
                      //             "Warning: You have already selected this quantity.",
                      //         context: context);
                      //   } else {
                      //     // controller.addMeal(
                      //     //     quantity, meal.mealId.toString(), context);
                      //     //     .then((value) {
                      //     //   meal.quantity = quantity;
                      //     // });
                      //   }
                      //   // Handle any other onChange logic if needed
                      // },
                      onTap: () {
                        print(meal.quantity);
                        controller.selectedMealType.value = meal.mealType ?? '';
                        controller.selectedQuantity.value = meal.quantity ?? '';
                        controller.numberOfServing.value =
                            int.parse(meal.servings!);
                        print(controller.selectedQuantity.value);
                        print(controller.selectedMealType.value);
                        print(controller.numberOfServing.value);
                        showAddMealBottomSheet(
                            context,
                            controller,
                            meal.id.toString(),
                            meal.mealType!,
                            meal.quantity!,
                            int.parse(meal.servings!));
                        // controller.deleteConsumedMealData(
                        //     meal.id.toString(), index);
                        // context.push(AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
                        //     extra: {'id': meal.id.toString()});
                      },
                    );
                  },
                ),
                // View More Button
                if (meals.length > 2)
                  TextButton(
                      onPressed: () {
                        context.push(AppRoutes.VIEW_MORE_SCREEN,
                            extra: {'controller': controller});
                      },
                      child: const MyManropeText(
                        text: 'View More',
                        fontWeight: FontWeight.w800,
                      )),
              ],
            );
          }
        }),
      ],
    );
  }

  void showAddMealBottomSheet(
      BuildContext contextt,
      MyNutritionDiaryController controller,
      String mealId,
      String getMealType,
      String getMealQuantity,
      int getNumberServing) {
    showModalBottomSheet(
      context: contextt,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSizer.width * 0.05)),
      ),
      builder: (BuildContext context) {
        return AddMealBottomSheet(
          mealTypes: const ['Breakfast', 'Lunch', 'Dinner', 'Snacks'],
          quantities: const ['50 g', '100 g', '150 g', '250 g'],
          initialServings: 1,
          selectedMealType: getMealType,
          selectedQuantity: getMealQuantity,
          selectedServings: getNumberServing,
          onMealTypeSelected: (selectedMeal) {
            controller.selectedMealType.value = selectedMeal;
          },
          onQuantitySelected: (selectedQuantity) {
            controller.selectedQuantity.value = selectedQuantity;
          },
          onServingsChanged: (newServings) {
            controller.numberOfServing.value = newServings;
          },
          onTap: () {
            controller.editMeal(mealId, contextt);

            print(controller.selectedQuantity.value);
            print(controller.numberOfServing.value);
            print(controller.selectedMealType.value);
            context.pop();
          },
        );
      },
    );
  }

  Widget _buildShimmerList(double height) {
    return SizedBox(
      height: height * 0.513,
      child: ListView.builder(
        itemCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: height * 0.22,
              margin: EdgeInsets.only(bottom: height * 0.012),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoDataMessage(
      double width, double height, BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(
        vertical: AppSizer.vertical6,
        horizontal: width * 0.16,
      ),
      decoration: ReusableDecoration.reusableBoxDecoration(context: context),
      child: Column(
        children: [
          SvgPicture.asset(
            AppSvg.packetFood,
            width: width * 0.11,
          ),
          SizedBox(height: height * 0.012),
          MyManropeText(
            text: "No Meals Logged Yet\nTime to Fuel Your Body!",
            color: AppColor.primaryColor1,
            height: width * 0.0044,
            fontWeight: FontWeight.w900,
            fontSize: AppSizer.fontSize12,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: height * 0.01,
          ),
          CustomeButton(
            text: "Add Meal",
            onPressed: controller.onSearchTap,
            colour: AppColor.cardBackGroundBlueColor,
            borderColor: Colors.white,
            horizontalPadding: width * 0.1,
            textColour: Colors.black,
          )
        ],
      ),
    );
  }
}

// class MyNutritionConsumedFoodSection extends StatelessWidget {
//   final MyNutritionDiaryController controller;
//   const MyNutritionConsumedFoodSection({super.key, required this.controller});
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     final RxBool isExpanded = false.obs;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: height * 0.02),
//         MyManropeText(
//           text: "Consumed Food",
//           color: AppColor.primaryColor2,
//           fontWeight: FontWeight.w900,
//           fontSize: AppSizer.fontSize16,
//         ),
//         SizedBox(height: height * 0.02),
//         Obx(() {
//           if (controller.isLoadingConsumedMeal.value) {
//             // Show shimmer effect while loading
//             return _buildShimmerList(height);
//           } else if (controller.errorMessageConsumedMeal.value.isNotEmpty) {
//             // Show error message if there's an error
//
//             return ErrorDisplay(
//               boxHeight: height * 0.424,
//               errorMessage: controller.errorMessageConsumedMeal.value,
//               onTap: controller.fetchConsumedMealData, // Retry logic
//             );
//           } else if (controller.consumedMealData.value?.data == null ||
//               controller.consumedMealData.value!.data!.isEmpty) {
//             // Show "No Data" message when the list is empty
//             return _buildNoDataMessage(width, height);
//           } else {
//             // Show the actual consumed meal list
//             final meals = controller.consumedMealData.value!.data!;
//             final displayedMeals =
//                 isExpanded.value ? meals : meals.take(2).toList();
//
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ListView.builder(
//                   itemCount: displayedMeals.length,
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     final meal = displayedMeals[index];
//                     return ConsumedMealCardWidget(
//                       imageUrl: meal.image!,
//                       title: meal.mealName!,
//                       calories: meal.calories!.toString(),
//                       carbs: meal.carbs!.toString(),
//                       fats: meal.fat!.toString(),
//                       protein: meal.protein!.toString(),
//                       onTap: () {
//                         context.push(AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
//                             extra: {'id': meal.id.toString()});
//                       },
//                     );
//                   },
//                 ),
//                 if (meals.length >
//                     2) // Only show the toggle button if meals > 2
//                   TextButton(
//                     onPressed: () {
//                       isExpanded.value = !isExpanded.value;
//                     },
//                     child: Text(
//                       isExpanded.value ? "Show Less" : "Show Full",
//                       style: TextStyle(
//                         color: AppColor.primaryColor1,
//                         fontWeight: FontWeight.w700,
//                         fontSize: AppSizer.fontSize14,
//                       ),
//                     ),
//                   ),
//               ],
//             );
//           }
//         }),
//       ],
//     );
//   }
//
//   // Shimmer effect for loading state
//   Widget _buildShimmerList(double height) {
//     return SizedBox(
//       height: height * 0.424,
//       child: ListView.builder(
//         itemCount: 2, // Number of shimmer items
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: height * 0.01),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 height: height * 0.17,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // No Data Message
//   Widget _buildNoDataMessage(double width, double height) {
//     return Container(
//       width: width,
//       padding: EdgeInsets.symmetric(
//         vertical: AppSizer.vertical10,
//         horizontal: width * 0.16,
//       ),
//       decoration: BoxDecoration(
//         border: Border.all(
//             color: const Color.fromARGB(255, 228, 98, 111), width: 1.6),
//         borderRadius: BorderRadius.circular(8),
//         color: const Color(0xFFFFDFE2),
//       ),
//       child: Column(
//         children: [
//           SvgPicture.asset(AppSvg.packetFood),
//           SizedBox(height: height * 0.012),
//           MyManropeText(
//             text: "No Meals Logged Yet \nTime to Fuel Your Body!",
//             color: AppColor.primaryColor1,
//             height: width * 0.0044,
//             fontWeight: FontWeight.w900,
//             fontSize: AppSizer.fontSize15,
//             textAlign: TextAlign.center,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyNutritionConsumedFoodSection extends StatelessWidget {
//   final MyNutritionDiaryController controller;
//
//   const MyNutritionConsumedFoodSection({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: height * 0.02),
//         MyManropeText(
//           text: "Consumed Food",
//           color: AppColor.primaryColor2,
//           fontWeight: FontWeight.w900,
//           fontSize: AppSizer.fontSize16,
//         ),
//         SizedBox(height: height * 0.02),
//
//         // Handle different states using Obx
//
//         Obx(() {
//           if (controller.isLoadingConsumedMeal.value) {
//             // Show shimmer effect while loading
//             return _buildShimmerList(height);
//           } else if (controller.errorMessageConsumedMeal.value.isNotEmpty) {
//             // Show error message if there's an error
//             return ErrorDisplay(
//               boxHeight: height*0.3,
//               errorMessage: controller.errorMessageConsumedMeal.value,
//               onTap: controller.fetchConsumedMealData, // Retry logic
//             );
//           } else if (controller.consumedMealData.value?.data == null ||
//               controller.consumedMealData.value!.data!.isEmpty) {
//             // Show "No Data" message when the list is empty
//             return _buildNoDataMessage(width, height);
//           } else {
//             // Show the actual consumed meal list
//             return ListView.builder(
//               itemCount: controller.consumedMealData.value!.data!.length,
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemBuilder: (context, index) {
//                 final meal = controller.consumedMealData.value!.data![index];
//                 return ConsumedMealCardWidget(
//                   imageUrl: meal.image!,
//                   title: meal.mealName!,
//                   calories: meal.calories!.toString(),
//                   carbs: meal.carbs!.toString(),
//                   fats: meal.fat!.toString(),
//                   protein: meal.protein!.toString(),
//                   onTap: () {
//                     // Define your onTap logic here
//                   },
//                 );
//               },
//             );
//           }
//         }),
//       ],
//     );
//   }
//
//   // Shimmer effect for loading state
//   Widget _buildShimmerList(double height) {
//     return SizedBox(
//       height: height * 0.3,
//       child: ListView.builder(
//         itemCount: 2, // Number of shimmer items
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: height * 0.01),
//             child: Shimmer.fromColors(
//               baseColor: Colors.grey[300]!,
//               highlightColor: Colors.grey[100]!,
//               child: Container(
//                 height: height * 0.13,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   // No Data Message
//   Widget _buildNoDataMessage(double width, double height) {
//     return
//     Container(
//       width: width,
//           padding: EdgeInsets.symmetric(
//             vertical: AppSizer.vertical10,
//             horizontal: width * 0.16,
//           ),
//           decoration: BoxDecoration(
//             border: Border.all(
//                 color: const Color.fromARGB(255, 228, 98, 111), width: 1.6),
//             borderRadius: BorderRadius.circular(8),
//             color: const Color(0xFFFFDFE2),
//           ),
//           child: Column(
//             children: [
//               SvgPicture.asset(AppSvg.packetFood),
//               SizedBox(height: height * 0.012),
//               MyManropeText(
//                 text: "No Meals Logged Yet \nTime to Fuel Your Body!",
//                 color: AppColor.primaryColor1,
//                 height: width * 0.0044,
//                 fontWeight: FontWeight.w900,
//                 fontSize: AppSizer.fontSize15,
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         );
//   }
// }

// class MyNutritionConsumedFoodSection extends StatelessWidget {
//   MyNutritionDiaryController controller;
//
//   MyNutritionConsumedFoodSection({super.key, required this.controller});
//
//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         SizedBox(height: height * 0.02),
//         MyManropeText(
//           text: "Consumed Food",
//           color: AppColor.primaryColor2,
//           fontWeight: FontWeight.w900,
//           fontSize: AppSizer.fontSize16,
//         ),
//         SizedBox(height: height * 0.02),
//
//         Obx(()=>   ListView.builder(
//        itemCount: controller.consumedMealData.value!.data!.length,
//        shrinkWrap: true,
//        physics: const NeverScrollableScrollPhysics(),
//        itemBuilder: (context, index) {
//          return ConsumedMealCardWidget(
//            imageUrl: controller.consumedMealData.value!.data![index].image!,
//            title: controller.consumedMealData.value!.data![index].mealName!,
//            calories: controller
//                .consumedMealData.value!.data![index].calories!
//                .toString(),
//            carbs: controller.consumedMealData.value!.data![index].carbs!
//                .toString(),
//            fats: controller.consumedMealData.value!.data![index].fat!
//                .toString(),
//            protein: controller.consumedMealData.value!.data![index].protein
//                .toString(),
//            onTap: () {},
//          );
//        },
//      )),
//
//         // Container(
//         //   width: width,
//         //   padding: EdgeInsets.symmetric(
//         //     vertical: AppSizer.vertical10,
//         //     horizontal: width * 0.16,
//         //   ),
//         //   decoration: BoxDecoration(
//         //     border: Border.all(
//         //         color: const Color.fromARGB(255, 228, 98, 111), width: 1.6),
//         //     borderRadius: BorderRadius.circular(8),
//         //     color: const Color(0xFFFFDFE2),
//         //   ),
//         //   child: Column(
//         //     children: [
//         //       SvgPicture.asset(AppSvg.packetFood),
//         //       SizedBox(height: height * 0.012),
//         //       MyManropeText(
//         //         text: "No Meals Logged Yet \nTime to Fuel Your Body!",
//         //         color: AppColor.primaryColor1,
//         //         height: width * 0.0044,
//         //         fontWeight: FontWeight.w900,
//         //         fontSize: AppSizer.fontSize15,
//         //         textAlign: TextAlign.center,
//         //       ),
//         //     ],
//         //   ),
//         // ),
//       ],
//     );
//   }
// }
