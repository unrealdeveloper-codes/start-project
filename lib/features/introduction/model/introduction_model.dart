class IntroductionModel {
  String? html;

  IntroductionModel({this.html});

  IntroductionModel.fromJson(Map<String, dynamic> json) {
    html = json['html'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['html'] = html;
    return data;
  }

  static IntroductionModel empty() => IntroductionModel();

  @override
  String toString() {
    return 'IntroductionModel(html: $html)';
  }
}

// class IntroductionModel {
//   String? html;
//   List<String>? illustrators;

//   IntroductionModel({this.html, this.illustrators});

//   IntroductionModel.fromJson(Map<String, dynamic> json) {
//     html = json['html'];
//     illustrators = (json['illustrators'] as List<dynamic>?)
//             ?.map((item) => item.toString())
//             .toList() ??
//         [];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['html'] = html;
//     data['illustrators'] = illustrators;
//     return data;
//   }

//   static IntroductionModel empty() => IntroductionModel();

//   @override
//   String toString() {
//     return 'IntroductionModel(html: $html, illustrators: $illustrators)';
//   }
// }
