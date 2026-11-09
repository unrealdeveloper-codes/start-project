class NutritionProgramModel {
  String? status;
  String? message;
  Data? data;

  NutritionProgramModel({this.status, this.message, this.data});

  NutritionProgramModel.fromJson(Map<String, dynamic> json) {
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
  int? programId;
  Data({this.heading, this.programId});
  Data.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    programId = json['program_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heading'] = this.heading;
    data['program_id'] = this.programId;
    return data;
  }
}