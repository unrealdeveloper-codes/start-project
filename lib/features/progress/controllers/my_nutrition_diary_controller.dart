import 'package:desa/data/datasources/remote/network_api_service.dart';
import 'package:desa/features/home/model/dietSummeryModel.dart';
import 'package:desa/features/progress/models/diet_summery_model.dart'
    hide Data;
import 'package:desa/features/progress/models/get_consumed_meal_model.dart'
    hide Data;
import 'package:desa/features/progress/models/search_meal_model.dart';
import 'package:desa/features/progress/repository/nutrition_diary_repository.dart';
import 'package:desa/utils/components/snackbar/app_snackbar.dart';
import 'package:desa/utils/constants/enum.dart';
import 'package:desa/utils/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MyNutritionDiaryController extends GetxController
    with SingleGetTickerProviderMixin {
  static MyNutritionDiaryController get instance => Get.find();

  // -- Variables
  var isSearchFocused = false.obs;
  var selectedMealType = 'Meal Type'.obs;
  ScrollController scrollController = ScrollController();
  RxString selectedQuantity = ''.obs;
  RxInt numberOfServing = 1.obs;
  RxBool isPaginationLoading = false.obs;
  RxInt currentPage = 1.obs;
  RxInt maxPages = 0.obs;

  final RxString selectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
  final RxString todayDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

  var dietSummaryData = Rx<DietSummaryModel?>(null);
  var isLoadingDietSummary = false.obs;
  var errorMessageDietSummary = ''.obs;

  void onSearchTap() {
    isSearchFocused.value = true;
    fetchSearchMeal(searchController.text);
  }

  void onSearchFocusLost(BuildContext context) {
    isSearchFocused.value = false;
    searchController.clear();
    context.pop();
  }

  TextEditingController searchController = TextEditingController();
  var searchMealData = Rx<SearchMealModelFromProgress?>(null);
  var isLoadingSearch = false.obs;
  var errorMessageSearch = ''.obs;

  Future<void> fetchSearchMeal(String meal) async {
    searchMealData.value = null;
    errorMessageSearch.value = ''; // Reset error message
    currentPage.value = 1;
    maxPages.value = 1;
    MapSS query = {'meal': meal, "page": currentPage.toString()};
    try {
      isLoadingSearch.value = true;
      final MapSD response =
          await NutritionDiaryRepository().getSearchMeal(query);
      if (response.isNotEmpty) {
        searchMealData.value = SearchMealModelFromProgress.fromJson(response);
        currentPage.value = response['current_page'];
        maxPages.value = response['total_pages'];
      }
      isLoadingSearch.value = false;
    } catch (e) {
      isLoadingSearch.value = false;
      errorMessageSearch.value = '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }

  Future<void> mealPagination(BuildContext context) async {
    try {
      // -- check if current page is == max page not fetch the data just retrun
      if (currentPage.value >= maxPages.value) {
        return;
      }
      isPaginationLoading.value = true;

      MapSS query = {
        'meal': searchController.text,
        "page": (currentPage + 1).toString()
      };
      final MapSD response =
          await NutritionDiaryRepository().getSearchMeal(query);
      if (response.isNotEmpty) {
        // Safely cast newMeals to List<Data> (ensure 'Data' is the correct type)
        List<Data> newMeals = (response['data'] as List)
            .map((item) => Data.fromJson(item))
            .toList();

        // Merge the new data with the existing data
        if (searchMealData.value != null &&
            searchMealData.value!.data != null) {
          searchMealData.value!.data!.addAll(newMeals);
        } else {
          searchMealData.value = SearchMealModelFromProgress.fromJson(response);
        }

        // Update current page and maximum pages
        currentPage.value = response['current_page'] ?? currentPage.value + 1;
        maxPages.value = response['total_pages'] ?? maxPages.value;
      } else {
        AppSnackBar.showToast(message: "No data found.");
      }
    } catch (error, stackTrace) {
      AppSnackBar.showToast(message: "Something went wrong");
      "Error $error, StackTracke $stackTrace".log("mealPagination");
    } finally {
      isPaginationLoading.value = false;
    }
  }

  var errorMessageForAddMeal = ''.obs;

  Future<void> addMeal(String mealId, BuildContext context) async {
    selectedQuantity.value = selectedQuantity.replaceAll(RegExp(r'\s|g'), '');

    errorMessageForAddMeal.value = ''; // Reset error message

    MapSS body = {
      "meal_id": mealId,
      "quantity": selectedQuantity.value.trim(),
      "meal_type": selectedMealType.value.trim(),
      "servings": numberOfServing.value.toString()
    };

    // MapSS body = {"meal_id": mealId, "quantity": quantity.trim()};
    try {
      final MapSD response = await NutritionDiaryRepository().addMeal(body);

      if (response.isNotEmpty) {
        String status = response['status']; // Check for the status
        String message = response['message']; // Get the message

        if (status == 'error') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.warning, title: message, context: context);
        } else if (status == 'success') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.success, title: message, context: context);

          await fetchDietSummaryData();
          await fetchConsumedMealData();
        } else if (status == 'warning') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.warning, title: message, context: context);
        }
      }
    } catch (e) {
      errorMessageForAddMeal.value = '${e.toString()}  Please try again later.';

      print(e.toString());

      AppSnackBar.showSnackbar(
          type: SnackbarType.error,
          title: errorMessageForAddMeal.value,
          context: context);
    }
  }

  Future<void> editMeal(String mealId, BuildContext context) async {
    selectedQuantity.value = selectedQuantity.replaceAll(RegExp(r'\s|g'), '');

    errorMessageForAddMeal.value = ''; // Reset error message

    MapSS body = {
      "quantity": selectedQuantity.value.trim(),
      "meal_type": selectedMealType.value.trim(),
      "servings": numberOfServing.value.toString()
    };

    try {
      final MapSD response =
          await NutritionDiaryRepository().editMeal(body, mealId);

      if (response.isNotEmpty) {
        String status = response['status']; // Check for the status
        String message = response['message']; // Get the message

        if (status == 'error') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.error, title: message, context: context);
        } else if (status == 'success') {
          AppSnackBar.showSnackbar(
              type: SnackbarType.success, title: message, context: context);
          await fetchConsumedMealData();

          await fetchDietSummaryData();
        }
      }
    } catch (e) {
      errorMessageForAddMeal.value = '${e.toString()}  Please try again later.';

      AppSnackBar.showSnackbar(
          type: SnackbarType.error,
          title: errorMessageForAddMeal.value,
          context: context);
    }
  }

  var consumedMealData = Rx<GetConsumedMealModel?>(null);
  var isLoadingConsumedMeal = false.obs;
  var errorMessageConsumedMeal = ''.obs;

  Future<void> fetchConsumedMealData() async {
    consumedMealData.value = null; // Reset FAQ data
    errorMessageConsumedMeal.value = ''; // Reset error message

    try {
      isLoadingConsumedMeal.value = true;
      final MapSD response =
          await NutritionDiaryRepository().getConsumedMealData();
      if (response.isNotEmpty) {
        consumedMealData.value = GetConsumedMealModel.fromJson(response);
      }

      isLoadingConsumedMeal.value = false;
    } catch (e) {
      isLoadingConsumedMeal.value = false;
      errorMessageConsumedMeal.value =
          '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }

  Future<void> fetchDietSummaryData() async {
    dietSummaryData.value = null; // Reset diet summary data
    errorMessageDietSummary.value = ''; // Reset error message
    try {
      isLoadingDietSummary.value = true;
      MapSS body = {"date": selectedDate.value};

      final MapSD response =
          await NutritionDiaryRepository().getDietSummaryData(body);
      if (response.isNotEmpty) {
        dietSummaryData.value = DietSummaryModel.fromJson(response);
        if (dietSummaryData.value!.status == 'success' &&
            dietSummaryData.value!.data != null) {
          final data = dietSummaryData.value!.data;
        } else {
          // Handle failure or empty data scenario
        }
      }

      isLoadingDietSummary.value = false;
    } catch (e) {
      isLoadingDietSummary.value = false;
      errorMessageDietSummary.value = '${e.toString()} Please try again later.';
      print('Error fetching diet summary: $e');
    }
  }

  var errorMessageTodayDietSummary = ''.obs;
  var isLoadingTodayDietSummary = false.obs;

  RxList<DietSummary> dietSummaries = <DietSummary>[].obs;

  Future<void> fetchTodayDietSummaryData() async {
    var dietTodaySummaryData = Rx<DietSummaryModel?>(null);
    errorMessageTodayDietSummary.value = ''; // Reset error message
    dietSummaries.clear();
    try {
      isLoadingTodayDietSummary.value = true;
      MapSS body = {"date": todayDate.value};

      final MapSD response =
          await NutritionDiaryRepository().getDietSummaryData(body);
      if (response.isNotEmpty) {
        dietTodaySummaryData.value = DietSummaryModel.fromJson(response);
        if (dietTodaySummaryData.value!.status == 'success' &&
            dietTodaySummaryData.value!.data != null) {
          final data = dietTodaySummaryData.value!.data;

          dietSummaries.value = [
            DietSummary(
              title: 'Calories',
              mainContent: '${data?.calories?.consumed}',
              subtitle: '${data?.calories?.goal}',
              progress: _parsePercentage(data?.calories!.percentage),
            ),
            DietSummary(
              title: 'Protein',
              mainContent: '${data!.protein?.consumed}',
              subtitle: '${data.protein?.goal}',
              progress: _parsePercentage(data.protein!.percentage),
            ),
            DietSummary(
              title: 'Fat',
              mainContent: '${data.fat?.consumed}',
              subtitle: '${data.fat?.goal}',
              progress: _parsePercentage(data.fat!.percentage),
            ),
            DietSummary(
              title: 'Carbs',
              mainContent: '${data.carbs?.consumed}',
              subtitle: '${data.carbs?.goal}',
              progress: _parsePercentage(data.carbs!.percentage),
            ),
          ];
        } else {
          // Handle failure or empty data scenario
        }
      }

      isLoadingTodayDietSummary.value = false;
    } catch (e) {
      isLoadingTodayDietSummary.value = false;
      errorMessageTodayDietSummary.value =
          '${e.toString()} Please try again later.';
      print('Error fetching diet summary: $e');
    }
  }

// Helper function to remove the percentage sign and convert to double
  double _parsePercentage(String? percentage) {
    if (percentage != null && percentage.isNotEmpty) {
      // Remove the percentage sign and parse the remaining part as double
      return double.tryParse(percentage.replaceAll('%', '')) ?? 0.0;
    }
    return 0.0;
  }

  var errorMessageForDeleteMeal = ''.obs;
  var isDeleteMealMeal = false.obs;

  Future<void> deleteConsumedMealData(String id, int index) async {
    errorMessageForDeleteMeal.value = ''; // Reset error message

    try {
      isDeleteMealMeal.value = true;
      final MapSD response =
          await NutritionDiaryRepository().deleteConsumedMeal(id);

      consumedMealData.value!.data!.removeAt(index);
      consumedMealData.refresh();
      fetchDietSummaryData();
      // fetchConsumedMealData();

      isDeleteMealMeal.value = false;
    } catch (e) {
      isDeleteMealMeal.value = false;
      errorMessageForDeleteMeal.value =
          '${e.toString()}  Please try again later.';
      print('Error fetching FAQs: $e');
    }
  }
}

// ---------------- Search Bar Animation Code Working Properly ----------------------
// import 'package:desa/data/datasources/remote/network_api_service.dart';
// import 'package:desa/features/home/model/dietSummeryModel.dart';
// import 'package:desa/features/progress/models/diet_summery_model.dart'hide Data;
// import 'package:desa/features/progress/models/get_consumed_meal_model.dart' hide Data;
// import 'package:desa/features/progress/models/search_meal_model.dart';
// import 'package:desa/features/progress/repository/nutrition_diary_repository.dart';
// import 'package:desa/utils/components/snackbar/app_snackbar.dart';
// import 'package:desa/utils/constants/enum.dart';
// import 'package:desa/utils/extensions/extensions.dart';
// import 'package:get/get.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class MyNutritionDiaryController extends GetxController
//     with SingleGetTickerProviderMixin {
//   static MyNutritionDiaryController get instance => Get.find();

//   // -- Variables
//   var isSearchFocused = false.obs;
//   var selectedMealType = 'Meal Type'.obs;
//   ScrollController scrollController = ScrollController();
//   RxString selectedQuantity = ''.obs;
//   RxString searchQuery = "".obs;
//   RxInt numberOfServing = 1.obs;
//   RxBool isPaginationLoading = false.obs;
//   RxInt currentPage = 1.obs;
//   RxInt maxPages = 0.obs;

//   late AnimationController animationController;
//   late Animation<double> fadeAnimation;
//   late Animation<double> positionAnimation;

//   final RxString selectedDate =
//       DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;
//   final RxString todayDate =
//       DateFormat('yyyy-MM-dd').format(DateTime.now()).obs;

//   var dietSummaryData = Rx<DietSummaryModel?>(null);
//   var isLoadingDietSummary = false.obs;
//   var errorMessageDietSummary = ''.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     animationController = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );
//     fadeAnimation = Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
//       parent: animationController,
//       curve: Curves.easeInOut,
//     ));
//     positionAnimation = Tween<double>(begin: 0.12, end: 0).animate(
//       CurvedAnimation(parent: animationController, curve: Curves.easeInOut),
//     );
//   }

//   void onSearchTap() {
//     isSearchFocused.value = true;
//     animationController.forward();
//     fetchSearchMeal(searchController.text);
//   }

//   void onSearchFocusLost() {
//     isSearchFocused.value = false;
//     animationController.reverse();
//     searchController.clear();
//   }

//   // void updateMealType(String mealType) {
//   //   selectedMealType.value = mealType;
//   // }

//   @override
//   void onClose() {
//     animationController.dispose();
//     super.onClose();
//   }

//   TextEditingController searchController = TextEditingController();
//   var searchMealData = Rx<SearchMealModelFromProgress?>(null);
//   var isLoadingSearch = false.obs;
//   var errorMessageSearch = ''.obs;

//   void setSearchQuery(String val) {
//     searchQuery.value = val;
//   }

//   Future<void> fetchSearchMeal(String meal) async {
//     searchMealData.value = null;
//     errorMessageSearch.value = ''; // Reset error message
//     MapSS query = {'meal': meal, "page": currentPage.toString()};
//     try {
//       isLoadingSearch.value = true;
//       final MapSD response =
//           await NutritionDiaryRepository().getSearchMeal(query);
//       if (response.isNotEmpty) {
//         searchMealData.value = SearchMealModelFromProgress.fromJson(response);
//         currentPage.value = response['current_page'];
//         maxPages.value = response['total_pages'];
//       }

//       isLoadingSearch.value = false;
//     } catch (e) {
//       isLoadingSearch.value = false;
//       errorMessageSearch.value = '${e.toString()}  Please try again later.';
//       print('Error fetching FAQs: $e');
//     }
//   }

//   Future<void> mealPagination(BuildContext context) async {
//     try {
//       if (isSearchFocused.value == false) {
//         return;
//       }

//       print(currentPage.value);
//       print(maxPages.value);
//       // -- check if current page is == max page not fetch the data just retrun
//       if (currentPage.value >= maxPages.value) {
//         return;
//       }
//       isPaginationLoading.value = true;

//       MapSS query = {
//         'meal': searchController.text,
//         "page": (currentPage + 1).toString()
//       };
//       final MapSD response =
//           await NutritionDiaryRepository().getSearchMeal(query);
//       if (response.isNotEmpty) {
//         // Safely cast newMeals to List<Data> (ensure 'Data' is the correct type)
//         List<Data> newMeals = (response['data'] as List)
//             .map((item) => Data.fromJson(item))
//             .toList();

//         // Merge the new data with the existing data
//         if (searchMealData.value != null &&
//             searchMealData.value!.data != null) {
//           searchMealData.value!.data!.addAll(newMeals);
//         } else {
//           searchMealData.value = SearchMealModelFromProgress.fromJson(response);
//         }

//         // Update current page and maximum pages
//         currentPage.value = response['current_page'] ?? currentPage.value + 1;
//         maxPages.value = response['total_pages'] ?? maxPages.value;
//       } else {
//         AppSnackBar.showToast(message: "No data found.");
//       }
//     } catch (error, stackTrace) {
//       AppSnackBar.showToast(message: "Something went wrong");
//       "Error $error, StackTracke $stackTrace".log("mealPagination");
//     } finally {
//       isPaginationLoading.value = false;
//     }
//   }

//   var errorMessageForAddMeal = ''.obs;

//   Future<void> addMeal(String mealId, BuildContext context) async {
//     selectedQuantity.value = selectedQuantity.replaceAll(RegExp(r'\s|g'), '');

//     errorMessageForAddMeal.value = ''; // Reset error message

//     MapSS body = {
//       "meal_id": mealId,
//       "quantity": selectedQuantity.value.trim(),
//       "meal_type": selectedMealType.value.trim(),
//       "servings": numberOfServing.value.toString()
//     };

//     // MapSS body = {"meal_id": mealId, "quantity": quantity.trim()};
//     try {
//       final MapSD response =
//           await NutritionDiaryRepository().addMeal(body);

//       if (response.isNotEmpty) {
//         String status = response['status']; // Check for the status
//         String message = response['message']; // Get the message

//         if (status == 'error') {
//           AppSnackBar.showSnackbar(
//               type: SnackbarType.warning, title: message, context: context);
//         } else if (status == 'success') {
//           AppSnackBar.showSnackbar(
//               type: SnackbarType.success, title: message, context: context);

//           await fetchDietSummaryData();
//           await fetchConsumedMealData();
//         } else if (status == 'warning') {
//           AppSnackBar.showSnackbar(
//               type: SnackbarType.warning, title: message, context: context);
//         }
//       }
//     } catch (e) {
//       errorMessageForAddMeal.value = '${e.toString()}  Please try again later.';

//       print(e.toString());

//       AppSnackBar.showSnackbar(
//           type: SnackbarType.error,
//           title: errorMessageForAddMeal.value,
//           context: context);
//     }
//   }

//   Future<void> editMeal(String mealId, BuildContext context) async {
//     selectedQuantity.value = selectedQuantity.replaceAll(RegExp(r'\s|g'), '');

//     errorMessageForAddMeal.value = ''; // Reset error message

//     MapSS body = {
//       "quantity": selectedQuantity.value.trim(),
//       "meal_type": selectedMealType.value.trim(),
//       "servings": numberOfServing.value.toString()
//     };

//     try {
//       final MapSD response =
//           await NutritionDiaryRepository().editMeal(body, mealId);

//       if (response.isNotEmpty) {
//         String status = response['status']; // Check for the status
//         String message = response['message']; // Get the message

//         if (status == 'error') {
//           AppSnackBar.showSnackbar(
//               type: SnackbarType.error, title: message, context: context);
//         } else if (status == 'success') {
//           AppSnackBar.showSnackbar(
//               type: SnackbarType.success, title: message, context: context);
//           await fetchConsumedMealData();

//           await fetchDietSummaryData();
//         }
//       }
//     } catch (e) {
//       errorMessageForAddMeal.value = '${e.toString()}  Please try again later.';

//       AppSnackBar.showSnackbar(
//           type: SnackbarType.error,
//           title: errorMessageForAddMeal.value,
//           context: context);
//     }
//   }

//   var consumedMealData = Rx<GetConsumedMealModel?>(null);
//   var isLoadingConsumedMeal = false.obs;
//   var errorMessageConsumedMeal = ''.obs;

//   Future<void> fetchConsumedMealData() async {
//     consumedMealData.value = null; // Reset FAQ data
//     errorMessageConsumedMeal.value = ''; // Reset error message

//     try {
//       isLoadingConsumedMeal.value = true;
//       final MapSD response =
//           await NutritionDiaryRepository().getConsumedMealData();
//       if (response.isNotEmpty) {
//         consumedMealData.value = GetConsumedMealModel.fromJson(response);
//       }

//       isLoadingConsumedMeal.value = false;
//     } catch (e) {
//       isLoadingConsumedMeal.value = false;
//       errorMessageConsumedMeal.value =
//           '${e.toString()}  Please try again later.';
//       print('Error fetching FAQs: $e');
//     }
//   }

//   Future<void> fetchDietSummaryData() async {
//     dietSummaryData.value = null; // Reset diet summary data
//     errorMessageDietSummary.value = ''; // Reset error message
//     try {
//       isLoadingDietSummary.value = true;
//       MapSS body = {"date": selectedDate.value};

//       final MapSD response =
//           await NutritionDiaryRepository().getDietSummaryData(body);
//       if (response.isNotEmpty) {
//         dietSummaryData.value = DietSummaryModel.fromJson(response);
//         if (dietSummaryData.value!.status == 'success' &&
//             dietSummaryData.value!.data != null) {
//           final data = dietSummaryData.value!.data;
//         } else {
//           // Handle failure or empty data scenario
//         }
//       }

//       isLoadingDietSummary.value = false;
//     } catch (e) {
//       isLoadingDietSummary.value = false;
//       errorMessageDietSummary.value = '${e.toString()} Please try again later.';
//       print('Error fetching diet summary: $e');
//     }
//   }

//   var errorMessageTodayDietSummary = ''.obs;
//   var isLoadingTodayDietSummary = false.obs;

//   RxList<DietSummary> dietSummaries = <DietSummary>[].obs;

//   Future<void> fetchTodayDietSummaryData() async {
//     var dietTodaySummaryData = Rx<DietSummaryModel?>(null);
//     errorMessageTodayDietSummary.value = ''; // Reset error message
//     dietSummaries.clear();
//     try {
//       isLoadingTodayDietSummary.value = true;
//       MapSS body = {"date": todayDate.value};

//       final MapSD response =
//           await NutritionDiaryRepository().getDietSummaryData(body);
//       if (response.isNotEmpty) {
//         dietTodaySummaryData.value = DietSummaryModel.fromJson(response);
//         if (dietTodaySummaryData.value!.status == 'success' &&
//             dietTodaySummaryData.value!.data != null) {
//           final data = dietTodaySummaryData.value!.data;

//           dietSummaries.value = [
//             DietSummary(
//               title: 'Calories',
//               mainContent: '${data?.calories?.consumed}',
//               subtitle: '${data?.calories?.goal}',
//               progress: _parsePercentage(data?.calories!.percentage),
//             ),
//             DietSummary(
//               title: 'Protein',
//               mainContent: '${data!.protein?.consumed}',
//               subtitle: '${data.protein?.goal}',
//               progress: _parsePercentage(data.protein!.percentage),
//             ),
//             DietSummary(
//               title: 'Fat',
//               mainContent: '${data.fat?.consumed}',
//               subtitle: '${data.fat?.goal}',
//               progress: _parsePercentage(data.fat!.percentage),
//             ),
//             DietSummary(
//               title: 'Carbs',
//               mainContent: '${data.carbs?.consumed}',
//               subtitle: '${data.carbs?.goal}',
//               progress: _parsePercentage(data.carbs!.percentage),
//             ),
//           ];
//         } else {
//           // Handle failure or empty data scenario
//         }
//       }

//       isLoadingTodayDietSummary.value = false;
//     } catch (e) {
//       isLoadingTodayDietSummary.value = false;
//       errorMessageTodayDietSummary.value =
//           '${e.toString()} Please try again later.';
//       print('Error fetching diet summary: $e');
//     }
//   }

// // Helper function to remove the percentage sign and convert to double
//   double _parsePercentage(String? percentage) {
//     if (percentage != null && percentage.isNotEmpty) {
//       // Remove the percentage sign and parse the remaining part as double
//       return double.tryParse(percentage.replaceAll('%', '')) ?? 0.0;
//     }
//     return 0.0;
//   }

//   var errorMessageForDeleteMeal = ''.obs;
//   var isDeleteMealMeal = false.obs;

//   Future<void> deleteConsumedMealData(String id, int index) async {
//     errorMessageForDeleteMeal.value = ''; // Reset error message

//     try {
//       isDeleteMealMeal.value = true;
//       final MapSD response =
//           await NutritionDiaryRepository().deleteConsumedMeal(id);

//       consumedMealData.value!.data!.removeAt(index);
//       consumedMealData.refresh();
//       fetchDietSummaryData();
//       // fetchConsumedMealData();

//       isDeleteMealMeal.value = false;
//     } catch (e) {
//       isDeleteMealMeal.value = false;
//       errorMessageForDeleteMeal.value =
//           '${e.toString()}  Please try again later.';
//       print('Error fetching FAQs: $e');
//     }
//   }
// }
