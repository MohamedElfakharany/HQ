// To parse this JSON data, do
//
//     final medicalInquiriesModel = medicalInquiriesModelFromJson(jsondynamic);

import 'dart:convert';

MedicalInquiriesModel medicalInquiriesModelFromJson(dynamic str) => MedicalInquiriesModel.fromJson(json.decode(str));

class MedicalInquiriesModel {
  MedicalInquiriesModel({
    this.status,
    this.message,
    this.data,
    this.extra,
    this.errors,
  });

  dynamic status;
  dynamic message;
  List<MedicalInquiriesDataModel>? data;
  Extra? extra;
  Errors? errors;

  factory MedicalInquiriesModel.fromJson(Map<dynamic, dynamic> json) => MedicalInquiriesModel(
    status: json["status"],
    message: json["message"],
    data: List<MedicalInquiriesDataModel>.from(json["data"].map((x) => MedicalInquiriesDataModel.fromJson(x))),
    extra: Extra.fromJson(json["extra"]),
    errors: Errors.fromJson(json["errors"]),
  );
}

class MedicalInquiriesDataModel {
  MedicalInquiriesDataModel({
    this.id,
    this.message,
    this.file,
    this.date,
    this.answer,
  });

  dynamic id;
  dynamic message;
  dynamic file;
  MedicalInquiriesDataDateModel? date;
  MedicalInquiriesDataAnswerModel? answer;

  factory MedicalInquiriesDataModel.fromJson(Map<dynamic, dynamic> json) => MedicalInquiriesDataModel(
    id: json["id"],
    message: json["message"],
    file: json["file"],
    date: MedicalInquiriesDataDateModel.fromJson(json["date"]),
    answer: MedicalInquiriesDataAnswerModel.fromJson(json["answer"]),
  );
}

class MedicalInquiriesDataAnswerModel {
  MedicalInquiriesDataAnswerModel({
    this.user,
    this.message,
    this.file,
    this.date,
  });

  User? user;
  dynamic message;
  dynamic file;
  MedicalInquiriesDataDateModel? date;

  factory MedicalInquiriesDataAnswerModel.fromJson(Map<dynamic, dynamic> json) => MedicalInquiriesDataAnswerModel(
    user: User.fromJson(json["user"]),
    message: json["message"],
    file: json["file"],
    date: MedicalInquiriesDataDateModel.fromJson(json["date"]),
  );
}

class MedicalInquiriesDataDateModel {
  MedicalInquiriesDataDateModel({
    this.date,
    this.time,
  });

  dynamic date;
  dynamic time;

  factory MedicalInquiriesDataDateModel.fromJson(Map<dynamic, dynamic> json) => MedicalInquiriesDataDateModel(
    date: json["date"],
    time: json["time"],
  );

  Map<dynamic, dynamic> toJson() => {
    "date": date,
    "time": time,
  };
}

class User {
  User({
    this.id,
    this.name,
  });

  dynamic id;
  dynamic name;

  factory User.fromJson(Map<dynamic, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
  );
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<dynamic, dynamic> json) => Errors(
  );
}

class Extra {
  Extra({
    this.pagination,
  });

  Pagination? pagination;

  factory Extra.fromJson(Map<dynamic, dynamic> json) => Extra(
    pagination: Pagination.fromJson(json["pagination"]),
  );
}

class Pagination {
  Pagination({
    this.total,
    this.count,
    this.perPage,
    this.currentPage,
    this.lastPage,
  });

  dynamic total;
  dynamic count;
  dynamic perPage;
  dynamic currentPage;
  dynamic lastPage;

  factory Pagination.fromJson(Map<dynamic, dynamic> json) => Pagination(
    total: json["total"],
    count: json["count"],
    perPage: json["perPage"],
    currentPage: json["currentPage"],
    lastPage: json["lastPage"],
  );
}
