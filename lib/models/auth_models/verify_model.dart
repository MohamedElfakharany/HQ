import 'dart:convert';

SuccessModel successModelFromJson(dynamic str) => SuccessModel.fromJson(json.decode(str));

class SuccessModel {
  SuccessModel({
    this.status,
  });

  dynamic status;

  factory SuccessModel.fromJson(Map<dynamic, dynamic> json) => SuccessModel(
  status: json["status"]);
}