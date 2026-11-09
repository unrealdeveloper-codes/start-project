class FitnessCategoryModel {
  String? status;
  String? message;
  FitnessCategory? fitnessCategory;

  FitnessCategoryModel({this.status, this.message, this.fitnessCategory});

  FitnessCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    fitnessCategory =
        json['data'] != null ? FitnessCategory.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (fitnessCategory != null) {
      data['data'] = fitnessCategory!.toJson();
    }
    return data;
  }
}

class FitnessCategory {
  String? categoryHeading;
  String? categorySubHeading;
  String? categoryBgImage;
  FitnessCategoryContentSection? introduction;
  FitnessCategoryContentSection? session;

  FitnessCategory(
      {this.categoryHeading,
      this.categorySubHeading,
      this.categoryBgImage,
      this.introduction,
      this.session});

  FitnessCategory.fromJson(Map<String, dynamic> json) {
    categoryHeading = json['category_heading'];
    categorySubHeading = json['category_subHeading'];
    categoryBgImage = json['category_bgImage'];
    introduction = json['introduction'] != null
        ? FitnessCategoryContentSection.fromJson(json['introduction'])
        : null;
    session = json['session'] != null
        ? FitnessCategoryContentSection.fromJson(json['session'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category_heading'] = categoryHeading;
    data['category_subHeading'] = categorySubHeading;
    data['category_bgImage'] = categoryBgImage;
    if (introduction != null) {
      data['introduction'] = introduction!.toJson();
    }
    if (session != null) {
      data['session'] = session!.toJson();
    }
    return data;
  }

  // Static method to return an empty FitnessCategory instance
  static FitnessCategory empty() {
    return FitnessCategory(
      categoryHeading: '',
      categorySubHeading: '',
      categoryBgImage: '',
      introduction: FitnessCategoryContentSection.empty(),
      session: FitnessCategoryContentSection.empty(),
    );
  }

  // toString method for better debugging
  @override
  String toString() {
    return 'FitnessCategory(categoryHeading: $categoryHeading, '
        'categorySubHeading: $categorySubHeading, '
        'categoryBgImage: $categoryBgImage, '
        'introduction: $introduction, '
        'session: $session)';
  }
}

class FitnessCategoryContentSection {
  String? heading;
  String? subHeading;

  FitnessCategoryContentSection({this.heading, this.subHeading});

  FitnessCategoryContentSection.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    subHeading = json['subHeading'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading'] = heading;
    data['subHeading'] = subHeading;
    return data;
  }

  // Static method to return an empty FitnessCategoryContentSection instance
  static FitnessCategoryContentSection empty() {
    return FitnessCategoryContentSection(heading: '', subHeading: '');
  }

  // toString method for better debugging
  @override
  String toString() {
    return 'FitnessCategoryContentSection(heading: $heading, subHeading: $subHeading)';
  }
}
