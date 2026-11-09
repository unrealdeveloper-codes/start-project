import 'package:desa/data/datasources/remote/api_call_handler.dart';
import 'package:desa/features/profile/controllers/notification_controller.dart';
import 'package:desa/features/water/controllers/water_intake_controller.dart';
import 'package:desa/features/water/controllers/water_intake_graph_controller.dart';
import 'package:desa/features/water/controllers/wave_animation_controller.dart';
import 'package:desa/features/water/models/water_goal_model.dart';
import 'package:desa/features/water/repositories/water_progress_repository.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaterGoalController extends GetxController {
  static WaterGoalController get intance => Get.find();

  // BuildContext context;
  // WaterGoalController(this.context);

  // @override
  // void onInit() {
  //   fetchWaterGoal();
  //   super.onInit();
  // }

  // -- Variables

  final _repo = WaterProgressRepository();
  final apiCallHandler = ApiCallHandler();
  final Rx<WaterGoalModel> _waterGoal = WaterGoalModel().obs;
  final _isGoalLoading = false.obs;
  final _isRecordingWater = false.obs;
  final _watergoalErrorMessage = "".obs;
  final _waterRecordErrorMessage = "".obs;
  final waterGlassSize = ["150", "250", "350", "450", "600", "1000"];
  var selectedIndex = (-1).obs;

  // -- Getter
  WaterGoalModel get waterGoal => _waterGoal.value;
  bool get isGoalLoading => _isGoalLoading.value;
  bool get isRecordingWater => _isRecordingWater.value;
  String get waterGoalErrorMessage => _watergoalErrorMessage.value;
  String get recordWaterErrorMessage => _waterRecordErrorMessage.value;

  // -- Helper Functions
  void setWaterGoal(Map<String, dynamic> response) {
    final data = WaterGoalModel.fromJson(response);
    _waterGoal.value = data;
    _waterGoal.refresh();
  }

  void resetWaterGoal() {
    _waterGoal.value = WaterGoalModel();
    _waterRecordErrorMessage.value = "";
  }

  void updateSelectedIndex(int index) {
    if (index == selectedIndex.value) {
      selectedIndex.value = -1;
    } else {
      selectedIndex.value = index;
    }
  }

  // -- Refresh All the controllers
  void refershAllData(BuildContext context) {
    fetchWaterGoal(context);
    WaterIntakeController.intance.fetchWaterGoal(context);
    WaterIntakeGraphController.intance.fetchWaterIntake(context);
  }

  // -- Update the Water Intake And Graph
  void updateRemaningSection(String ml, BuildContext context) {
    final waterIntakeController = WaterIntakeController.intance;
    waterIntakeController.addNewRecord(int.parse(ml));
    final waterIntakeGraphController = WaterIntakeGraphController.intance;
    waterIntakeGraphController.fetchWaterIntake(context);
  }

  // -- API Functions
  Future<void> fetchWaterGoal(BuildContext context) async {
    await apiCallHandler.apiHandler(
      context: context,
      apiCall: () => _repo.waterGoal(),
      onSuccess: (result) => setWaterGoal(result),
      errorMessage: _watergoalErrorMessage,
      isLoading: _isGoalLoading,
    );
    final waveController = Get.put(WaveController(context));
    waveController.initializeGoal(
      double.parse(waterGoal.data?.totalGoal?.toString() ?? "0.0"),
      double.parse(waterGoal.data?.completedGoal?.toString() ?? "0.0"),
      context,
    );
  }

  // -- Record Water
  Future<void> recordWater(BuildContext context) async {
    try {
      if (selectedIndex.value == -1) {
        AppSnackBar.showToast(
            message: "Select the size of glass to record the water");
        return;
      }

      // -- Build Body
      final selectedGlassSize = waterGlassSize[selectedIndex.value];
      final body = {"glass_size": selectedGlassSize};

      // -- Main API Handler
      await apiCallHandler.apiHandler(
        context: context,
        apiCall: () => _repo.recordWater(body),
        onSuccess: (result) => setWaterGoal(result),
        errorMessage: _waterRecordErrorMessage,
        isLoading: _isRecordingWater,
      );
      final waveController = Get.put(WaveController(context));

      // -- Update the Water Level
      waveController.recordWaterLevel(
        double.parse(waterGoal.data?.completedGoal?.toString() ?? "0.0"),
        //context,
      );
      // Reset Selected Glass
      selectedIndex.value = -1;

      // -- Add The New Water Record
      updateRemaningSection(selectedGlassSize, context);
    } catch (e, s) {
      "Error $e StackTrace $s".log();
    }
  }
}
