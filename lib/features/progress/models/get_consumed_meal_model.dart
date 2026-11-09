class GetConsumedMealModel {
  String? status;
  String? message;
  List<Data>? data;

  GetConsumedMealModel({this.status, this.message, this.data});

  GetConsumedMealModel.fromJson(Map<String, dynamic> json) {
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
  int? mealId;
  String? mealName;
  String? image;
  String? protein;
  String? fat;
  String? carbs;
  String? calories;
  String? quantity;
  String? mealType;
  String? servings;

  Data(
      {this.id,
        this.mealId,
        this.mealName,
        this.image,
        this.protein,
        this.fat,
        this.carbs,
        this.calories,
        this.quantity,
        this.mealType,
        this.servings});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealId = json['meal_id'];
    mealName = json['meal_name'];
    image = json['image'];
    protein = json['protein'];
    fat = json['fat'];
    carbs = json['carbs'];
    calories = json['calories'];
    quantity = json['quantity'];
    mealType = json['meal_type'];
    servings = json['servings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meal_id'] = this.mealId;
    data['meal_name'] = this.mealName;
    data['image'] = this.image;
    data['protein'] = this.protein;
    data['fat'] = this.fat;
    data['carbs'] = this.carbs;
    data['calories'] = this.calories;
    data['quantity'] = this.quantity;
    data['meal_type'] = this.mealType;
    data['servings'] = this.servings;
    return data;
  }
}
// class GetConsumedMealModel {
//   String? status;
//   String? message;
//   List<Data>? data;
//
//   GetConsumedMealModel({this.status, this.message, this.data});
//
//   GetConsumedMealModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     message = json['message'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int? id;
//   int? mealId;
//   String? mealName;
//   String? image;
//   String? protein;
//   String? fat;
//   String? carbs;
//   String? calories;
//   String? quantity;
//
//   Data(
//       {this.id,
//         this.mealId,
//         this.mealName,
//         this.image,
//         this.protein,
//         this.fat,
//         this.carbs,
//         this.calories,
//         this.quantity});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     mealId = json['meal_id'];
//     mealName = json['meal_name'];
//     image = json['image'];
//     protein = json['protein'];
//     fat = json['fat'];
//     carbs = json['carbs'];
//     calories = json['calories'];
//     quantity = json['quantity'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['meal_id'] = this.mealId;
//     data['meal_name'] = this.mealName;
//     data['image'] = this.image;
//     data['protein'] = this.protein;
//     data['fat'] = this.fat;
//     data['carbs'] = this.carbs;
//     data['calories'] = this.calories;
//     data['quantity'] = this.quantity;
//     return data;
//   }
// }

