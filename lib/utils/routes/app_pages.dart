import 'package:desa/features/home/views/screens/home_discover_view_more.dart';
import 'package:desa/features/home/views/screens/home_fitness_section_view_more.dart';
import 'package:desa/features/home/views/screens/single_blog_by_id_screen.dart';
import 'package:desa/features/profile/view/about_app.dart';
import 'package:desa/features/progress/controllers/my_nutrition_diary_controller.dart';
import 'package:desa/features/progress/view/screens/viewMoreScreen.dart';
import 'package:desa/features/static/bottomNavigationBar/views/bottom_navigation_bar_view.dart';

import 'package:desa/features/fitness/view/screens/fitness_categories_screen.dart';
import 'package:desa/features/fitness/view/screens/fitness_category_screen.dart';
import 'package:desa/features/introduction/view/screen/introduction_screen.dart';
import 'package:desa/features/fitness/view/screens/fitness_session_screen.dart';
import 'package:desa/features/fitness/view/screens/fitness_sessions_screen.dart';
import 'package:desa/features/home/views/screens/discover_more_screen.dart';
import 'package:desa/features/home/views/screens/notification_screen.dart';
import 'package:desa/features/profile/view/FAQ_screen.dart';
import 'package:desa/features/profile/view/change_password_screen.dart';
import 'package:desa/features/profile/view/help_&_support_screen.dart';
import 'package:desa/features/profile/view/notification_setting_screen.dart';
import 'package:desa/features/profile/view/privacy_policy_screen.dart';
import 'package:desa/features/profile/view/terms_and_condation_screen.dart';
import 'package:desa/features/progress/view/screens/my_nutrition_diary_screen.dart';
import 'package:desa/features/progress/view/screens/progress_categories_screen.dart';
import 'package:desa/features/water/view/screens/water_monitor_screen.dart';

import 'package:desa/features/nutrition/view/approve_non_approve_food_Screen.dart';
import 'package:desa/features/nutrition/view/day_diet_meal_plan_screen.dart';
import 'package:desa/features/nutrition/view/diet_meal_plan_and_recipes.dart';
import 'package:desa/features/nutrition/view/food_detail_screen.dart';
import 'package:desa/features/nutrition/view/food_list_plan_screen.dart';
import 'package:desa/features/nutrition/view/food_recipes_detail_screen.dart';
import 'package:desa/features/nutrition/view/nutrition_program_screen.dart';
import 'package:desa/features/nutrition/view/weak_diet_meal_plan_screen.dart';
import 'package:desa/main.dart';
import 'package:desa/utils/components/error_display/erroe_dispaly.dart';
import 'package:desa/utils/components/warning_dispaly.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../../features/authentication/view/screens/forgot_password_screen_view.dart';
import '../../features/authentication/view/screens/login_screen_view.dart';
import '../../features/static/onbordingScreen/views/screen/onbording_screen_view.dart';
import '../../features/static/splashScreen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppGoRouter {
  static GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      _createRoute('/', SplashScreenView()),
      _createRoute(AppRoutes.ONBORDING_SCREEN, OnboardingScreenView()),
      _createRoute(AppRoutes.LOGIN_SCREEN, LoginScreenView()),
      _createRoute(AppRoutes.BOTTOM_NAVIGATION_BAR, BottomNavigationBarView()),
      _createRoute(
          AppRoutes.FORGOT_PASSWORD_SCREEN, const ForgotPasswordScreenView()),
      GoRoute(
        path: AppRoutes.NUTRITION_PROGRAM_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID';
          return _buildTransitionPage(
            context,
            state,
            NutritionProgramScreen(id: id),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.APPROVE_NON_APPROVE_FOOD_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final isApproved = extra['isApproved'] as bool? ?? true;
          final id = extra['id'] as String;

          return _buildTransitionPage(
            context,
            state,
            ApproveNonApproveFoodScreen(
              isApprove: isApproved,
              id: id,
            ), // Pass the id to DiscoverMoreScreen
          );
        },
      ),

      GoRoute(
        path: AppRoutes.FOOD_DETAIL_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final isApproved = extra['isApproved'] as bool? ?? true;
          final id = extra['id'] as String? ?? 'Unknown ID';
          final programId = extra['programId'] as String;
          return _buildTransitionPage(
            context,
            state,
            FoodDetailScreen(
              isApproved: isApproved,
              id: id,
              programId: programId,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.DIET_MEAL_PLAN_RECIPES_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            DietMealPlanAndRecipesScreen(
                id: id), // Pass the id to DiscoverMoreScreen
          );
        },
      ),
      _createRoute(
        AppRoutes.VIEW_DISCOVER_MORE_SCREEN,
        const HomeDiscoverViewMore(),
      ),
      _createRoute(
        AppRoutes.VIEW_MORE_FITZONE_SCREEN,
        const HomeFitnessSectionMore(),
      ),
      _createRoute(
        AppRoutes.myNutritionSearchScreen,
        const MyNutritionSearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.WEAK_DIET_MEAL_PLAN_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
          final weak =
              extra['weak'] as String? ?? 'Unknown weak'; // Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            WeakDietMealPlanScreen(
              id: id,
              weak: weak,
            ), // Pass the id to DiscoverMoreScreen
          );
        },
      ),

      // _createRoute(AppRoutes.DIET_MEAL_PLAN_RECIPES_SCREEN,
      //     const DietMealPlanAndRecipesScreen()),
      // _createRoute(
      //     AppRoutes.WEAK_DIET_MEAL_PLAN_SCREEN, const WeakDietMealPlanScreen()),
      GoRoute(
        path: AppRoutes.DAY_DIET_MEAL_PLAN_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID';
          final weak = extra['weak'] as String? ?? 'Unknown weak';
          final day = extra['day'] as String? ?? 'Unknown day';

          // Retrieve the id
// Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            DayDietMealPlanScreen(
              id: id,
              weak: weak,
              day: day,
            ), // Pass the id to DiscoverMoreScreen
          );
        },
      ),
      // _createRoute(
      //     AppRoutes.DAY_DIET_MEAL_PLAN_SCREEN, DayDietMealPlanScreen()),
      // _createRoute(AppRoutes.FOOD_LIST_PLAN_SCREEN, const FoodListPlanScreen()),
      GoRoute(
        path: AppRoutes.FOOD_LIST_PLAN_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
          final weak = extra['weak'] as String? ?? 'Unknown weak';
          final mealType = extra['mealType'] as String? ?? 'Unknown meal';
          final day = extra['day'] as String? ?? 'Unknown day';

          // Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            FoodListPlanScreen(
              id: id,
              weak: weak,
              mealType: mealType,
              day: day,
            ), // Pass the id to DiscoverMoreScreen
          );
        },
      ),
      GoRoute(
        path: AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
          final mealType = extra['mealType'] as String? ??
              'Unknown mealType'; // Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            FoodRecipesDetailScreen(
                mealType: mealType,
                id: id), // Pass the id to DiscoverMoreScreen
          );
        },
      ),
      // _createRoute(AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
      //     const FoodRecipesDetailScreen()),
      _createRoute(
          AppRoutes.CHANGE_PASSWORD_SCREEN, const ChangePasswordScreen()),
      _createRoute(AppRoutes.NOTIFICATION_SETTING_SCREEN,
          const NotificationSettingScreen()),
      _createRoute(
          AppRoutes.HELP_AND_SUPPORT_SCREEN, const HelpAndSupportScreen()),
      _createRoute(AppRoutes.FAQ_SCREEN, const FaqScreen()),
      _createRoute(
          AppRoutes.PRIVACY_POLICY_SCREEN, const PrivacyPolicyScreen()),
      _createRoute(AppRoutes.TERMS_AND_CONDITION_SCREEN,
          const TermsAndConditionScreen()),
      GoRoute(
        path: AppRoutes.DISCOVER_MORE_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            DiscoverMoreScreen(id: id), // Pass the id to DiscoverMoreScreen
          );
        },
      ),

      GoRoute(
        path: AppRoutes.VIEW_MORE_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final controller = extra['controller']
              as MyNutritionDiaryController?; // Retrieve the controller directly

          if (controller == null) {
            // Handle the case where the controller is not passed or null
            return _buildTransitionPage(
              context,
              state,
              WarningDisplay(
                  warningMessage:
                      'Controller not found'), // Or any fallback page
            );
          }

          return _buildTransitionPage(
            context,
            state,
            ViewMoreScreen(
                controller:
                    controller), // Pass the controller to ViewMoreScreen
          );
        },
      ),

      GoRoute(
        path: AppRoutes.SINGLE_BLOG_BY_ID_SCREEN,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            SingleBlogByIdScreen(id: id), // Pass the id to DiscoverMoreScreen
          );
        },
      ),
      _createRoute(AppRoutes.NOTIFICATION_SCREEN, NotificationScreen()),
      _createRoute(AppRoutes.ABOUT_APP_SCREEN, const AboutAppScreen()),
      _createRoute(
          AppRoutes.progressCategoriesScreen, const ProgressCategoriesScreen()),
      _createRoute(
          AppRoutes.TERMS_AND_CONDITION_SCREEN, TermsAndConditionScreen()),

      _createRoute(AppRoutes.NOTIFICATION_SCREEN, NotificationScreen()),
      // -- Fitness
      _createRoute(
          AppRoutes.fitnessCategoriesScreen, const FitnessCategoriesScreen()),
      GoRoute(
        path: AppRoutes.fitnessCategoryScreen,
        pageBuilder: (context, state) {
          final id = state.extra as String;
          return _buildTransitionPage(
            context,
            state,
            FitnessCategoryScreen(id: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.introductionScreen,
        pageBuilder: (context, state) {
          final extra = state.extra as Map<String, dynamic>? ?? {};
          final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
          final from =
              extra['from'] as String? ?? 'Unknown from'; // Retrieve the id
          return _buildTransitionPage(
            context,
            state,
            IntroductionScreen(
              id: id,
              from: from,
            ),
          );
        },
      ),

      GoRoute(
        path: AppRoutes.fitnessSessionsScreen,
        pageBuilder: (context, state) {
          final id = state.extra as String;
          return _buildTransitionPage(
            context,
            state,
            FitnessSessionsScreen(id: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.fitnessSessionScreen,
        pageBuilder: (context, state) {
          final id = state.extra as String;
          return _buildTransitionPage(
            context,
            state,
            FitnessSessionScreen(id: id),
          );
        },
      ),
      _createRoute(
          AppRoutes.progressCategoriesScreen, const ProgressCategoriesScreen()),
      _createRoute(
          AppRoutes.myNutritionDiaryScreen, const MyNutritionDiaryScreen()),
      _createRoute(AppRoutes.waterMonitorScreen, const WaterMonitorScreen()),
    ],
  );
  static GoRoute _createRoute(String path, Widget child) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) =>
          _buildTransitionPage(context, state, child),
    );
  }

  static Page _buildTransitionPage(
      BuildContext context, GoRouterState state, Widget child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }
}

    // GoRoute(
      //   path: AppRoutes.introductionScreen,
      //   pageBuilder: (context, state) {
      //     final id = state.extra as String;
      //     return _buildTransitionPage(
      //       context,
      //       state,
      //       IntroductionScreen(id: id),
      //     );
      //   },
      // ),

 // GoRoute(
      //   path: AppRoutes.NON_APPROVE_FOOD_SCREEN,
      //   pageBuilder: (context, state) {
      //     final extra = state.extra as Map<String, dynamic>? ?? {};
      //     final id = extra['id'] as String? ?? 'Unknown ID'; // Retrieve the id
      //     return _buildTransitionPage(
      //       context,
      //       state,
      //       NonApproveFoodScreen(id: id), // Pass the id to DiscoverMoreScreen
      //     );
      //   },
      // ),
      // _createRoute(AppRoutes.NON_APPROVE_FOOD_SCREEN, const NonApproveFoodScreen()),


// class AppGoRouter {
//   static GoRouter router = GoRouter(
//     routes: [
//       GoRoute(
//         // name: "splash",
//         path: '/',
//         builder: (context, state) => SplashScreenView(),
//       ),
//       GoRoute(
//         path: AppRoutes.ONBORDING_SCREEN,
//         builder: (context, state) => OnboardingScreenView(),
//       ),
//       GoRoute(
//         path: AppRoutes.LOGIN_SCREEN,
//         builder: (context, state) => LoginScreenView(),
//       ),
//       GoRoute(
//         path: AppRoutes.BOTTOM_NAVIGATION_BAR,
//         builder: (context, state) => BottomNavigationBarView(),
//       ),
//       GoRoute(
//         path: AppRoutes.FORGOT_PASSWORD_SCREEN,
//         builder: (context, state) => ForgotPasswordScreenView(),
//       ),
//
//       // -- Fitness
//
//       GoRoute(
//         // name: "splash",
//         path: AppRoutes.NUTRITION_PROGRAM_SCREEN,
//         builder: (context, state) => NutritionProgramScreen(),
//       ),
//
//       GoRoute(
//         // name: "splash",
//         path: AppRoutes.APPROVE_FOOD_SCREEN,
//         builder: (context, state) => ApproveFoodScreen(),
//       ),
//       GoRoute(
//         // name: "splash",
//         path: AppRoutes.NON_APPROVE_FOOD_SCREEN,
//         builder: (context, state) => NonApproveFoodScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.FOOD_DETAIL_SCREEN,
//         builder: (context, state) {
//           final extra =
//               state.extra as Map<String, dynamic>?; // Cast and check for null
//
//           final isApproved = extra?['isApproved'] as bool? ?? true;
//           final id = extra?['id'] as String? ?? 'Unknown ID';
//
//           return FoodDetailScreen(
//             isApproved: isApproved,
//             id: id,
//           );
//         },
//       ),
//       GoRoute(
//         path: AppRoutes.DIET_MEAL_PLAN_RECIPES_SCREEN,
//         builder: (context, state) => DietMealPlanAndRecipesScreen(),
//
//       ),
//       GoRoute(
//         path: AppRoutes.WEAK_DIET_MEAL_PLAN_SCREEN,
//         builder: (context, state) => WeakDietMealPlanScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.DAY_DIET_MEAL_PLAN_SCREEN,
//         builder: (context, state) => DayDietMealPlanScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.FOOD_LIST_PLAN_SCREEN,
//         builder: (context, state) => FoodListPlanScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.FOOD_RECIPES_DETAIL_SCREEN,
//         builder: (context, state) => FoodRecipesDetailScreen(),
//       ),
//
//       GoRoute(
//         path: AppRoutes.CHANGE_PASSWORD_SCREEN,
//         builder: (context, state) => ChangePasswordScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.NOTIFICATION_SETTING_SCREEN,
//         builder: (context, state) => NotificationSettingScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.HELP_AND_SUPPORT_SCREEN,
//         builder: (context, state) => HelpAndSupportScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.FAQ_SCREEN,
//         builder: (context, state) => FaqScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.PRIVACY_POLICY_SCREEN,
//         builder: (context, state) => PrivacyPolicyScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.TERMS_AND_CONDITION_SCREEN,
//         builder: (context, state) => TermsAndConditionScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.DISCOVER_MORE_SCREEN,
//         builder: (context, state) => DiscoverMoreScreen(),
//       ),
//       // -- FITNESS Screens
//
//       GoRoute(
//         path: AppRoutes.fitnessCategoriesScreen,
//         builder: (context, state) => const FitnessCategoriesScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.fitnessCategoryScreen,
//         builder: (context, state) => const FitnessCategoryScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.introductionScreen,
//         builder: (context, state) => const IntroductionScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.fitnessSessionsScreen,
//         builder: (context, state) => const FitnessSessionsScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.fitnessSessionScreen,
//         builder: (context, state) => const FitnessSessionScreen(),
//       ),
//       // -- Progress
//       GoRoute(
//         path: AppRoutes.progressCategoriesScreen,
//         builder: (context, state) => const ProgressCategoriesScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.myNutritionDiaryScreen,
//         builder: (context, state) => const MyNutritionDiaryScreen(),
//       ),
//       GoRoute(
//         path: AppRoutes.waterMonitorScreen,
//         builder: (context, state) => const WaterMonitorScreen(),
//       ),
//     ],
//   );
// }
