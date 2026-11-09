class SearchMealModelFromProgress {
  String? status;
  String? message;
  List<Data>? data;

  SearchMealModelFromProgress({this.status, this.message, this.data});

  SearchMealModelFromProgress.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? mealDescription;
  String? mealTitle;
  String? mealImageUrl;
  String? mealCaloriesInGm;
  String? mealProtienInGm;
  String? mealFatsInGm;
  String? mealCarbsInGm;
  int? quantity;

  Data(
      {this.id,
        this.mealDescription,
        this.mealTitle,
        this.mealImageUrl,
        this.mealCaloriesInGm,
        this.mealProtienInGm,
        this.mealFatsInGm,
        this.mealCarbsInGm,
        this.quantity});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealDescription = json['Meal_Description'];
    mealTitle = json['Meal_title'];
    mealImageUrl = json['Meal_Image_url'];
    mealCaloriesInGm = json['Meal_Calories_In_gm'];
    mealProtienInGm = json['Meal_Protien_In_gm'];
    mealFatsInGm = json['Meal_Fats_In_gm'];
    mealCarbsInGm = json['Meal_Carbs_In_gm'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Meal_Description'] = this.mealDescription;
    data['Meal_title'] = this.mealTitle;
    data['Meal_Image_url'] = this.mealImageUrl;
    data['Meal_Calories_In_gm'] = this.mealCaloriesInGm;
    data['Meal_Protien_In_gm'] = this.mealProtienInGm;
    data['Meal_Fats_In_gm'] = this.mealFatsInGm;
    data['Meal_Carbs_In_gm'] = this.mealCarbsInGm;
    data['quantity'] = this.quantity;
    return data;
  }
}