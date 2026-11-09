import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/fitness/models/fitness_categories_model.dart';
import 'package:desa/features/fitness/repositories/fitness_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FitnessCategoriesController extends GetxController {
  static FitnessCategoriesController get instance => Get.find();

  // -- Variables
  final apiCallHandler = ApiCallHandler();
  final _repo = FitnessRepository();
  final _categories = <FitnessCategories>[].obs;
  final _isLoading = false.obs;
  final _errorMessage = "".obs;

  // -- Getters
  List<FitnessCategories> get categories => _categories;
  String get errorMessage => _errorMessage.value;
  bool get isLoading => _isLoading.value;

  // -- Reset Methods
  void resetCategories() {
    _categories.clear();
    _errorMessage.value = "";
  }

  // -- Set Methods
  void setCategories(Map<String, dynamic> result) {
    final categories = FitnessCategoriesModel.fromJson(result);
    _categories.assignAll(categories.fitnessCategories ?? []);
  }

  // -- API Calls
  Future<void> fetchCategories(BuildContext context) async {
    resetCategories();
    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.categories(),
      onSuccess: (result) => setCategories(result),
      errorMessage: _errorMessage,
      isLoading: _isLoading,
    );
  }
}
