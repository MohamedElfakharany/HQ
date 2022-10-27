// To parse this JSON data, do
//
//     final homeResultsModel = homeResultsModelFromJson(jsondynamic);

import 'dart:convert';

HomeResultsModel homeResultsModelFromJson(dynamic str) => HomeResultsModel.fromJson(json.decode(str));

class HomeResultsModel {
  HomeResultsModel({
    this.status,
    this.message,
    this.data,
    this.extra,
    this.errors,
  });

  dynamic status;
  dynamic message;
  List<HomeResultsModelData>? data;
  Extra? extra;
  Errors? errors;

  factory HomeResultsModel.fromJson(Map<dynamic, dynamic> json) => HomeResultsModel(
    status: json["status"],
    message: json["message"],
    data: List<HomeResultsModelData>.from(json["data"].map((x) => HomeResultsModelData.fromJson(x))),
    extra: Extra.fromJson(json["extra"]),
    errors: Errors.fromJson(json["errors"]),
  );
}

class HomeResultsModelData {
  HomeResultsModelData({
    this.id,
    this.countResult,
    this.date,
    this.results,
  });

  dynamic id;
  dynamic countResult;
  HomeResultsDataDateModel? date;
  List<HomeResultsModelResult>? results;

  factory HomeResultsModelData.fromJson(Map<dynamic, dynamic> json) => HomeResultsModelData(
    id: json["id"],
    countResult: json["countResult"],
    date: HomeResultsDataDateModel.fromJson(json["date"]),
    results: List<HomeResultsModelResult>.from(json["results"].map((x) => HomeResultsModelResult.fromJson(x))),
  );
}

class HomeResultsDataDateModel {
  HomeResultsDataDateModel({
    this.date,
    this.time,
  });

  dynamic date;
  dynamic time;

  factory HomeResultsDataDateModel.fromJson(Map<dynamic, dynamic> json) => HomeResultsDataDateModel(
    date: json["date"],
    time: json["time"],
  );
}

class HomeResultsModelResult {
  HomeResultsModelResult({
    this.id,
    this.file,
    this.title,
    this.date,
    this.notes,
  });

  dynamic id;
  dynamic file;
  dynamic title;
  HomeResultsDataDateModel? date;
  dynamic notes;

  factory HomeResultsModelResult.fromJson(Map<dynamic, dynamic> json) => HomeResultsModelResult(
    id: json["id"],
    file: json["file"],
    title: json["title"],
    date: HomeResultsDataDateModel.fromJson(json["date"]),
    notes: json["notes"],
  );
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<dynamic, dynamic> json) => Errors(
  );

  Map<dynamic, dynamic> toJson() => {
  };
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

