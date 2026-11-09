import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/nutrition/models/approve_non_approvefood_model.dart';
import 'package:desa/features/nutrition/repository/nutration_repository.dart';
import 'package:get/get.dart';

class ApproveNonApproveFoodController extends GetxController {
  var approveNonApproveFoodDataList = Rx<ApproveNonApproveFoodModel?>(null);
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchApproveNonApproveFood(String id, bool isAproved) async {
    approveNonApproveFoodDataList.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message

    final body = {
      "approved": isAproved.toString(),
      "program_id": id.toString(),
    };
    try {
      isLoading.value = true;
      final response =
          await NutritionRepository().getApproveNonApproveFood(body);
      if (response.isNotEmpty) {
        approveNonApproveFoodDataList.value =
            ApproveNonApproveFoodModel.fromJson(response);
      }


      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetchApproveNonApproveFood : $e');
    }
  }
}
