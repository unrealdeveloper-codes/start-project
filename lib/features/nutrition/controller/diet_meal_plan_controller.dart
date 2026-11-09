import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/diet_meal_model.dart';
import 'package:desa/features/nutrition/repository/nutration_repository.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:get/get.dart';

class DietMealPlanController extends GetxController {
  var dietMealPlanListData = Rx<DietMeaLModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchDietMealPlan(String id) async {
    dietMealPlanListData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;
      final MapSD response =
          await NutritionRepository().getDietMealPlanData(id);
      if (response.isNotEmpty && response["status"] == "success") {
        dietMealPlanListData.value = DietMeaLModel.fromJson(response);
      } else {
        AppSnackBar.showToast(message: response["message"]);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}
