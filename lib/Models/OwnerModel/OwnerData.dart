import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OwnerData.g.dart';

@JsonSerializable()
class OwnerData{
  String first_name;
  String last_name;
  String token;
  // ignore: non_constant_identifier_names
  OwnerData({this.first_name,this.last_name,this.token});
  factory OwnerData.fromJson(Map<String,dynamic> json) => _$OwnerDataFromJson(json);
  Map<String,dynamic> toJson() => _$OwnerDataToJson(this);
}