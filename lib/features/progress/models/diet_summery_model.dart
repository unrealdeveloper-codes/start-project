class DietSummaryModel {
  String? status;
  String? message;
  Data? data;

  DietSummaryModel({this.status, this.message, this.data});

  DietSummaryModel.fromJson(Map<String, dynamic> json) {
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
  String? date;
  Protein? protein;
  Protein? fat;
  Protein? carbs;
  Protein? calories;

  Data({this.date, this.protein, this.fat, this.carbs, this.calories});

  Data.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    protein =
    json['protein'] != null ? new Protein.fromJson(json['protein']) : null;
    fat = json['fat'] != null ? new Protein.fromJson(json['fat']) : null;
    carbs = json['carbs'] != null ? new Protein.fromJson(json['carbs']) : null;
    calories = json['calories'] != null
        ? new Protein.fromJson(json['calories'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.protein != null) {
      data['protein'] = this.protein!.toJson();
    }
    if (this.fat != null) {
      data['fat'] = this.fat!.toJson();
    }
    if (this.carbs != null) {
      data['carbs'] = this.carbs!.toJson();
    }
    if (this.calories != null) {
      data['calories'] = this.calories!.toJson();
    }
    return data;
  }
}

class Protein {
  String? goal;
  String? consumed;
  String? percentage;
  String? extra;

  Protein({this.goal, this.consumed, this.percentage, this.extra});

  Protein.fromJson(Map<String, dynamic> json) {
    goal = json['goal'];
    consumed = json['consumed'];
    percentage = json['percentage'];
    extra = json['extra'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goal'] = this.goal;
    data['consumed'] = this.consumed;
    data['percentage'] = this.percentage;
    data['extra'] = this.extra;
    return data;
  }
}