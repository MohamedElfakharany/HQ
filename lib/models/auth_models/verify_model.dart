import 'dart:convert';

VerifyModel verifyModelFromJson(dynamic str) => VerifyModel.fromJson(json.decode(str));

class VerifyModel {
  VerifyModel({
    this.status,
  });

  dynamic status;

  factory VerifyModel.fromJson(Map<dynamic, dynamic> json) => VerifyModel(
  status: json["status"]);
}