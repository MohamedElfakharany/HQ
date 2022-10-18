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
  });

  dynamic status;
  dynamic message;
  List<MedicalInquiriesDataModel>? data;
  Extra? extra;

  factory MedicalInquiriesModel.fromJson(Map<dynamic, dynamic> json) => MedicalInquiriesModel(
    status: json["status"],
    message: json["message"],
    data: List<MedicalInquiriesDataModel>.from(json["data"].map((x) => MedicalInquiriesDataModel.fromJson(x))),
    extra: Extra.fromJson(json["extra"]),
  );
}

class MedicalInquiriesDataModel {
  MedicalInquiriesDataModel({
    this.id,
    this.message,
    this.file,
    this.date,
  });

  dynamic id;
  dynamic message;
  dynamic file;
  MedicalInquiriesDateDataModel? date;

  factory MedicalInquiriesDataModel.fromJson(Map<dynamic, dynamic> json) => MedicalInquiriesDataModel(
    id: json["id"],
    message: json["message"],
    file: json["file"],
    date: MedicalInquiriesDateDataModel.fromJson(json["date"]),
  );
}

class MedicalInquiriesDateDataModel {
  MedicalInquiriesDateDataModel({
    this.date,
    this.time,
  });

  dynamic date;
  dynamic time;

  factory MedicalInquiriesDateDataModel.fromJson(Map<dynamic, dynamic> json) => MedicalInquiriesDateDataModel(
    date: json["date"],
    time: json["time"],
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
