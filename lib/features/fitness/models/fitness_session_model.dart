class FitnessSessionModel {
  String? status;
  String? message;
  FitnessSession? fitnessSession;

  FitnessSessionModel({this.status, this.message, this.fitnessSession});

  FitnessSessionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    fitnessSession = json['FitnessSession'] != null
        ? FitnessSession.fromJson(json['FitnessSession'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (fitnessSession != null) {
      data['FitnessSession'] = fitnessSession!.toJson();
    }
    return data;
  }

  // Static empty method
  static FitnessSessionModel empty() {
    return FitnessSessionModel();
  }

  @override
  String toString() {
    return 'FitnessSessionModel(status: $status, message: $message, fitnessSession: $fitnessSession)';
  }
}

class FitnessSession {
  String? title;
  String? description;
  Steps? steps;

  FitnessSession({this.title, this.description, this.steps});

  FitnessSession.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    steps = json['steps'] != null ? Steps.fromJson(json['steps']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    if (steps != null) {
      data['steps'] = steps!.toJson();
    }
    return data;
  }

  // Static empty method
  static FitnessSession empty() {
    return FitnessSession();
  }

  @override
  String toString() {
    return 'FitnessSession(title: $title, description: $description, steps: $steps)';
  }
}

class Steps {
  String? title;
  List<StepsPrograms>? stepsPrograms;

  Steps({this.title, this.stepsPrograms});

  Steps.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['steps_programs'] != null) {
      stepsPrograms = <StepsPrograms>[];
      json['steps_programs'].forEach((v) {
        stepsPrograms!.add(StepsPrograms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    if (stepsPrograms != null) {
      data['steps_programs'] = stepsPrograms!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  // Static empty method
  static Steps empty() {
    return Steps();
  }

  @override
  String toString() {
    return 'Steps(title: $title, stepsPrograms: $stepsPrograms)';
  }
}

class StepsPrograms {
  int? id;
  String? heading;
  String? subHeading;
  String? video;
  dynamic duration;
  List<Description>? description;

  StepsPrograms({
    this.id,
    this.heading,
    this.subHeading,
    this.video,
    this.duration,
    this.description,
  });

  StepsPrograms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    heading = json['heading'];
    subHeading = json['subHeading'];
    video = json['video'];
    duration = json['duration'];
    if (json['description'] != null) {
      description = (json['description'] as List)
          .map((item) => Description.fromJson(item))
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['heading'] = heading;
    data['subHeading'] = subHeading;
    data['video'] = video;
    data['duration'] = duration;
    if (description != null) {
      data['description'] = description!.map((item) => item.toJson()).toList();
    }
    return data;
  }

  // Static empty method
  static StepsPrograms empty() {
    return StepsPrograms();
  }

  @override
  String toString() {
    return 'StepsPrograms(id: $id, heading: $heading, subHeading: $subHeading, video: $video, duration: $duration, description: $description)';
  }
}

class Description {
  String? steps;

  Description({this.steps});

  Description.fromJson(Map<String, dynamic> json) {
    steps = json['point'];
  }

  Map<String, dynamic> toJson() {
    return {'point': steps};
  }

  @override
  String toString() {
    return 'Description(point: $steps)';
  }
}


// class StepsPrograms {
//   int? id;
//   String? heading;
//   String? subHeading;
//   String? video;
//   dynamic duration;

//   StepsPrograms(
//       {this.id, this.heading, this.subHeading, this.video, this.duration});

//   StepsPrograms.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     heading = json['heading'];
//     subHeading = json['subHeading'];
//     video = json['video'];
//     duration = json['duration'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['heading'] = heading;
//     data['subHeading'] = subHeading;
//     data['video'] = video;
//     data['duration'] = duration;
//     return data;
//   }

//   // Static empty method
//   static StepsPrograms empty() {
//     return StepsPrograms();
//   }

//   @override
//   String toString() {
//     return 'StepsPrograms(id: $id, heading: $heading, subHeading: $subHeading, video: $video , duration: $duration)';
//   }
// }
