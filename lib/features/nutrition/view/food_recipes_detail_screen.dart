import 'dart:io';

import 'package:desa/features/nutrition/controller/food_recieps_detail_controller.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/buttons/customeElevatedButton.dart';
import 'package:desa/utils/components/customeBottomSheet/custome_bottom_sheet.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/expandableTextWidget/expandableTextWidget.dart';
import 'package:desa/utils/components/image/app_cache_image.dart';
import 'package:desa/utils/components/image/custome_network_image.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class FoodRecipesDetailScreen extends StatelessWidget {
  final String id;
  final String? mealType;

  const FoodRecipesDetailScreen({super.key, required this.id, this.mealType});

  @override
  Widget build(BuildContext context) {
    FoodRecipesDetailController controller =
        Get.put(FoodRecipesDetailController());

    controller.fetchFoodRecipesFood(id);
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;

    final List<Color> cardColors = [
      AppColor.caloriesRed,
      AppColor.proteinBlue,
      AppColor.fatsYellow,
      AppColor.carbsGreen,
    ];

    return Scaffold(
      appBar: const TransparentAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () {
              if (controller.isLoading.value) {
                return _buildShimmerLoading(
                    context, width, height); // Show shimmer while loading
              }
              if (controller.errorMessage.value.isNotEmpty) {
                return ErrorDisplay(
                    onTap: () {
                      controller.fetchFoodRecipesFood(id);
                    },
                    errorMessage: controller.errorMessage.value);
              }
              var foodData = controller.foodRecipesFoodData.value?.data;
              // print("Image -----------------");
              // foodData?.mealImageUrl.toString().log("fd");
              if (foodData == null) {
                return WarningDisplay(
                  boxHeight: AppSizer.height * 0.7,
                  iconPath: 'assets/nutritionIcons/dietPlanSvg.svg',
                  warningMessage: "No Diet Plan Yet",
                  subWarningMessage:
                      'Create your nutrition plan to achieve your health goals.',
                );
              }

              final gridData = [
                {'title': 'Calories', 'value': foodData.mealCaloriesInGm ?? ''},
                {'title': 'Protein', 'value': foodData.mealProtienInGm ?? ''},
                {'title': 'Fat', 'value': foodData.mealFatsInGm ?? ''},
                {'title': 'Carbs', 'value': foodData.mealCarbsInGm ?? ''},
              ];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCacheImage(
                    image: foodData.mealImageUrl ?? '',
                    height: AppSizer.height * 0.3,
                    width: AppSizer.width,
                    fit: BoxFit.cover,
                    isNetworkImage: true,
                    errorWidget: Container(
                      height: AppSizer.height * 0.3,
                      width: AppSizer.width,
                      color: AppColor.greyTextColor.withOpacity(0.2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: height * 0.06),
                          Icon(
                            Icons.image,
                            color: AppColor.greyTextColor,
                            size: AppSizer.width * 0.1,
                          ),
                          SizedBox(height: height * 0.01),
                          MyManropeText(
                            text: 'Image not available',
                            color: AppColor.black,
                            fontSize: AppSizer.fontSize12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizer.horizontal20,
                        vertical: AppSizer.vertical15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyManropeText(
                          text: foodData.mealTitle ?? '',
                          color: AppColor.primaryColor2,
                          fontSize: AppSizer.fontSize18,
                        ),
                        if (foodData.mealDescription != "" ||
                            foodData.mealDescription!.isNotEmpty) ...[
                          SizedBox(height: height * 0.006),
                          ExpandableText(
                              description: foodData.mealDescription ?? ''),
                        ],
                        SizedBox(height: height * 0.01),
                        const Divider(),
                        SizedBox(height: height * 0.01),
                        MyManropeText(
                          text: 'Nutritional Information (per serving)',
                          color: AppColor.primaryColor2,
                          fontSize: AppSizer.fontSize18,
                        ),
                        SizedBox(height: height * 0.015),
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: width * 0.05,
                            mainAxisSpacing: height * 0.02,
                            childAspectRatio: width / (height * 0.135),
                          ),
                          itemCount: gridData.length,
                          itemBuilder: (context, index) {
                            final item = gridData[index];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: AppSizer.horizontal10),
                              decoration: BoxDecoration(
                                  color: cardColors[index].withOpacity(0.2),
                                  borderRadius:
                                      BorderRadius.circular(width * 0.025),
                                  border: Border.all(color: cardColors[index])),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MyManropeText(
                                    text: "${item['title']!}:",
                                    color: AppColor.greyTextColor,
                                    fontWeight: FontWeight.w800,
                                  ),
                                  SizedBox(width: width * 0.015),
                                  SizedBox(
                                    width: width * 0.2,
                                    child: MyManropeText(
                                      text: item['value']!,
                                      color: AppColor.greyTextColor,
                                      fontWeight: FontWeight.w500,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        SizedBox(height: height * 0.01),
                        if (controller.foodRecipesFoodData.value!.data!
                            .ingredients!.isNotEmpty) ...[
                          const Divider(),
                          SizedBox(height: height * 0.015),
                          MyManropeText(
                            text: 'Ingredients:',
                            color: AppColor.primaryColor2,
                            fontSize: AppSizer.fontSize18,
                          ),
                          SizedBox(height: height * 0.01),
                          ListView.builder(
                            itemCount: controller.foodRecipesFoodData.value!
                                .data!.ingredients!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = controller.foodRecipesFoodData.value!
                                  .data!.ingredients![index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSizer.horizontal10,
                                    vertical: AppSizer.vertical1),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyManropeText(
                                      text: "${(index + 1).toString()}.",
                                      fontSize: AppSizer.fontSize15,
                                      color: AppColor.greyTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(width: width * 0.025),
                                    Expanded(
                                      child: MyManropeText(
                                        text: item.steps!,
                                        fontSize: AppSizer.fontSize15,
                                        color: AppColor.greyTextColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                        if (controller.foodRecipesFoodData.value!.data!
                            .instructions!.isNotEmpty) ...[
                          SizedBox(height: height * 0.02),
                          MyManropeText(
                            text: 'Instructions:',
                            color: AppColor.primaryColor2,
                            fontSize: AppSizer.fontSize18,
                          ),
                          SizedBox(height: height * 0.01),
                          ListView.builder(
                            itemCount: controller.foodRecipesFoodData.value!
                                .data!.instructions!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final item = controller.foodRecipesFoodData.value!
                                  .data!.instructions![index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: AppSizer.horizontal10,
                                    vertical: AppSizer.vertical1),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    MyManropeText(
                                      text: "${(index + 1).toString()}.",
                                      fontSize: AppSizer.fontSize15,
                                      color: AppColor.greyTextColor,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    SizedBox(width: width * 0.025),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          MyManropeText(
                                            text: item.title!,
                                            fontSize: AppSizer.fontSize15,
                                            color: AppColor.greyTextColor,
                                            fontWeight: FontWeight.w700,
                                            maxLines: 1000,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          SizedBox(height: height * 0.04),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: AppSizer.horizontal20,
          right: AppSizer.horizontal20,
          bottom: Platform.isIOS ? AppSizer.vertical10 : AppSizer.vertical5,
          top: AppSizer.vertical10,
        ),
        child: CustomeButton(
          text: "Add to Meal",
          onPressed: () {
            controller.selectedQuantity.value = '';
            controller.selectedMealType.value = mealType ?? '';
            controller.numberOfServing.value = 1;
            showAddMealBottomSheet(context, controller, id, mealType ?? '');
            // _showAddMealBottomSheet(context, controller, width,
            //     height); // Call the bottom sheet method
          },
          horizontalPadding: width * 0.35,
        ),
      ),
    );
  }

  void showAddMealBottomSheet(BuildContext contextt,
      FoodRecipesDetailController controller, String mealId, String mealType) {
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
          selectedMealType: mealType,
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
            // Handle any other onChange logic if needed

            controller.addMeal(mealId, contextt);

            print(controller.selectedQuantity.value);
            print(controller.numberOfServing.value);
            print(controller.selectedMealType.value);
            context.pop();
          },
        );
      },
    );
  }

  Widget _buildShimmerLoading(
      BuildContext context, double width, double height) {
    return Shimmer.fromColors(
      baseColor: AppColor.shimmerBaseColor,
      highlightColor: AppColor.shimmerHighlightColor,
      // color: AppColor.shimmerContentColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: height * 0.3,
            color: AppColor.shimmerContentColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppSizer.horizontal20,
                vertical: AppSizer.vertical15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width * 0.5,
                  height: height * 0.02,
                  color: Colors.white,
                ),
                SizedBox(height: height * 0.01),
                Container(
                  width: width * 0.8,
                  height: height * 0.015,
                  color: Colors.white,
                ),
                SizedBox(height: height * 0.01),
                const Divider(),
                SizedBox(height: height * 0.01),
                Container(
                  width: width * 0.6,
                  height: height * 0.02,
                  color: Colors.white,
                ),
                SizedBox(height: height * 0.015),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: width * 0.05,
                    mainAxisSpacing: height * 0.02,
                    childAspectRatio: width / (height * 0.135),
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      height: height * 0.08,
                    );
                  },
                ),
                SizedBox(height: height * 0.01),
                const Divider(),
                SizedBox(height: height * 0.015),
                Container(
                  width: width * 0.6,
                  height: height * 0.02,
                  color: Colors.white,
                ),
                SizedBox(height: height * 0.01),
                ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: AppSizer.vertical1),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.05,
                            height: height * 0.02,
                            color: Colors.white,
                          ),
                          SizedBox(width: width * 0.025),
                          Expanded(
                            child: Container(
                              height: height * 0.02,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// void _showAddMealBottomSheet(BuildContext context,
//     FoodRecipesDetailController controller, double width, double height) {
//   showModalBottomSheet(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (BuildContext context) {
//       return Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(
//               width: AppSizer.width,
//             ),
//             MyManropeText(
//               text: 'Meal Type:',
//               color: AppColor.primaryColor2,
//               fontWeight: FontWeight.w700,
//               fontSize: AppSizer.width * 0.04,
//             ),
//             SizedBox(height: AppRes.height * 0.02),
//             Obx(
//               () => Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 alignment: WrapAlignment.start,
//                 // spacing: 8.0,
//                 // runSpacing: 8.0,
//                 children: List.generate(
//                   controller.mealType.length,
//                   (index) {
//                     final meal = controller.mealType[index];
//                     final isSelected = controller.selectedMealType.isNotEmpty;
//
//
//                     return GestureDetector(
//                       onTap: () {
//                         if (isSelected) {
//                           controller.selectedMealType.value = '';
//                         } else {
//                           controller.selectedMealType.value = meal;
//                         }
//                         controller.selectedMealType.refresh();
//                       },
//                       child: CommonTagWidget(
//                         text: meal,
//                         isSelected: isSelected,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             MyManropeText(
//               text: 'Add Qty :',
//               color: AppColor.primaryColor2,
//               fontWeight: FontWeight.w700,
//               fontSize: AppSizer.width * 0.04,
//             ),
//             SizedBox(height: AppRes.height * 0.02),
//             Obx(
//               () => Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 alignment: WrapAlignment.start,
//                 // spacing: 8.0,
//                 // runSpacing: 8.0,
//                 children: List.generate(
//                   controller.quantity.length,
//                   (index) {
//                     final quantity = controller.quantity[index];
//                     final isSelected = controller.selectedQuantity.isNotEmpty;
//
//                     return GestureDetector(
//                       onTap: () {
//                         if (isSelected) {
//                           controller.selectedQuantity.value = '';
//                         } else {
//                           controller.selectedQuantity.value = quantity;
//                         }
//                         controller.selectedQuantity.refresh();
//                       },
//                       child: CommonTagWidget(
//                         text: quantity,
//                         isSelected: isSelected,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//             Row(
//               children: [
//                 MyManropeText(
//                   text: 'Servings :',
//                   color: AppColor.primaryColor2,
//                   fontWeight: FontWeight.w700,
//                   fontSize: AppSizer.width * 0.04,
//                 ),
//                 SizedBox(
//                   width: width * 0.025,
//                 ),
//                 Row(
//                   children: [
//                     // Decrease Button
//                     GestureDetector(
//                       onTap: () {
//                         controller.decreaseQuantity();
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: AppColor.greyTextColor.withOpacity(0.1),
//                           // borderRadius: BorderRadius.circular(2)
//                         ),
//                         child: Center(
//                             child: Icon(
//                           Icons.remove,
//                           size: width * 0.06,
//                         )),
//                       ),
//                     ),
//                     // Quantity Text
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: width * 0.03),
//                       alignment: Alignment.center,
//                       child: Obx(() {
//                         return MyManropeText(
//                           text: controller.numberOfServing.value.toString(),
//                           fontSize: width * 0.04,
//                         );
//                       }),
//                     ),
//                     // Increase Button
//                     GestureDetector(
//                       onTap: () {
//                         controller.increaseQuantity();
//                       },
//                       child: Container(
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: AppColor.greyTextColor.withOpacity(0.1)),
//                         child: Icon(
//                           Icons.add,
//                           size: width * 0.06,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             SizedBox(height: AppRes.height * 0.02),
//             Center(
//               child: CustomeButton(
//                 text: "Add Meal",
//                 onPressed: () {},
//                 horizontalPadding: width * 0.35,
//               ),
//             )
//           ],
//         ),
//       );
//     },
//   );
// }

// void _showAddMealBottomSheet(
//     BuildContext context, FoodRecipesDetailController controller) {
//   showModalBottomSheet(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//     ),
//     builder: (BuildContext context) {
//
//       return Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             MyManropeText(
//               text: 'Meal Type:',
//               color: AppColor.primaryColor2,
//               fontWeight: FontWeight.w700,
//               fontSize: AppSizer.width * 0.04,
//             ),
//             SizedBox(height: 12),
//             Obx(
//               () => Wrap(
//                 crossAxisAlignment: WrapCrossAlignment.center,
//                 alignment: WrapAlignment.center,
//                 children: [
//                   // Use the reactive hobbies list to build the UI
//                   ...List.generate(
//                     controller.mealType.length,
//                     (index) => GestureDetector(
//                       onTap: () {
//                         controller.selectedMealType.value
//                             .add(controller.mealType[index]);
//
//                       },
//                       child: CommonTagWidget(
//                         text: controller.mealType.value[index],
//                         isSelected: controller.selectedMealType.value
//                             .contains(controller.mealType.value[index]),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             // Wrap(
//             //     children: List.generate(
//             //   5,
//             //   (index) {
//             //     return Padding(
//             //       padding:  EdgeInsets.symmetric(vertical: AppRes.height*0.005,horizontal: AppSizer.width*0.01),
//             //       child: Container(
//             //         padding:  EdgeInsets.symmetric(vertical: AppRes.height*0.005,horizontal: AppSizer.width*0.05),
//             //         height: AppRes.height * 0.03,
//             //         // width: AppSizer.width * 0.3,
//             //         child: MyManropeText(text: "Text",),
//             //         decoration: BoxDecoration(
//             //             border: Border.all(),
//             //
//             //             borderRadius: BorderRadius.circular(AppSizer.width * .025)),
//             //       ),
//             //     );
//             //   },
//             // )),
//             ListTile(
//               leading: Icon(Icons.lunch_dining),
//               title: Text("Lunch"),
//               onTap: () {
//                 // Handle lunch selection
//                 Navigator.pop(context);
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.dinner_dining),
//               title: Text("Dinner"),
//               onTap: () {
//                 // Handle dinner selection
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

// Center(
//   child: SearchMealDropDown(
//     items: const ['50 g', '100 g', '150 g', "200 g"],
//     selectedValue: controller.selectedMeal.value,
//     onSelected: (value) {
//       controller.selectedMeal2.value = value;
//       String quantity =
//           value.replaceAll(RegExp(r'\s|g'), '');
//
//       // Check if the new quantity is the same as the previously selected quantity
//       if (value == controller.selectedMeal.value) {
//         // If the same quantity is selected, print a warning message
//         AppSnackBar.showSnackbar(
//             type: SnackbarType.warning,
//             title:
//                 "Warning: You have already selected this quantity.",
//             context: context);
//         print(
//             'Warning: You have already selected this quantity.');
//       } else {
//         // If it's a new quantity, call the addMeal method
//         controller
//             .addMeal(quantity, id, context)
//             .then((value) {
//           controller.selectedMeal.value =
//               controller.selectedMeal2.value;
//         });
//       }
//       // controller.addMeal(value, id, context);
//
//       // setState(() {
//       //   selectedValue = value;
//       //   widget.onChange(value);
//       // });
//     },
//   ),
// ),
// class CommonTagWidget extends StatelessWidget {
//   final bool? isSelected;
//   final String text;
//
//   const CommonTagWidget({
//     super.key,
//     this.isSelected = false,
//     required this.text,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.sizeOf(context).width;
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(color: AppColor.primaryColor1, width: 1.0),
//         color: isSelected! ? AppColor.primaryColor1 : Colors.white,
//         borderRadius: BorderRadius.circular(width * 0.1),
//       ),
//       padding: EdgeInsets.symmetric(
//         horizontal: width * 0.03,
//         vertical: width * 0.012,
//       ),
//       margin: EdgeInsets.only(
//         right: width * 0.02,
//         bottom: width * 0.02,
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           MyManropeText(
//             text: text,
//             fontSize: width * 0.035,
//             fontWeight: FontWeight.w600,
//             color: isSelected! ? Colors.white : AppColor.primaryColor1,
//           ),
//         ],
//       ),
//     );
//   }
// }
