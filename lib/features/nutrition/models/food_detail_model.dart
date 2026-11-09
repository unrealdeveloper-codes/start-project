class FoodDetailModel {
  String? status;
  String? message;
  Data? data;

  FoodDetailModel({this.status, this.message, this.data});

  FoodDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? description;
  List<Chart>? chart;

  Data({this.title, this.description, this.chart});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    if (json['chart'] != null) {
      chart = <Chart>[];
      json['chart'].forEach((v) {
        chart!.add(new Chart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.chart != null) {
      data['chart'] = this.chart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chart {
  String? foodName;
  String? quantity;

  Chart({this.foodName, this.quantity});

  Chart.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_name'] = this.foodName;
    data['quantity'] = this.quantity;
    return data;
  }
}