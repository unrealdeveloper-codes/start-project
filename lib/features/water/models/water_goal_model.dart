class WaterGoalModel {
  String? status;
  String? message;
  Data? data;

  WaterGoalModel({this.status, this.message, this.data});

  WaterGoalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  num? totalGoal;
  num? completedGoal;
  num? percentage;

  Data({this.totalGoal, this.completedGoal, this.percentage});

  Data.fromJson(Map<String, dynamic> json) {
    totalGoal = json['total_goal'];
    completedGoal = json['completed_goal'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_goal'] = totalGoal;
    data['completed_goal'] = completedGoal;
    data['percentage'] = percentage;
    return data;
  }
}
