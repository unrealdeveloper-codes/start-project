import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/fitness/models/fitness_category_model.dart';
import 'package:desa/features/fitness/models/fitness_sessions_model.dart';
import 'package:desa/features/fitness/repositories/fitness_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FitnessSessionsController extends GetxController {
  static FitnessSessionsController get instance => Get.find();

  // -- Variables
  final apiCallHandler = ApiCallHandler();
  final _repo = FitnessRepository();
  final _sessions = FitnessSessions().obs;
  final _isLoading = false.obs;
  final _errorMessage = "".obs;

  // -- Getters
  FitnessSessions get sessions => _sessions.value;
  String get errorMessage => _errorMessage.value;
  bool get isLoading => _isLoading.value;

  // -- Reset Methods
  void resetSessions() {
    _sessions.value = FitnessSessions();
    _errorMessage.value = "";
  }

  // -- Set Methods
  void setSessions(Map<String, dynamic> data) {
    final sessions = FitnessSessions.fromJson(data['data']);
    _sessions.value = sessions;
  }

  // -- API Calls
  Future<void> fetchSessions(BuildContext context, String id) async {
    if (id.isEmpty) {
      _errorMessage.value = "Invalid Sessions ID.";
      return;
    }
    resetSessions();
    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.sessions(id),
      onSuccess: (result) => setSessions(result),
      errorMessage: _errorMessage,
      isLoading: _isLoading,
    );
  }
}
