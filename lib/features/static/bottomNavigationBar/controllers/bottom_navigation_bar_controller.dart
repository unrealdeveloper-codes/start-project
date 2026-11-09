import 'package:desa/features/fitness/view/screens/fitness_categories_screen.dart';

import 'package:desa/features/home/views/screens/home_view.dart';
import 'package:desa/features/nutrition/view/nutrition_screen.dart';
import 'package:desa/features/profile/view/profile_screen.dart';
import 'package:desa/features/progress/view/screens/progress_categories_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarController extends GetxController {
  static BottomNavigationBarController get instance => Get.find();

  // -- Variables
  var selectedIndex = 0.obs;
  final List<Widget> screens = [
    const KeyedSubtree(
      key: ValueKey("HomeView"),
      child: Center(child: HomeView()),
    ),
    const KeyedSubtree(
      key: ValueKey("NutritionScreen"),
      child: Center(child: NutritionScreen()),
    ),
    const KeyedSubtree(
      key: ValueKey("FitnessCategoriesScreen"),
      child: Center(child: FitnessCategoriesScreen()),
    ),
    const KeyedSubtree(
      key: ValueKey("ProgressCategoriesScreen"),
      child: Center(child: ProgressCategoriesScreen()),
    ),
    const KeyedSubtree(
      key: ValueKey("ProfileScreen"),
      child: Center(child: ProfileScreen()),
    ),
  ];

  // -- Functions
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
