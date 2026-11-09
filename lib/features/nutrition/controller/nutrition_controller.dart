import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/nutration_all_program_model.dart';
import 'package:desa/features/nutrition/models/search_meal_model.dart';
import 'package:desa/features/nutrition/repository/nutration_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NutritionController extends GetxController
    with SingleGetTickerProviderMixin {
  var isSearchFocused = false.obs;
  var selectedMealType = 'Meal Type'.obs;
  late AnimationController animationController;
  late Animation<double> fadeAnimation;
  late Animation<double> positionAnimation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    fetchNutritionAllPrograms();
    fadeAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    ));
    positionAnimation = Tween<double>(begin: 0.12, end: 0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
    );
  }

  void onSearchTap() {
    isSearchFocused.value = true;
    animationController.forward();
  }

  void onSearchFocusLost() {
    isSearchFocused.value = false;
    animationController.reverse();
    searchController.clear();
  }

  void updateMealType(String mealType) {
    selectedMealType.value = mealType;
    fetchSearchMeal(searchController.text);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }

  var nutritionAllProgramData = Rx<NutritionAllProgramModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchNutritionAllPrograms() async {
    nutritionAllProgramData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;

      final MapSD response =
          await NutritionRepository().getNutritionAllPrograms();
      if (response.isNotEmpty) {
        nutritionAllProgramData.value =
            NutritionAllProgramModel.fromJson(response);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }

  TextEditingController searchController = TextEditingController();
  var searchMealData = Rx<SearchMealModel?>(null);
  var isLoadingSearch = false.obs;
  var errorMessageSearch = ''.obs;

  Future<void> fetchSearchMeal(String meal) async {
    searchMealData.value = null; // Reset FAQ data
    errorMessageSearch.value = ''; // Reset error message
    print(searchController.text);
    print("))))))))))))))))))))))))))))))))");
    MapSS query = {
      'meal': meal,
      'meal_type': selectedMealType.value,
    };
    try {
      isLoadingSearch.value = true;

      final MapSD response = await NutritionRepository().searchMeal(query);
      if (response.isNotEmpty) {
        searchMealData.value = SearchMealModel.fromJson(response);
      }

      isLoadingSearch.value = false;
    } catch (e) {
      isLoadingSearch.value = false;
      errorMessageSearch.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}
