import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/fitness/models/fitness_category_model.dart';
import 'package:desa/features/fitness/repositories/fitness_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FitnessCategoryController extends GetxController {
  static FitnessCategoryController get instance => Get.find();

  // -- Variables
  final apiCallHandler = ApiCallHandler();
  final _repo = FitnessRepository();
  final _category = FitnessCategory.empty().obs;
  final _isLoading = false.obs;
  final _errorMessage = "".obs;

  // -- Getters
  FitnessCategory get category => _category.value;

  String get errorMessage => _errorMessage.value;

  bool get isLoading => _isLoading.value;

  // -- Reset Methods
  void resetCategory() {
    _category.value = FitnessCategory.empty();
    _errorMessage.value = "";
  }

  // -- Set Methods
  void setCategory(Map<String, dynamic> data) {
    final category = FitnessCategory.fromJson(data['data']);
    _category.value = category;
  }

  // -- API Calls
  Future<void> fetchCategory(BuildContext context, String id) async {
    if (id.isEmpty) {
      _errorMessage.value = "Invalid Category ID.";
      return;
    }
    resetCategory();
    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.category(id),
      onSuccess: (result) => setCategory(result),
      errorMessage: _errorMessage,
      isLoading: _isLoading,
    );
  }
}
