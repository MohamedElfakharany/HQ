// To parse this JSON data, do
//
//     final homeReservationsModel = homeReservationsModelFromJson(jsondynamic);

import 'dart:convert';
//
// HomeReservationsModel homeReservationsModelFromJson(dynamic str) => HomeReservationsModel.fromJson(json.decode(str));
//
// class HomeReservationsModel {
//   HomeReservationsModel({
//     this.status,
//     this.message,
//     this.data,
//     this.extra,
//     this.errors,
//   });
//
//   dynamic status;
//   dynamic message;
//   List<HomeReservationsDataModel>? data;
//   Extra? extra;
//   Errors? errors;
//
//   factory HomeReservationsModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModel(
//     status: json["status"],
//     message: json["message"],
//     data: List<HomeReservationsDataModel>.from(json["data"].map((x) => HomeReservationsDataModel.fromJson(x))),
//     extra: Extra.fromJson(json["extra"]),
//     errors: Errors.fromJson(json["errors"]),
//   );
// }
//
// class HomeReservationsDataModel {
//   HomeReservationsDataModel({
//     this.id,
//     this.date,
//     this.time,
//     this.family,
//     this.address,
//     this.branch,
//     this.coupon,
//     this.price,
//     this.discount,
//     this.total,
//     this.status,
//     this.statusEn,
//     this.createdAt,
//     this.tests,
//     this.offers,
//   });
//
//   dynamic id;
//   dynamic date;
//   dynamic time;
//   List<dynamic>? family;
//   HomeReservationsHomeReservationsModelAddressModel? address;
//   HomeReservationsHomeReservationsModelBranchModel? branch;
//   List<dynamic>? coupon;
//   dynamic price;
//   dynamic discount;
//   dynamic total;
//   dynamic status;
//   dynamic statusEn;
//   HomeReservationsModelHomeReservationsCreatedAtModel? createdAt;
//   List<HomeReservationsHomeReservationsModelBranchModel>? tests;
//   List<HomeReservationsHomeReservationsModelBranchModel>? offers;
//
//   factory HomeReservationsDataModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsDataModel(
//     id: json["id"],
//     date: json["date"],
//     time: json["time"],
//     family: List<dynamic>.from(json["family"].map((x) => x)),
//     address: HomeReservationsHomeReservationsModelAddressModel.fromJson(json["address"]),
//     branch: HomeReservationsHomeReservationsModelBranchModel.fromJson(json["branch"]),
//     coupon: List<dynamic>.from(json["coupon"].map((x) => x)),
//     price: json["price"],
//     discount: json["discount"],
//     total: json["total"],
//     status: json["status"],
//     statusEn: json["statusEn"],
//     createdAt: HomeReservationsModelHomeReservationsCreatedAtModel.fromJson(json["created_at"]),
//     tests: List<HomeReservationsHomeReservationsModelBranchModel>.from(json["tests"].map((x) => HomeReservationsHomeReservationsModelBranchModel.fromJson(x))),
//     offers: List<HomeReservationsHomeReservationsModelBranchModel>.from(json["offers"].map((x) => HomeReservationsHomeReservationsModelBranchModel.fromJson(x))),
//   );
// }
//
// class HomeReservationsHomeReservationsModelAddressModel {
//   HomeReservationsHomeReservationsModelAddressModel({
//     this.id,
//     this.address,
//     this.specialMark,
//     this.floorNumber,
//     this.buildingNumber,
//   });
//
//   dynamic id;
//   dynamic address;
//   dynamic specialMark;
//   dynamic floorNumber;
//   dynamic buildingNumber;
//
//   factory HomeReservationsHomeReservationsModelAddressModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsHomeReservationsModelAddressModel(
//     id: json["id"],
//     address: json["address"],
//     specialMark: json["special_mark"],
//     floorNumber: json["floor_number"],
//     buildingNumber: json["building_number"],
//   );
// }
//
// class HomeReservationsHomeReservationsModelBranchModel {
//   HomeReservationsHomeReservationsModelBranchModel({
//     this.id,
//     this.title,
//   });
//
//   dynamic id;
//   dynamic title;
//
//   factory HomeReservationsHomeReservationsModelBranchModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsHomeReservationsModelBranchModel(
//     id: json["id"],
//     title: json["title"],
//   );
// }
//
// class HomeReservationsModelHomeReservationsCreatedAtModel {
//   HomeReservationsModelHomeReservationsCreatedAtModel({
//     this.date,
//     this.time,
//   });
//
//   dynamic date;
//   dynamic time;
//
//   factory HomeReservationsModelHomeReservationsCreatedAtModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModelHomeReservationsCreatedAtModel(
//     date: json["date"],
//     time: json["time"],
//   );
// }
//
// class Offer {
//   Offer({
//     this.id,
//     this.title,
//     this.price,
//     this.image,
//     this.category,
//   });
//
//   dynamic id;
//   dynamic title;
//   dynamic price;
//   dynamic image;
//   dynamic category;
//
//   factory Offer.fromJson(Map<dynamic, dynamic> json) => Offer(
//     id: json["id"],
//     title: json["title"],
//     price: json["price"],
//     image: json["image"],
//     category: json["category"] == null ? null : json["category"],
//   );
//
//   Map<dynamic, dynamic> toJson() => {
//     "id": id,
//     "title": title,
//     "price": price,
//     "image": image,
//     "category": category == null ? null : category,
//   };
// }
//
// class Errors {
//   Errors();
//
//   factory Errors.fromJson(Map<dynamic, dynamic> json) => Errors(
//   );
// }
//
// class Extra {
//   Extra({
//     this.pagination,
//   });
//
//   Pagination? pagination;
//
//   factory Extra.fromJson(Map<dynamic, dynamic> json) => Extra(
//     pagination: Pagination.fromJson(json["pagination"]),
//   );
// }
//
// class Pagination {
//   Pagination({
//     this.total,
//     this.count,
//     this.perPage,
//     this.currentPage,
//     this.lastPage,
//   });
//
//   dynamic total;
//   dynamic count;
//   dynamic perPage;
//   dynamic currentPage;
//   dynamic lastPage;
//
//   factory Pagination.fromJson(Map<dynamic, dynamic> json) => Pagination(
//     total: json["total"],
//     count: json["count"],
//     perPage: json["perPage"],
//     currentPage: json["currentPage"],
//     lastPage: json["lastPage"],
//   );
// }

HomeReservationsModel homeReservationsModelFromJson(dynamic str) => HomeReservationsModel.fromJson(json.decode(str));

class HomeReservationsModel {
  HomeReservationsModel({
    this.status,
    this.message,
    this.data,
    this.extra,
    this.errors,
  });

  dynamic status;
  dynamic message;
  List<HomeReservationsDataModel>? data;
  Extra? extra;
  Errors? errors;

  factory HomeReservationsModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModel(
    status: json["status"],
    message: json["message"],
    data: List<HomeReservationsDataModel>.from(json["data"].map((x) => HomeReservationsDataModel.fromJson(x))),
    extra: Extra.fromJson(json["extra"]),
    errors: Errors.fromJson(json["errors"]),
  );
}

class HomeReservationsDataModel {
  HomeReservationsDataModel({
    this.id,
    this.date,
    this.time,
    this.family,
    this.address,
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
  HomeReservationsModelAddress? address;
  HomeReservationsModelBranch? branch;
  List<dynamic>? coupon;
  dynamic price;
  dynamic tax;
  dynamic discount;
  dynamic total;
  dynamic status;
  dynamic statusEn;
  dynamic rate;
  dynamic rateMessage;
  HomeReservationsModelCreatedAt? createdAt;
  List<HomeReservationsModelTest>? tests;
  List<dynamic>? offers;

  factory HomeReservationsDataModel.fromJson(Map<dynamic, dynamic> json) => HomeReservationsDataModel(
    id: json["id"],
    date: json["date"],
    time: json["time"],
    family: List<dynamic>.from(json["family"].map((x) => x)),
    address: HomeReservationsModelAddress.fromJson(json["address"]),
    branch: HomeReservationsModelBranch.fromJson(json["branch"]),
    coupon: List<dynamic>.from(json["coupon"].map((x) => x)),
    price: json["price"],
    tax: json["tax"],
    discount: json["discount"],
    total: json["total"],
    status: json["status"],
    statusEn: json["statusEn"],
    rate: json["rate"],
    rateMessage: json["rateMessage"],
    createdAt: HomeReservationsModelCreatedAt.fromJson(json["created_at"]),
    tests: List<HomeReservationsModelTest>.from(json["tests"].map((x) => HomeReservationsModelTest.fromJson(x))),
    offers: List<dynamic>.from(json["offers"].map((x) => x)),
  );
}

class HomeReservationsModelAddress {
  HomeReservationsModelAddress({
    this.id,
    this.address,
    this.specialMark,
    this.floorNumber,
    this.buildingNumber,
  });

  dynamic id;
  dynamic address;
  dynamic specialMark;
  dynamic floorNumber;
  dynamic buildingNumber;

  factory HomeReservationsModelAddress.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModelAddress(
    id: json["id"],
    address: json["address"],
    specialMark: json["special_mark"],
    floorNumber: json["floor_number"],
    buildingNumber: json["building_number"],
  );
}

class HomeReservationsModelBranch {
  HomeReservationsModelBranch({
    this.id,
    this.title,
  });

  dynamic id;
  dynamic title;

  factory HomeReservationsModelBranch.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModelBranch(
    id: json["id"],
    title: json["title"],
  );
}

class HomeReservationsModelCreatedAt {
  HomeReservationsModelCreatedAt({
    this.date,
    this.time,
  });

  dynamic date;
  dynamic time;

  factory HomeReservationsModelCreatedAt.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModelCreatedAt(
    date: json["date"],
    time: json["time"],
  );
}

class HomeReservationsModelTest {
  HomeReservationsModelTest({
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

  factory HomeReservationsModelTest.fromJson(Map<dynamic, dynamic> json) => HomeReservationsModelTest(
    id: json["id"],
    title: json["title"],
    category: json["category"],
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
