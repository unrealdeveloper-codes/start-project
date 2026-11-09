class SingleBlogByIDModel {
  String? status;
  String? message;
  Data? data;

  SingleBlogByIDModel({this.status, this.message, this.data});

  SingleBlogByIDModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  String? description;
  String? image;
  String? createdDate;

  Data({this.id, this.description, this.image, this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    image = json['image'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_date'] = this.createdDate;
    return data;
  }
}