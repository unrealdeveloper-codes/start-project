import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/nutrition_program_model.dart';
import 'package:desa/features/nutrition/repository/nutration_repository.dart';
import 'package:get/get.dart';

class NutritionProgramController extends GetxController {
  var nutritionProgramData = Rx<NutritionProgramModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchNutritionPrograms(String id) async {
    nutritionProgramData.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;

      final MapSD response =
          await NutritionRepository().getNutritionProgram(id);
      if (response.isNotEmpty && response['data'].isNotEmpty) {
        nutritionProgramData.value = NutritionProgramModel.fromJson(response);
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}
