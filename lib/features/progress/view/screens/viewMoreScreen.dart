import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
import 'package:desa/features/progress/view/widgets/consumed_meal_card_widget.dart';
import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/customeBottomSheet/custome_bottom_sheet.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_svg.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../utils/components/error_display/erroe_dispaly.dart';
class ViewMoreScreen extends StatelessWidget {
  final MyNutritionDiaryController controller;
  const ViewMoreScreen({super.key, required this.controller});
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: const TransparentAppBar(),
      body: RefreshIndicator(
        color: AppColor.primaryColor1,
        onRefresh: () async {
          // Trigger the refresh by calling the fetch method
          await controller.fetchConsumedMealData();
        },
        child: Obx(() {
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
            return Center(child: _buildNoDataMessage(width, height));
          } else {
            final meals = controller.consumedMealData.value!.data!;
            return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: AppSizer.horizontal15,
                  vertical: AppSizer.vertical6),
              child: ListView.builder(
                itemCount: meals.length,
                itemBuilder: (context, index) {
                  final meal = meals[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: height * 0.001),
                    child: ConsumedMealCardWidget(
                      imageUrl: meal.image!,
                      title: meal.mealName!,
                      calories: meal.calories!.toString(),
                      carbs: meal.carbs!.toString(),
                      fats: meal.fat!.toString(),
                      protein: meal.protein!.toString(),
                      quantity: meal.quantity!,
                      onTapDelete: (){
                        controller.deleteConsumedMealData(
                            meal.id.toString(), index);
                      },
                      // onChange: (value) {
                      //   // Remove spaces and 'g' from the selected value
                      //   String quantity = value.replaceAll(RegExp(r'\s|g'), '');
                      //
                      //   // Check if the new quantity is the same as the previously selected quantity
                      //   if (quantity == meal.quantity.toString()) {
                      //     // If the same quantity is selected, print a warning message
                      //     AppSnackBar.showSnackbar(
                      //         type: SnackbarType.warning,
                      //         title:
                      //             "Warning: You have already selected this quantity.",
                      //         context: context);
                      //     print(
                      //         'Warning: You have already selected this quantity.');
                      //   } else {
                      //     // If it's a new quantity, call the addMeal method
                      //     // controller
                      //     //     .addMeal(
                      //     //         quantity, meal.mealId.toString(), context)
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
                    ),
                  );
                },
              ),
            );
          }
        }),
      ),
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
            // Handle any other onChange logic if needed

            // controller.addMeal(mealId, contextt);

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
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: AppSizer.horizontal15, vertical: AppSizer.vertical6),
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.01),
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: height * 0.17,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNoDataMessage(double width, double height) {
    return Container(
      width: width,
      height: height * 0.2,
      margin: EdgeInsets.symmetric(
        vertical: AppSizer.vertical10,
        horizontal: AppSizer.horizontal15,
      ),
      decoration: BoxDecoration(
        border: Border.all(
            color: const Color.fromARGB(255, 228, 98, 111), width: 1.6),
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFFFDFE2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppSvg.packetFood),
          SizedBox(height: height * 0.012),
          MyManropeText(
            text: "No Meals Logged Yet \nTime to Fuel Your Body!",
            color: AppColor.primaryColor1,
            height: width * 0.0044,
            fontWeight: FontWeight.w900,
            fontSize: AppSizer.fontSize15,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
