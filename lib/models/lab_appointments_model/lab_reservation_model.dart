// To parse this JSON data, do
//
//     final labReservationsModel = labReservationsModelFromJson(jsondynamic);

import 'dart:convert';

LabReservationsModel labReservationsModelFromJson(dynamic str) => LabReservationsModel.fromJson(json.decode(str));

class LabReservationsModel {
  LabReservationsModel({
    this.status,
    this.message,
    this.data,
    this.extra,
    this.errors,
  });

  dynamic status;
  dynamic message;
  List<LabReservationsDateModel>? data;
  Extra? extra;
  Errors? errors;

  factory LabReservationsModel.fromJson(Map<dynamic, dynamic> json) => LabReservationsModel(
    status: json["status"],
    message: json["message"],
    data: List<LabReservationsDateModel>.from(json["data"].map((x) => LabReservationsDateModel.fromJson(x))),
    extra: Extra.fromJson(json["extra"]),
    errors: Errors.fromJson(json["errors"]),
  );
}

class LabReservationsDateModel {
  LabReservationsDateModel({
    this.id,
    this.date,
    this.time,
    this.family,
    this.branch,
    this.coupon,
    this.price,
    this.tax,
    this.discount,
    this.total,
    this.status,
    this.statusEn,
    this.rate,
    this.rateMessage,
    this.createdAt,
    this.tests,
    this.offers,
  });

  dynamic id;
  dynamic date;
  dynamic time;
  List<dynamic>? family;
  LabReservationsModelBranch? branch;
  List<dynamic>? coupon;
  dynamic price;
  dynamic tax;
  dynamic discount;
  dynamic total;
  dynamic status;
  dynamic statusEn;
  dynamic rate;
  dynamic rateMessage;
  LabReservationsModelCreatedAt? createdAt;
  List<LabReservationsModelTest>? tests;
  List<LabReservationsModelOffers>? offers;

  factory LabReservationsDateModel.fromJson(Map<dynamic, dynamic> json) => LabReservationsDateModel(
    id: json["id"],
    date: json["date"],
    time: json["time"],
    family: List<dynamic>.from(json["family"].map((x) => x)),
    branch: LabReservationsModelBranch.fromJson(json["branch"]),
    coupon: List<dynamic>.from(json["coupon"].map((x) => x)),
    price: json["price"],
    tax: json["tax"],
    discount: json["discount"],
    total: json["total"],
    status: json["status"],
    statusEn: json["statusEn"],
    rate: json["rate"],
    rateMessage: json["rateMessage"],
    createdAt: LabReservationsModelCreatedAt.fromJson(json["created_at"]),
    tests: List<LabReservationsModelTest>.from(json["tests"].map((x) => LabReservationsModelTest.fromJson(x))),
    offers: List<LabReservationsModelOffers>.from(json["offers"].map((x) => LabReservationsModelOffers.fromJson(x)))
  );
}

class LabReservationsModelBranch {
  LabReservationsModelBranch({
    this.id,
    this.title,
  });

  dynamic id;
  dynamic title;

  factory LabReservationsModelBranch.fromJson(Map<dynamic, dynamic> json) => LabReservationsModelBranch(
    id: json["id"],
    title: json["title"],
  );
}

class LabReservationsModelCreatedAt {
  LabReservationsModelCreatedAt({
    this.date,
    this.time,
  });

  dynamic date;
  dynamic time;

  factory LabReservationsModelCreatedAt.fromJson(Map<dynamic, dynamic> json) => LabReservationsModelCreatedAt(
    date: json["date"],
    time: json["time"],
  );

  Map<dynamic, dynamic> toJson() => {
    "date": date,
    "time": time,
  };
}

class LabReservationsModelTest {
  LabReservationsModelTest({
    this.id,
    this.title,
    this.category,
    this.price,
    this.image,
  });

  dynamic id;
  dynamic title;
  dynamic category;
  dynamic price;
  dynamic image;

  factory LabReservationsModelTest.fromJson(Map<dynamic, dynamic> json) => LabReservationsModelTest(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    price: json["price"],
    image: json["image"],
  );
}

class LabReservationsModelOffers {
  LabReservationsModelOffers({
    this.id,
    this.title,
    this.price,
    this.image,
  });

  dynamic id;
  dynamic title;
  dynamic price;
  dynamic image;

  factory LabReservationsModelOffers.fromJson(Map<dynamic, dynamic> json) => LabReservationsModelOffers(
    id: json["id"],
    title: json["title"],
    price: json["price"],
    image: json["image"],
  );
}

class Errors {
  Errors();

  factory Errors.fromJson(Map<dynamic, dynamic> json) => Errors(
  );
}

class Extra {
  Extra({
    this.phone,
    this.pagination,
  });

  dynamic phone;
  Pagination? pagination;

  factory Extra.fromJson(Map<dynamic, dynamic> json) => Extra(
    phone: json["phone"],
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
