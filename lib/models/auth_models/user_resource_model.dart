import 'dart:convert';

UserResourceModel userResourceModelFromJson(dynamic str) => UserResourceModel.fromJson(json.decode(str));

class UserResourceModel {
  UserResourceModel({
    this.status,
    this.message,
    this.data,
    this.extra,
  });

  dynamic status;
  dynamic message;
  UserResourceDataModel? data;
  UserResourceExtraModel? extra;

  factory UserResourceModel.fromJson(Map<dynamic, dynamic> json) => UserResourceModel(
    status: json["status"],
    message: json["message"],
    data: UserResourceDataModel.fromJson(json["data"]),
    extra: UserResourceExtraModel.fromJson(json["extra"]),
  );
}

class UserResourceDataModel {
  UserResourceDataModel({
    this.id,
    this.profile,
    this.code,
    this.name,
    this.phone,
    this.isVerified,
    this.email,
    this.country,
    this.city,
    this.branch,
    this.birthday,
    this.gender,
    this.deviceToken,
    this.active,
    this.isCompleted,
  });

  dynamic id;
  dynamic profile;
  dynamic code;
  dynamic name;
  dynamic phone;
  dynamic isVerified;
  dynamic email;
  UserResourceDataRegionModel? country;
  UserResourceDataRegionModel? city;
  UserResourceDataRegionModel? branch;
  dynamic birthday;
  dynamic gender;
  dynamic deviceToken;
  dynamic active;
  dynamic isCompleted;

  factory UserResourceDataModel.fromJson(Map<dynamic, dynamic> json) => UserResourceDataModel(
    id: json["id"],
    profile: json["profile"],
    code: json["code"],
    name: json["name"],
    phone: json["phone"],
    isVerified: json["isVerified"],
    email: json["email"],
    country: UserResourceDataRegionModel.fromJson(json["country"]),
    city: UserResourceDataRegionModel.fromJson(json["city"]),
    branch: UserResourceDataRegionModel.fromJson(json["branch"]),
    birthday: json["birthday"],
    gender: json["gender"],
    deviceToken: json["deviceToken"],
    active: json["active"],
    isCompleted: json["isCompleted"],
  );
}

class UserResourceDataRegionModel {
  UserResourceDataRegionModel({
    this.id,
    this.title,
  });

  dynamic id;
  dynamic title;

  factory UserResourceDataRegionModel.fromJson(Map<dynamic, dynamic> json) => UserResourceDataRegionModel(
    id: json["id"],
    title: json["title"],
  );
}

class UserResourceExtraModel {
  UserResourceExtraModel({
    this.token,
  });

  dynamic token;

  factory UserResourceExtraModel.fromJson(Map<dynamic, dynamic> json) => UserResourceExtraModel(
    token: json["token"],
  );

  Map<dynamic, dynamic> toJson() => {
    "token": token,
  };
}
