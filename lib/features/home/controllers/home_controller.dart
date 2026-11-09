import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/home/controllers/home_water_controller.dart';
import 'package:desa/features/home/controllers/quotes_controller.dart';
import 'package:desa/features/home/model/blog_categpry_lsit_model.dart';
import 'package:desa/features/home/model/session_model.dart';
import 'package:desa/features/home/repository/home_repository.dart';
import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  @override
  void onInit() {
    fetchBlogsCategoryList();
    fetchSessionData();
    super.onInit();
  }

  RxBool showSessionCard = true.obs;
  RxBool showBlogsCard = true.obs;
  final List<String> waterAmounts = [
    '150 ml',
    '250 ml',
    '350 ml',
    '450 ml',
    '600 ml',
    '1000 ml'
  ];
  var blogCategoryList = Rx<BlogCategoryListModel?>(null);
  var isLoading = false.obs;
  var isLoadingAnimation = false.obs;
  var errorMessage = ''.obs;
  var sessionData = Rx<SessionModel?>(null);
  var isLoadingSession = false.obs;
  var errorMessageSession = ''.obs;
  var isExpanded = false.obs; // Observable to track expanded state
  var selectedIndex = (-1).obs;
  RxBool viewLessForGridView = true.obs;

  // -- Helper Functions
  void updateSelectedIndex(int index) {
    if (index == selectedIndex.value) {
      selectedIndex.value = -1;
    } else {
      selectedIndex.value = index;
    }
  }

  Future refreshMethod(BuildContext context) async {
    isLoadingAnimation.value = true;
    showSessionCard.value = true;
    showBlogsCard.value = true;
    final qController = QuotesController.instance;
    final nController = Get.put(MyNutritionDiaryController());
    final wController = HomeWaterController.intance;
    await qController.fetchQuotes();
    isLoadingAnimation.value = false;
    nController.fetchTodayDietSummaryData();
    wController.fetchWaterGoal();
    fetchSessionData();
    fetchBlogsCategoryList();
  }

  // ---- API Functions
  Future<void> fetchBlogsCategoryList() async {
    blogCategoryList.value = null; // Reset FAQ data
    errorMessage.value = ''; // Reset error message
    try {
      isLoading.value = true;

      final MapSD response = await HomeRepository().getBlogsList();
      if (response.isNotEmpty) {
        blogCategoryList.value = BlogCategoryListModel.fromJson(response);
      }
      isLoadingAnimation.value = false;
      isLoading.value = false;
    } catch (e) {
      isLoadingAnimation.value = false;
      isLoading.value = false;
      errorMessage.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }

  Future<void> fetchSessionData() async {
    try {
      sessionData.value = null; // Reset FAQ data
      errorMessageSession.value = ''; // Reset error message
      isLoadingSession.value = true;

      final MapSD response = await HomeRepository().getSessionData();

      if (response.isNotEmpty) {
        sessionData.value = SessionModel.fromJson(response);
        showSessionCard.value = true;
      }

      isLoadingSession.value = false;
    } catch (e) {
      isLoadingSession.value = false;
      errorMessageSession.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}
