import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/weak_diet_meal_model.dart';
import 'package:desa/features/nutrition/repository/nutration_repository.dart';
import 'package:get/get.dart';

class WeakDietMealController extends GetxController {
  var weakDietMealData = Rx<WeakDietMealModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchWeakDietMeal(String id, String weak) async {
    weakDietMealData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    var body = {"week": weak};
    print(id);
    print("__________________________________");
    try {
      isLoading.value = true;
      final MapSD response =
          await NutritionRepository().getWeakDietMeal(id, body);
      if (response.isNotEmpty) {
        weakDietMealData.value = WeakDietMealModel.fromJson(response);
      }

      isLoading.value = false;
      print(weakDietMealData.value!.data);
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
    }
  }

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
}
