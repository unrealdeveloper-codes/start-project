class FitnessCategoriesModel {
  String? status;
  String? message;
  List<FitnessCategories>? fitnessCategories;

  FitnessCategoriesModel({this.status, this.message, this.fitnessCategories});

  FitnessCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      fitnessCategories = <FitnessCategories>[];
      json['data'].forEach((v) {
        fitnessCategories!.add(FitnessCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (fitnessCategories != null) {
      data['data'] = fitnessCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FitnessCategories {
  int? id;
  String? heading;
  String? subHeading;
  String? image;

  FitnessCategories({this.id, this.heading, this.subHeading, this.image});

  FitnessCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heading = json['heading'];
    subHeading = json['subHeading'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['heading'] = heading;
    data['subHeading'] = subHeading;
    data['image'] = image;
    return data;
  }

  // Static empty method
  static FitnessCategories empty() {
    return FitnessCategories();
  }

  @override
  String toString() {
    return 'FitnessCategories(id: $id, heading: $heading, subHeading: $subHeading, image: $image)';
  }
}
