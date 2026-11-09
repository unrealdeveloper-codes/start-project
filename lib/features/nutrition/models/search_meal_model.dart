class SearchMealModel {
  String? status;
  String? message;
  List<Data>? data;

  SearchMealModel({this.status, this.message, this.data});

  SearchMealModel.fromJson(Map<String, dynamic> json) {
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
  String? mealName;
  String? calories;

  Data({this.id, this.mealName, this.calories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealName = json['meal_name'];
    calories = json['calories'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['meal_name'] = this.mealName;
    data['calories'] = this.calories;
    return data;
  }
}