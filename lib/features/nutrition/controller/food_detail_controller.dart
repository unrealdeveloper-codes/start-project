import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/food_detail_model.dart';
import 'package:desa/features/nutrition/repository/nutration_repository.dart';
import 'package:get/get.dart';

class FoodDetailController extends GetxController {
  // Data list for food details
  var foodDetailDataList = Rx<FoodDetailModel?>(null);

  // Loading and error message states
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  // Fetch the food details (approved and non-approved food)
  Future<void> fetchFoodDetails(
      String id, bool isApprove, String programId) async {
    foodDetailDataList.value = null; // Reset data list
    errorMessage.value = ''; // Reset error message

    var body = {
      "approved": isApprove.toString(),
      "program_id": programId,
    };
    try {
      isLoading.value = true;
      final response = await NutritionRepository().getFoodDetailData(id, body);
      if (response.isNotEmpty) {
        foodDetailDataList.value = FoodDetailModel.fromJson(response);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()} Please try again later.';
      print('Error fetching food details: $e');
    }
  }
}
