class AppUrls {
  static const String _baseUrl = "https://apibackend.trimify.com.au";

  static Uri setUrls(String uri) {
    return Uri.parse("$_baseUrl$uri");
  }

  static String setBaseUrl(String uri) {
    return "$_baseUrl$uri";
  }

  // -- Auth
  static Uri auth = setUrls("/api/authenticate");
  static Uri login = setUrls("/api/login");
  static Uri forgotPassword = setUrls("/api/forgot-password");
  static Uri verifyOtp = setUrls("/api/auth/verify-otp");
  static Uri resetPassword = setUrls("/api/reset-password");
  static Uri logout = setUrls("/api/logout");
  static Uri changePassword = setUrls("/api/change-password");
  static Uri refreshToken = setUrls("/api/refresh-token");

  // -- Home
  static Uri getBanners = setUrls("/api/get-banners");
  static Uri getDashboardData = setUrls("/api/get-dashboard-data");

  // -- Fitness
  static Uri fitnessCategories = setUrls("/api/fitzone-categories");
  static Uri fitnessCategory = setUrls("/api/fitzone-category-details");
  static Uri fitnessSessions = setUrls("/api/fitzone-sessions");
  static Uri fitnessSession = setUrls("/api/fitzone-session-details");

  // -- Introduction
  static Uri introduction = setUrls("/api/fitzone-introduction");

  // -- Home
  static Uri getBlogCategory = setUrls("/api/blog-categories");
  static Uri getBlogCategoryListByID = setUrls("/api/blog");
  static Uri getSingleBlogById = setUrls("/api/single-blog");
  static Uri getSessionData = setUrls("/api/fitzone-sessions-dashboard");
  static Uri getNotification = setUrls("/api/notifications");

  // -- nutrition
  static Uri getNutationAllPrograms = setUrls("/api/programs");
  static Uri getNutritionProgram = setUrls("/api/program-details");
  static Uri getApproveNonApproveFood = setUrls("/api/all-foods");
  static Uri getNonApproveFood = setUrls("/api/non-approved-foods");
  static Uri getDietMealPlanData = setUrls("/api/diet-plan-weeks");
  static Uri getWeakDietMealData = setUrls("/api/diet-plan-days");
  static Uri getFoodListPlanData = setUrls("/api/diet-plan-meals");
  static Uri searchMealFromNutration = setUrls("/api/meal_search");
  static Uri getFoodDetailData = setUrls("/api/chart");
  static Uri getRecipesFoodDetail = setUrls("/api/meal");
  static Uri getIntroductionFromNutrition =
      setUrls("/api/program-introduction");

  // -- Profile
  static Uri getFAQ = setUrls("/api/faqs");
  static Uri getPages = setUrls("/api/pages");

  // nutrition_diary
  static Uri searchMealFromProgress = setUrls("/api/meal-search");
  static Uri getConsumedMeal = setUrls("/api/consumed-foods");
  static Uri addMeal = setUrls("/api/add-consumed-foods");
  static Uri getDietSummaryData = setUrls("/api/diet-summary");
  static Uri deleteConsumedMeal = setUrls("/api/delete-consumed-food");
  static Uri editMeal = setUrls("/api/update-consumed-food");

  // -- Water
  static Uri waterGoal = setUrls("/api/water-goal");
  static Uri recordWater = setUrls("/api/record-water");
  static Uri waterIntake = setUrls("/api/water-intake");
  static Uri waterIntakeGraph = setUrls("/api/water-intake-graph");

  // -- Notification
  static Uri notificationToggle = setUrls("/api/notification-status");
  static Uri fetchNotifications = setUrls("/api/notifications");

  // -- Dashboard
  static Uri getQutos = setUrls("/api/get-quote");

  // -- Disclamer
  static Uri disclaimer = Uri.parse("https://admin.trimify.com.au/disclaimer");
}
