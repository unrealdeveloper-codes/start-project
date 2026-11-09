class BlogsCategoryListByIDModel {
  String? status;
  String? message;
  Data? data;

  BlogsCategoryListByIDModel({this.status, this.message, this.data});

  BlogsCategoryListByIDModel.fromJson(Map<String, dynamic> json) {
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
  String? categoryTitle;
  String? categoryDescription;
  List<Blogs>? blogs;

  Data({this.categoryTitle, this.categoryDescription, this.blogs});

  Data.fromJson(Map<String, dynamic> json) {
    categoryTitle = json['category_title'];
    categoryDescription = json['category_description'];
    if (json['blogs'] != null) {
      blogs = <Blogs>[];
      json['blogs'].forEach((v) {
        blogs!.add(new Blogs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_title'] = this.categoryTitle;
    data['category_description'] = this.categoryDescription;
    if (this.blogs != null) {
      data['blogs'] = this.blogs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Blogs {
  int? id;
  String? title;
  String? description;
  String? image;
  String? createdDate;

  Blogs({this.id, this.title, this.description, this.image, this.createdDate});

  Blogs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['created_date'] = this.createdDate;
    return data;
  }
}