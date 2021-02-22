import 'package:flutter_app/Models/OwnerModel/EmployeeDetails.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NestedEmployeeDetails.g.dart';

@JsonSerializable()
class NestedEmployeeDetails{
  EmployeeDetails result;
  NestedEmployeeDetails({this.result});
  factory NestedEmployeeDetails.fromJson(Map<String,dynamic> json) => _$NestedEmployeeDetailsFromJson(json);
  Map<String,dynamic> toJson() => _$NestedEmployeeDetailsToJson(this);
}