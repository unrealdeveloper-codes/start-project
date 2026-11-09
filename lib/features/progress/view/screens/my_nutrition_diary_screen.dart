import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
import 'package:desa/features/progress/view/widgets/my_nutrition_consumed_food_section.dart';
import 'package:desa/features/progress/view/widgets/my_nutrition_diet_summary_section.dart';
import 'package:desa/utils/cards/search_meal_card.dart';

import 'package:desa/utils/components/appbar/transparent_appBar.dart';
import 'package:desa/utils/components/customeBottomSheet/custome_bottom_sheet.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/headings/heading_subheading_widget.dart';
import 'package:desa/utils/components/text/app_text.dart';
import 'package:desa/utils/components/textfields/search_text_fielt.dart';
import 'package:desa/utils/constants/app_colors.dart';
import 'package:desa/utils/constants/app_sizer.dart';
import 'package:desa/utils/constants/app_strings.dart';
import 'package:desa/utils/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class MyNutritionDiaryScreen extends StatelessWidget {
  const MyNutritionDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = Get.put(MyNutritionDiaryController());

    Future.microtask(() {
      controller.fetchConsumedMealData();
      controller.fetchDietSummaryData();
    });

    // Example refresh function
    Future<void> refreshData() async {
      controller.fetchConsumedMealData();
      controller.fetchDietSummaryData();
    }

    return Scaffold(
      appBar: const TransparentAppBar(),
      body: RefreshIndicator(
        onRefresh: refreshData,
        color: AppColor.primaryColor1,
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeadingSection(controller),
              _buildSearchField(controller, context),
              _buildSummaryContent(width, height, controller),
            ],
          ),
        ),
      ),
    );
  }

  // Heading Section
  Widget _buildHeadingSection(MyNutritionDiaryController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HeadingSubheadingWidget(
            heading: AppStrings.myNutritionDiaryHeading,
            subHeading: AppStrings.myNutritionDiarySubheading,
          ),
          SizedBox(height: AppSizer.height * 0.04),
          MyManropeText(
            text: "Search Your Meals",
            color: AppColor.primaryColor2,
            fontWeight: FontWeight.w900,
            fontSize: AppSizer.fontSize16,
          ),
          MyManropeText(
            text: "Find the foods you’ve eaten to log them into your diary.",
            color: AppColor.bodyTextColor,
            height: AppSizer.height * 0.004,
            fontWeight: FontWeight.w700,
            fontSize: AppSizer.fontSize12,
          ),
          SizedBox(height: AppSizer.height * 0.01),
        ],
      ),
    );
  }

  // Search Field
  Widget _buildSearchField(
      MyNutritionDiaryController controller, BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      color: Colors.transparent,
      height: AppSizer.height * 0.066,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: MySearchTextFeild(
                hintText: 'Search for food, meals, or ingredients...',
                onTap: () => context.push(AppRoutes.myNutritionSearchScreen),
                controller: TextEditingController(),
                prifix: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.009,
                    horizontal: width * 0.025,
                  ),
                  child: SvgPicture.asset(
                    'assets/nutritionIcons/searchIcon.svg',
                    width: width * 0.01,
                    height: height * 0.025,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Summary Content (Consumed Food + Diet Summary)
  Widget _buildSummaryContent(
    double width,
    double height,
    MyNutritionDiaryController controller,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * .01,
          ),
          MyNutritionConsumedFoodSection(
            controller: controller,
          ),
          SizedBox(height: height * 0.035),
          MyNutritionDietSummarySection(
            controller: controller,
          ),
        ],
      ),
    );
  }
}

class MyNutritionSearchScreen extends StatefulWidget {
  const MyNutritionSearchScreen({super.key});

  @override
  State<MyNutritionSearchScreen> createState() =>
      _MyNutritionSearchScreenState();
}

class _MyNutritionSearchScreenState extends State<MyNutritionSearchScreen> {
  @override
  void initState() {
    final controller = MyNutritionDiaryController.instance;
    controller.onSearchTap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = MyNutritionDiaryController.instance;

    return Scaffold(
      appBar: TransparentAppBar(
        onTap: () => controller.onSearchFocusLost(context),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent &&
              !controller.isPaginationLoading.value) {
            controller.mealPagination(context);
          }
          return false;
        },
        child: Column(
          children: [
            SizedBox(height: height * 0.005),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
              child: MySearchTextFeild(
                hintText: "Search products...",
                controller: controller.searchController,
                onChange: (value) {
                  controller.fetchSearchMeal(value);
                },
                prifix: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.009,
                    horizontal: width * 0.025,
                  ),
                  child: SvgPicture.asset(
                    'assets/nutritionIcons/searchIcon.svg',
                    width: width * 0.01,
                    height: height * 0.025,
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            const Expanded(
              child: Scrollbar(
                child: SingleChildScrollView(
                  child: BuildSearchResults(),
                ),
              ),
            ),
            SizedBox(height: height * 0.04),
          ],
        ),
      ),
    );
  }
}

class BuildSearchResults extends StatelessWidget {
  const BuildSearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final controller = MyNutritionDiaryController.instance;
    return Obx(
      () {
        if (controller.isLoadingSearch.value) {
          // Display shimmer while loading
          return _buildShimmerList(height);
        } else if (controller.errorMessageSearch.value.isNotEmpty) {
          // Display error message if there's an error
          return ErrorDisplay(
            errorMessage: controller.errorMessageSearch.value,
            onTap: () => controller.fetchSearchMeal(
                controller.searchController.text), // Retry logic
          );
        } else if (controller.searchMealData.value?.data?.isEmpty ?? true) {
          // Display a "no data" message if the list is empty
          return Center(
              child: SizedBox(
            width: AppSizer.width,
            height: AppSizer.height * 0.65,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/nutritionIcons/searchMealIcon.svg',
                  width: AppSizer.width * 0.12,
                ),
                SizedBox(height: AppSizer.height * 0.01),
                MyManropeText(
                  text: 'No Meals Found!',
                  fontWeight: FontWeight.w800,
                  fontSize: AppSizer.fontSize18,
                  color: AppColor.primaryColor1,
                ),
                SizedBox(height: AppSizer.height * 0.005),
                SizedBox(
                  width: AppSizer.width * 0.7,
                  child: MyManropeText(
                    text:
                        'Try searching for a different meal or adjust your filters.',
                    textAlign: TextAlign.center,
                    fontSize: AppSizer.fontSize12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.greyTextColor,
                  ),
                ),
              ],
            ),
          ));
        } else {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(
                  horizontal: AppSizer.horizontal20,
                ),
                controller: controller.scrollController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.searchMealData.value?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final meal = controller.searchMealData.value!.data![index];
                  return SearchMealCard(
                    title: meal.mealTitle ?? 'Unnamed Meal',
                    imageUrl: meal.mealImageUrl ?? '',
                    description: meal.mealDescription ?? '',
                    protein: '${meal.mealProtienInGm ?? 0}g',
                    fats: '${meal.mealFatsInGm ?? 0}g',
                    carbs: '${meal.mealCarbsInGm ?? 0}g',
                    calories: '${meal.mealCaloriesInGm ?? 0} kcal',
                    selectedValue: (meal.quantity != 0 && meal.quantity != null)
                        ? '${meal.quantity}g'
                        : '',
                    addMeal: () {
                      controller.selectedQuantity.value = '';
                      controller.selectedMealType.value = '';
                      controller.numberOfServing.value = 1;
                      showAddMealBottomSheet(
                          context, controller, meal.id.toString());
                    },
                    onTap: () {
                      context.push(
                        AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
                        extra: {'id': meal.id.toString()},
                      );
                    },
                  );
                },
              ),
              if (controller.isPaginationLoading.value)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizer.vertical15),
                  child: Column(
                    children: [
                      SizedBox(
                        width: width * 0.05,
                        height: width * 0.05,
                        child: const CircularProgressIndicator(
                          color: AppColor.primaryColor1,
                        ),
                      ),
                      SizedBox(height: height * 0.02),
                      MyManropeText(
                        text: "    Loading More Data...",
                        fontSize: AppSizer.fontSize11,
                        fontWeight: FontWeight.w500,
                      )
                    ],
                  ),
                ),
            ],
          );
        }
      },
    );
  }

  void showAddMealBottomSheet(
    BuildContext contextt,
    MyNutritionDiaryController controller,
    String mealId,
  ) {
    showModalBottomSheet(
      context: contextt,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(AppSizer.width * 0.05)),
      ),
      builder: (BuildContext context) {
        return AddMealBottomSheet(
          mealTypes: const ['Breakfast', 'Lunch', 'Dinner', 'Snacks'],
          quantities: const ['50 g', '100 g', '150 g', '250 g'],
          initialServings: 1,
          onMealTypeSelected: (selectedMeal) {
            controller.selectedMealType.value = selectedMeal;
          },
          onQuantitySelected: (selectedQuantity) {
            controller.selectedQuantity.value = selectedQuantity;
          },
          onServingsChanged: (newServings) {
            controller.numberOfServing.value = newServings;
          },
          onTap: () {
            controller.addMeal(mealId, contextt);
            context.pop();
          },
        );
      },
    );
  }

// Shimmer Effect for Loading State
  Widget _buildShimmerList(double height) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // Number of shimmer placeholders
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizer.height * 0.01),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: height * 0.15,
              margin: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppSizer.width * 0.02),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ---------------- Search Bar Animation Code Working Properly ----------------------
// ---------------- Used Controller Uncommented Code ----------------------
// import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
// import 'package:desa/features/progress/view/widgets/my_nutrition_consumed_food_section.dart';
// import 'package:desa/features/progress/view/widgets/my_nutrition_diet_summary_section.dart';
// import 'package:desa/utils/cards/search_meal_card.dart';
// import 'package:desa/utils/components/appbar/transparent_appBar.dart';
// import 'package:desa/utils/components/customeBottomSheet/custome_bottom_sheet.dart';
// import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
// import 'package:desa/utils/components/headings/heading_subheading_widget.dart';
// import 'package:desa/utils/components/text/app_text.dart';
// import 'package:desa/utils/components/textfields/search_text_fielt.dart';
// import 'package:desa/utils/constants/app_colors.dart';
// import 'package:desa/utils/constants/app_sizer.dart';
// import 'package:desa/utils/constants/app_strings.dart';
// import 'package:desa/utils/routes/app_pages.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:go_router/go_router.dart';
// import 'package:shimmer/shimmer.dart';

// class MyNutritionDiaryScreen extends StatelessWidget {
//   const MyNutritionDiaryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     final controller = Get.put(MyNutritionDiaryController());

//     Future.microtask(() {
//       controller.fetchConsumedMealData();
//       controller.fetchDietSummaryData();
//     });

//     // Example refresh function
//     Future<void> refreshData() async {
//       controller.fetchConsumedMealData();
//       controller.fetchDietSummaryData();
//     }

//     return Scaffold(
//       appBar: _buildAppBar(context, controller),
//       body: SafeArea(
//         child: NotificationListener<ScrollNotification>(
//           onNotification: (ScrollNotification scrollInfo) {
//             if (scrollInfo.metrics.pixels >=
//                     scrollInfo.metrics.maxScrollExtent &&
//                 !controller.isPaginationLoading.value) {
//               controller.mealPagination(context);
//             }
//             return false;
//           },
//           child: RefreshIndicator(
//             onRefresh: refreshData,
//             color: AppColor.primaryColor1,
//             child: SingleChildScrollView(
//               controller: controller.scrollController,
//               // physics: _getScrollPhysics(controller),
//               //  physics: NeverScrollableScrollPhysics(),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildHeadingSection(controller),
//                   _buildSearchField(controller, width, height),
//                   _buildContentSection(controller, width, height)
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // App Bar
//   PreferredSizeWidget _buildAppBar(
//       BuildContext context, MyNutritionDiaryController controller) {
//     return TransparentAppBar(
//       onTap: () => controller.isSearchFocused.value
//           ? controller.onSearchFocusLost()
//           : context.pop(),
//     );
//   }

//   // Determine Scroll Physics
//   ScrollPhysics _getScrollPhysics(MyNutritionDiaryController controller) {
//     return controller.isSearchFocused.value
//         ? const NeverScrollableScrollPhysics()
//         : const BouncingScrollPhysics();
//   }

//   // Heading Section
//   Widget _buildHeadingSection(MyNutritionDiaryController controller) {
//     return Obx(
//       () => Padding(
//         padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
//         child: controller.isSearchFocused.value
//             ? const SizedBox()
//             : FadeTransition(
//                 opacity: controller.fadeAnimation,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const HeadingSubheadingWidget(
//                       heading: AppStrings.myNutritionDiaryHeading,
//                       subHeading: AppStrings.myNutritionDiarySubheading,
//                     ),
//                     SizedBox(height: AppSizer.height * 0.04),
//                     MyManropeText(
//                       text: "Search Your Meals",
//                       color: AppColor.primaryColor2,
//                       fontWeight: FontWeight.w900,
//                       fontSize: AppSizer.fontSize16,
//                     ),
//                     MyManropeText(
//                       text:
//                           "Find the foods you’ve eaten to log them into your diary.",
//                       color: AppColor.bodyTextColor,
//                       height: AppSizer.height * 0.004,
//                       fontWeight: FontWeight.w700,
//                       fontSize: AppSizer.fontSize12,
//                     ),
//                     SizedBox(height: AppSizer.height * 0.01),
//                   ],
//                 ),
//               ),
//       ),
//     );
//   }

//   // Search Field
//   Widget _buildSearchField(
//       MyNutritionDiaryController controller, double width, double height) {
//     return Container(
//       color: Colors.transparent,
//       height: AppSizer.height * 0.066,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
//         child: Stack(
//           children: [
//             AnimatedBuilder(
//               animation: controller.positionAnimation,
//               builder: (context, child) {
//                 return Obx(
//                   () => Positioned(
//                     top: controller.isSearchFocused.value
//                         ? AppSizer.height * controller.positionAnimation.value
//                         : 0,
//                     left: 0,
//                     right: 0,
//                     child: child!,
//                   ),
//                 );
//               },
//               child: Obx(
//                 () => MySearchTextFeild(
//                   hintText: controller.isSearchFocused.value
//                       ? "Search products..."
//                       : 'Search for food, meals, or ingredients...',
//                   onTap: controller.onSearchTap,
//                   controller: controller.searchController,
//                   onChange: (value) {
//                     controller.setSearchQuery(value);
//                     controller.fetchSearchMeal(value);
//                   },
//                   prifix: Padding(
//                     padding: EdgeInsets.symmetric(
//                       vertical: height * 0.009,
//                       horizontal: width * 0.025,
//                     ),
//                     child: SvgPicture.asset(
//                       'assets/nutritionIcons/searchIcon.svg',
//                       width: width * 0.01,
//                       height: height * 0.025,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Content Section (Switch between search results and summary)
//   Widget _buildContentSection(
//       MyNutritionDiaryController controller, double width, double height) {
//     return Obx(
//       () => controller.isSearchFocused.value
//           ? const BuildSearchResults()
//           : _buildSummaryContent(width, height, controller),
//     );
//   }

//   // Summary Content (Consumed Food + Diet Summary)
//   Widget _buildSummaryContent(
//     double width,
//     double height,
//     MyNutritionDiaryController controller,
//   ) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: AppSizer.horizontal15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(
//             height: height * .01,
//           ),
//           MyNutritionConsumedFoodSection(
//             controller: controller,
//           ),
//           SizedBox(height: height * 0.035),
//           MyNutritionDietSummarySection(
//             controller: controller,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MyNutritionSearchScreen extends StatelessWidget {
//   const MyNutritionSearchScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     final controller = MyNutritionDiaryController.instance;

//     return Scaffold(
//       appBar: const TransparentAppBar(),
//       body: Column(
//         children: [
//           MySearchTextFeild(
//             hintText: "Search products...",
//             onTap: controller.onSearchTap,
//             controller: controller.searchController,
//             onChange: (value) {
//               controller.fetchSearchMeal(value);
//             },
//             prifix: Padding(
//               padding: EdgeInsets.symmetric(
//                 vertical: height * 0.009,
//                 horizontal: width * 0.025,
//               ),
//               child: SvgPicture.asset(
//                 'assets/nutritionIcons/searchIcon.svg',
//                 width: width * 0.01,
//                 height: height * 0.025,
//               ),
//             ),
//           ),
//           const BuildSearchResults()
//         ],
//       ),
//     );
//   }
// }

// class BuildSearchResults extends StatelessWidget {
//   const BuildSearchResults({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.sizeOf(context).height;
//     final width = MediaQuery.sizeOf(context).width;
//     final controller = MyNutritionDiaryController.instance;
//     return Obx(() {
//       if (controller.isLoadingSearch.value) {
//         // Display shimmer while loading
//         return _buildShimmerList(height);
//       } else if (controller.errorMessageSearch.value.isNotEmpty) {
//         // Display error message if there's an error
//         return ErrorDisplay(
//           errorMessage: controller.errorMessageSearch.value,
//           onTap: () => controller
//               .fetchSearchMeal(controller.searchController.text), // Retry logic
//         );
//       } else if (controller.searchMealData.value?.data?.isEmpty ?? true) {
//         // Display a "no data" message if the list is empty
//         return Center(
//             child: SizedBox(
//           width: AppSizer.width,
//           height: AppSizer.height * 0.65,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SvgPicture.asset(
//                 'assets/nutritionIcons/searchMealIcon.svg',
//                 width: AppSizer.width * 0.12,
//               ),
//               SizedBox(height: AppSizer.height * 0.01),
//               MyManropeText(
//                 text: 'No Meals Found!',
//                 fontWeight: FontWeight.w800,
//                 fontSize: AppSizer.fontSize18,
//                 color: AppColor.primaryColor1,
//               ),
//               SizedBox(height: AppSizer.height * 0.005),
//               SizedBox(
//                 width: AppSizer.width * 0.7,
//                 child: MyManropeText(
//                   text:
//                       'Try searching for a different meal or adjust your filters.',
//                   textAlign: TextAlign.center,
//                   fontSize: AppSizer.fontSize12,
//                   fontWeight: FontWeight.w500,
//                   color: AppColor.greyTextColor,
//                 ),
//               ),
//             ],
//           ),
//         ));
//       } else {
//         return Column(
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               padding: EdgeInsets.symmetric(
//                 horizontal: AppSizer.horizontal20,
//               ),
//               controller: controller.scrollController,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: controller.searchMealData.value?.data?.length ?? 0,
//               itemBuilder: (context, index) {
//                 final meal = controller.searchMealData.value!.data![index];
//                 return SearchMealCard(
//                   title: meal.mealTitle ?? 'Unnamed Meal',
//                   imageUrl: meal.mealImageUrl ?? '',
//                   description: meal.mealDescription ?? '',
//                   protein: '${meal.mealProtienInGm ?? 0}g',
//                   fats: '${meal.mealFatsInGm ?? 0}g',
//                   carbs: '${meal.mealCarbsInGm ?? 0}g',
//                   calories: '${meal.mealCaloriesInGm ?? 0} kcal',
//                   selectedValue: (meal.quantity != 0 && meal.quantity != null)
//                       ? '${meal.quantity}g'
//                       : '',
//                   addMeal: () {
//                     controller.selectedQuantity.value = '';
//                     controller.selectedMealType.value = '';
//                     controller.numberOfServing.value = 1;
//                     showAddMealBottomSheet(
//                         context, controller, meal.id.toString());
//                   },
//                   onTap: () {
//                     context.push(
//                       AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
//                       extra: {'id': meal.id.toString()},
//                     );
//                   },
//                 );
//               },
//             ),
//             if (controller.isPaginationLoading.value)
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: AppSizer.vertical15),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       width: width * 0.05,
//                       height: width * 0.05,
//                       child: const CircularProgressIndicator(
//                         color: AppColor.primaryColor1,
//                       ),
//                     ),
//                     SizedBox(height: height * 0.02),
//                     MyManropeText(
//                       text: "    Loading More Data...",
//                       fontSize: AppSizer.fontSize11,
//                       fontWeight: FontWeight.w500,
//                     )
//                   ],
//                 ),
//               ),
//           ],
//         );
//         // return ListView.builder(
//         //   shrinkWrap: true,
//         //   padding: EdgeInsets.symmetric(
//         //     horizontal: AppSizer.horizontal20,
//         //   ),
//         //   physics: const NeverScrollableScrollPhysics(),
//         //   itemCount: controller.searchMealData.value?.data?.length ?? 0,
//         //   itemBuilder: (context, index) {
//         //     final meal = controller.searchMealData.value!.data![index];
//         //     return SearchMealCard(
//         //       title: meal.mealTitle ?? 'Unnamed Meal',
//         //       imageUrl: meal.mealImageUrl ?? '',
//         //       description: meal.mealDescription ?? '',
//         //       protein: '${meal.mealProtienInGm ?? 0}g',
//         //       fats: '${meal.mealFatsInGm ?? 0}g',
//         //       carbs: '${meal.mealCarbsInGm ?? 0}g',
//         //       calories: '${meal.mealCaloriesInGm ?? 0} kcal',
//         //       selectedValue: (meal.quantity != 0 && meal.quantity != null)
//         //           ? '${meal.quantity}g'
//         //           : '',
//         //       addMeal: () {
//         //         controller.selectedQuantity.value = '';
//         //         controller.selectedMealType.value = '';
//         //         controller.numberOfServing.value = 1;
//         //         showAddMealBottomSheet(context, controller, meal.id.toString());
//         //       },
//         //       onTap: () {
//         //         context.push(
//         //           AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
//         //           extra: {'id': meal.id.toString()},
//         //         );
//         //       },
//         //     );
//         //   },
//         // );
//       }
//     });
//   }

//   void showAddMealBottomSheet(BuildContext contextt,
//       MyNutritionDiaryController controller, String mealId) {
//     showModalBottomSheet(
//       context: contextt,
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius:
//             BorderRadius.vertical(top: Radius.circular(AppSizer.width * 0.05)),
//       ),
//       builder: (BuildContext context) {
//         return AddMealBottomSheet(
//           mealTypes: const ['Breakfast', 'Lunch', 'Dinner', 'Snacks'],
//           quantities: const ['50 g', '100 g', '150 g', '250 g'],
//           initialServings: 1,
//           onMealTypeSelected: (selectedMeal) {
//             controller.selectedMealType.value = selectedMeal;
//           },
//           onQuantitySelected: (selectedQuantity) {
//             controller.selectedQuantity.value = selectedQuantity;
//           },
//           onServingsChanged: (newServings) {
//             controller.numberOfServing.value = newServings;
//           },
//           onTap: () {
//             controller.addMeal(mealId, contextt);
//             context.pop();
//           },
//         );
//       },
//     );
//   }

// // Shimmer Effect for Loading State
//   Widget _buildShimmerList(double height) {
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       itemCount: 3, // Number of shimmer placeholders
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: EdgeInsets.symmetric(vertical: AppSizer.height * 0.01),
//           child: Shimmer.fromColors(
//             baseColor: Colors.grey[300]!,
//             highlightColor: Colors.grey[100]!,
//             child: Container(
//               height: height * 0.15,
//               margin: EdgeInsets.symmetric(horizontal: AppSizer.horizontal20),
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(AppSizer.width * 0.02),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
