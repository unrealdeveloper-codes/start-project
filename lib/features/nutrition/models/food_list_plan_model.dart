class FoodListPlanModel {
  String? status;
  String? message;
  Data? data;

  FoodListPlanModel({this.status, this.message, this.data});

  FoodListPlanModel.fromJson(Map<String, dynamic> json) {
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
  String? heading;
  String? subheading;
  List<Meals>? meals;

  Data({this.heading, this.subheading, this.meals});

  Data.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    subheading = json['subheading'];
    if (json['meals'] != null) {
      meals = <Meals>[];
      json['meals'].forEach((v) {
        meals!.add(new Meals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading'] = this.heading;
    data['subheading'] = this.subheading;
    if (this.meals != null) {
      data['meals'] = this.meals!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meals {
  int? id;
  String? meal;
  String? calories;

  Meals({this.id, this.meal, this.calories});

  Meals.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    meal = json['meal'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meal'] = this.meal;
    data['calories'] = this.calories;
    return data;
  }
}