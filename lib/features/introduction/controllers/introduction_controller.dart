import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/introduction/model/introduction_model.dart';
import 'package:desa/features/introduction/repository/introduction_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroductionController extends GetxController {
  static IntroductionController get instance => Get.find();

  // -- Variables
  final apiCallHandler = ApiCallHandler();
  final _repo = IntroductionRepository();
  final _introduction = IntroductionModel().obs;
  final _isLoading = false.obs;
  RxString errorMessage = "".obs;

  // -- Getter
  IntroductionModel get introduction => _introduction.value;

  bool get isLoading => _isLoading.value;

  // -- Functions
  void setLoading(bool loading) {
    _isLoading.value = loading;
  }

  void setIntroduction(Map<String, dynamic> data) {
    if (data['status'] != 'success') {
      errorMessage.value = data['message'];
    } else {
      final intro = IntroductionModel.fromJson(data['data']);
      _introduction.value = intro;
    }
  }

  void resetIntroduction() {
    _introduction.value = IntroductionModel.empty();
    errorMessage.value = "";
  }

  // -- API
  Future<void> fetchIntroduction(
      BuildContext context, String id, String from) async {
    if (id.isEmpty) {
      errorMessage.value = "Invalid Introduction ID.";
      return;
    }
    resetIntroduction();
    await apiCallHandler.apiHandler(
        context: context,
        errorMessage: errorMessage,
        isLoading: _isLoading,
        apiCall: () {
          if (from == 'fitness') {
            return _repo.introduction(id);
          } else {
            return _repo.getIntroductionFromNutrition(id);
          }
        },
        onSuccess: (result) => setIntroduction(result));
  }

// Future featchIntroductionFromNutrition()async{
//   .value = null; // Reset FAQ data
//   errorMessage.value = ''; // Reset error message
//   try {
//     isLoading.value = true;
//     final MapSD response = await NutritionRepository().getApproveNonApproveFood();
//     if (response.isNotEmpty) {
//       approveNonApproveFoodDataList.value = ApproveNonApproveFoodModel.fromJson(response);
//     }
//
//     isLoading.value = false;
//   } catch (e) {
//     isLoading.value = false;
//     errorMessage.value = '${e.toString()}  Please try again later.';
//     print('Error fetching FAQs: $e');
//   }
// }
// }
}
