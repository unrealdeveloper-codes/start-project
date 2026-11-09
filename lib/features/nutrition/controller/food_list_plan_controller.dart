import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/food_list_plan_model.dart';
import 'package:desa/features/nutrition/repository/nutration_repository.dart';
import 'package:get/get.dart';

class FoodListPlanController extends GetxController {
  var foodListPlanData = Rx<FoodListPlanModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchFoodListPlanData(
      String id, String mealType, String weak, String day) async {
    foodListPlanData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message

    var body = {"week": weak, "meal_type": mealType, "day": day};

    try {
      isLoading.value = true;
      final MapSD response =
          await NutritionRepository().getFoodListPlanData(id, body);
      if (response.isNotEmpty) {
        foodListPlanData.value = FoodListPlanModel.fromJson(response);
      }

      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}
