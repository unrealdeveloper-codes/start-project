class FitnessSessionsModel {
  String? status;
  String? message;
  FitnessSessions? fitnessSessions;

  FitnessSessionsModel({this.status, this.message, this.fitnessSessions});

  FitnessSessionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    fitnessSessions =
        json['data'] != null ? FitnessSessions.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (fitnessSessions != null) {
      data['data'] = fitnessSessions!.toJson();
    }
    return data;
  }
}

class FitnessSessions {
  String? heading;
  List<Sessions>? sessions;

  FitnessSessions({this.heading, this.sessions});

  FitnessSessions.fromJson(Map<String, dynamic> json) {
    heading = json['heading'];
    if (json['sessions'] != null) {
      sessions = <Sessions>[];
      json['sessions'].forEach((v) {
        sessions!.add(Sessions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['heading'] = heading;
    if (sessions != null) {
      data['sessions'] = sessions!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sessions {
  int? id;
  String? title;
  String? description;

  Sessions({this.id, this.title, this.description});

  Sessions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
