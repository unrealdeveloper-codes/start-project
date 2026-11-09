import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/water/models/water_intake_model.dart';
import 'package:desa/features/water/repositories/water_progress_repository.dart';
import 'package:desa/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterIntakeController extends GetxController {
  static WaterIntakeController get intance => Get.find();

  BuildContext context;
  WaterIntakeController(this.context);

  @override
  void onInit() {
    fetchWaterGoal(context);
    super.onInit();
  }

  // -- Variables
  final _repo = WaterProgressRepository();
  final apiCallHandler = ApiCallHandler();
  final Rx<WaterIntakeModel> _waterIntake = WaterIntakeModel().obs;
  final _isLoading = false.obs;
  final _erroMessage = "".obs;
  final _viewAllLogs = false.obs;

  // -- Getter
  WaterIntakeModel get waterIntake => _waterIntake.value;
  bool get isLoading => _isLoading.value;
  String get errorMessage => _erroMessage.value;
  bool get viewAllLogs => _viewAllLogs.value;

  // -- Helper Functions
  void setWaterIntake(Map<String, dynamic> response) {
    final data = WaterIntakeModel.fromJson(response);
    _waterIntake.value = data;
    _waterIntake.refresh();
  }

  void resetWaterGoal() {
    _waterIntake.value = WaterIntakeModel();
    _erroMessage.value = "";
  }

  void addNewRecord(int ml) {
    _waterIntake.value.data!.insert(
      0,
      WaterIntakeData(
        time: Utils.formatTime(DateTime.now()),
        glassSize: "$ml ml",
      ),
    );
    _waterIntake.refresh();
  }

  void toogleViewAllLogs() {
    _viewAllLogs.value = !_viewAllLogs.value;
  }

  // -- API Functions
  Future<void> fetchWaterGoal(BuildContext context) async {
    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.waterIntake(),
      onSuccess: (result) => setWaterIntake(result),
      errorMessage: _erroMessage,
      isLoading: _isLoading,
    );
  }
}
