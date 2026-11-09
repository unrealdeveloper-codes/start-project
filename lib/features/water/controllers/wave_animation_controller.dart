import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WaveController extends GetxController with GetTickerProviderStateMixin {
  static WaveController get instance => Get.find();

  BuildContext context;
  WaveController(this.context);

  @override
  void onInit() {
    super.onInit();
    wave1Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    wave2Controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    riseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    waveHeightAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: riseController, curve: Curves.easeOut),
    );

    containerHeightAnimation = Tween<double>(begin: 0, end: 0).animate(
      CurvedAnimation(parent: riseController, curve: Curves.easeOut),
    );
  }

  // -- Variables
  late AnimationController wave1Controller;
  late AnimationController wave2Controller;
  late AnimationController riseController;
  late Animation<double> waveHeightAnimation;
  late Animation<double> containerHeightAnimation;
  final double maxContainerFactor = 1.0;
  double currentHeightFactor = 0.0;
  late double maxGoal;
  double currentValue = 0.0;

  // -- Helper Functions
  /// Set the maximum goal and initial value
  void initializeGoal(
      double maxGoalValue, double initialValue, BuildContext context) {
    maxGoal = maxGoalValue;
    currentValue = initialValue;
    updateWaterLevel(initialValue, context);
  }

  /// Update the water level dynamically
  void recordWaterLevel(double newValue) {
    if (newValue > maxGoal) {
      newValue = maxGoal; // Ensure it doesn't exceed the maximum goal
    }

    final previousHeight = waveHeightAnimation.value;
    final previousFactor = containerHeightAnimation.value;

    currentValue = newValue;
    currentHeightFactor = currentValue / maxGoal; // Normalize the current value

    riseController.stop();
    riseController.reset();
    final maxval = MediaQuery.sizeOf(context).height * 0.27;
    waveHeightAnimation = Tween<double>(
      begin: previousHeight,
      end: currentHeightFactor * maxval,
    ).animate(CurvedAnimation(parent: riseController, curve: Curves.easeOut));

    containerHeightAnimation = Tween<double>(
      begin: previousFactor,
      end: currentHeightFactor,
    ).animate(CurvedAnimation(parent: riseController, curve: Curves.easeOut));

    riseController.forward();
  }

  /// Shortcut to set an initial water level
  void updateWaterLevel(double initialValue, BuildContext context) {
    recordWaterLevel(initialValue);
  }

  @override
  void onClose() {
    wave1Controller.dispose();
    wave2Controller.dispose();
    riseController.dispose();
    super.onClose();
  }
}
