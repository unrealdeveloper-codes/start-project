class UserModel {
  String? status;
  String? message;
  User? data;
  String? token;

  UserModel({this.status, this.message, this.data, this.token});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? User.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }

  static UserModel empty() {
    return UserModel();
  }

  @override
  String toString() {
    return 'UserModel(status: $status, message: $message, data: $data, token: $token)';
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? weight;
  String? height;
  String? gender;
  String? dob;
  String? mobileNumber;
  String? profileImage;
  bool? notificationStatus;
  int? subadminId;
  String? createdAt;

  User({
    this.id,
    this.name,
    this.email,
    this.weight,
    this.height,
    this.gender,
    this.dob,
    this.mobileNumber,
    this.profileImage,
    this.notificationStatus,
    this.subadminId,
    this.createdAt,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    weight = json['weight'];
    height = json['height'];
    gender = json['gender'];
    dob = json['dob'];
    mobileNumber = json['mobile_number'];
    profileImage = json['profile_image'];
    notificationStatus = json['notification_status'];
    subadminId = json['subadmin_id'];
    createdAt = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['weight'] = weight;
    data['height'] = height;
    data['gender'] = gender;
    data['dob'] = dob;
    data['mobile_number'] = mobileNumber;
    data['profile_image'] = profileImage;
    data['notification_status'] = notificationStatus;
    data['subadmin_id'] = subadminId;
    data['created_date'] = createdAt;
    return data;
  }

  static User empty() => User();

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, weight: $weight, height: $height, gender: $gender, dob: $dob, mobileNumber: $mobileNumber, profileImage: $profileImage)';
  }
}
