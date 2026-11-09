import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/food_recieps_detail_model.dart';
import 'package:desa/features/progress/repository/nutrition_diary_repository.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repository/nutration_repository.dart';

class FoodRecipesDetailController extends GetxController {
  var foodRecipesFoodData = Rx<FoodRecipesDetailModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // RxList<String> mealType = ['BrackFast', "Lunch", "Snacks", "Dinner"].obs;
  // RxList<String> quantity = ['50 g', "100 g", "150 g", "250 g"].obs;
  RxString selectedMealType = ''.obs;
  RxString selectedQuantity = ''.obs;
  RxInt numberOfServing = 1.obs;

  void increaseQuantity() {
    numberOfServing.value++;
  }

  // Method to decrease quantity
  void decreaseQuantity() {
    if (numberOfServing.value > 1) {
      numberOfServing.value--;
    }
  }

  Future<void> fetchFoodRecipesFood(String id) async {
    foodRecipesFoodData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;
      final MapSD response =
          await NutritionRepository().getFoodRecipesDetail(id);
      if (response.isNotEmpty) {
        foodRecipesFoodData.value = FoodRecipesDetailModel.fromJson(response);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }

  var errorMessageForAddMeal = ''.obs;
  RxString selectedMeal = ''.obs;
  RxString selectedMeal2 = ''.obs;

  Future<void> addMeal(String mealId, BuildContext context) async {
    selectedQuantity.value = selectedQuantity.replaceAll(RegExp(r'\s|g'), '');

    errorMessageForAddMeal.value = ''; // Reset error message
    // print(quantity);
    print(mealId);
    print("((((((((((((((object))))))))))))))");
    print(selectedMealType.value);
    MapSS body = {
      "meal_id": mealId,
      "quantity": selectedQuantity.value.trim(),
      "meal_type": selectedMealType.value.trim(),
      "servings": numberOfServing.value.toString()
    };

    // MapSS body = {"meal_id": mealId, "quantity": quantity.trim()};
    try {
      final MapSD response = await NutritionDiaryRepository().addMeal(body);

      if (response.isNotEmpty) {
        String status = response['status']; // Check for the status
        String message = response['message']; // Get the message

        if (status == 'error') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.warning, title: message, context: context);
        } else if (status == 'success') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.success, title: message, context: context);
        } else if (status == 'warning') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.warning, title: message, context: context);
        }
      }
    } catch (e) {
      errorMessageForAddMeal.value = '${e.toString()}  Please try again later.';
      print(e);
      print(e.toString());
      print("_____________________________________");
      AppSnackBar.showSnackbar(
          type: SnackbarType.error,
          title: errorMessageForAddMeal.value,
          context: context);
    }
  }
}
