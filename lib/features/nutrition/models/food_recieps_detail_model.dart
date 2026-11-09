class FoodRecipesDetailModel {
  String? status;
  String? message;
  Data? data;

  FoodRecipesDetailModel({this.status, this.message, this.data});

  FoodRecipesDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? mealTitle;
  String? mealDescription;
  String? mealImageUrl;
  String? mealCaloriesInGm;
  String? mealProtienInGm;
  String? mealFatsInGm;
  String? mealCarbsInGm;
  List<Ingredients>? ingredients;
  List<Instructions>? instructions;

  Data(
      {this.mealTitle,
        this.mealDescription,
        this.mealImageUrl,
        this.mealCaloriesInGm,
        this.mealProtienInGm,
        this.mealFatsInGm,
        this.mealCarbsInGm,
        this.ingredients,
        this.instructions});

  Data.fromJson(Map<String, dynamic> json) {
    mealTitle = json['Meal_title'];
    mealDescription = json['Meal_Description'];
    mealImageUrl = json['Meal_Image_url'];
    mealCaloriesInGm = json['Meal_Calories_In_gm'];
    mealProtienInGm = json['Meal_Protien_In_gm'];
    mealFatsInGm = json['Meal_Fats_In_gm'];
    mealCarbsInGm = json['Meal_Carbs_In_gm'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
    if (json['instructions'] != null) {
      instructions = <Instructions>[];
      json['instructions'].forEach((v) {
        instructions!.add(new Instructions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Meal_title'] = this.mealTitle;
    data['Meal_Description'] = this.mealDescription;
    data['Meal_Image_url'] = this.mealImageUrl;
    data['Meal_Calories_In_gm'] = this.mealCaloriesInGm;
    data['Meal_Protien_In_gm'] = this.mealProtienInGm;
    data['Meal_Fats_In_gm'] = this.mealFatsInGm;
    data['Meal_Carbs_In_gm'] = this.mealCarbsInGm;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    if (this.instructions != null) {
      data['instructions'] = this.instructions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ingredients {
  int? sNo;
  String? steps;

  Ingredients({this.sNo, this.steps});

  Ingredients.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    steps = json['steps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['steps'] = this.steps;
    return data;
  }
}

class Instructions {
  int? sNo;
  String? title;
  String? description;

  Instructions({this.sNo, this.title, this.description});

  Instructions.fromJson(Map<String, dynamic> json) {
    sNo = json['s_no'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s_no'] = this.sNo;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}