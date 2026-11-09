import 'package:desa/data/datasources/local/user_prefrence.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreenController extends GetxController {
  // Varibales
  final PageController pageController = PageController();
  Rx<int> currentIndex = 0.obs;

  // Update Current Page When page Scroll
  void onPageUpdateIndicator(index) {
    currentIndex.value = index;
  }

  // Jump to specific dot selected Page
  void dotNavigationClick(index) {
    currentIndex.value = index;
    pageController.jumpToPage(index);
  }

  // Navigate too next page
  void nextPage(BuildContext context) {
    if (currentIndex.value == 2) {
      final prefs = UserPreferences();
      prefs.setIsFirstTime(false);
      context.go(AppRoutes.LOGIN_SCREEN);
    } else {
      currentIndex.value = currentIndex.value + 1;
      pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.ease,
      );
    }
  }

  RxDouble opacity = 1.0.obs;
  RxBool showOverlay = true.obs;

  void startFadeAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      opacity.value = 0.0;
      Future.delayed(const Duration(milliseconds: 950), () {
        showOverlay.value = false;

        // Get.offNamed(Routes.HOME); // Replace with your next screen route
      });
    });
  }

  @override
  void onInit() {
    super.onInit();
    startFadeAnimation();
  }
}
