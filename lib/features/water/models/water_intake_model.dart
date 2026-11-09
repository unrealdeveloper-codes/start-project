class WaterIntakeModel {
  String? status;
  String? message;
  List<WaterIntakeData>? data;

  WaterIntakeModel({this.status, this.message, this.data});

  WaterIntakeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WaterIntakeData>[];
      json['data'].forEach((v) {
        data!.add(WaterIntakeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WaterIntakeData {
  String? time;
  String? glassSize;

  WaterIntakeData({this.time, this.glassSize});

  WaterIntakeData.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    glassSize = json['glass_size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time'] = time;
    data['glass_size'] = glassSize;
    return data;
  }
}
