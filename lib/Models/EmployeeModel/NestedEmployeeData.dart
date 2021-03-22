import 'package:flutter_app/Models/EmployeeModel/EmployeeData.dart';
import 'package:flutter_app/Models/OwnerModel/EmployeeDetails.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NestedEmployeeData.g.dart';

@JsonSerializable()
class NestedEmployeeData{
  EmployeeData result;
  NestedEmployeeData({this.result});
  factory NestedEmployeeData.fromJson(Map<String,dynamic> json) => _$NestedEmployeeDataFromJson(json);
  Map<String,dynamic> toJson() => _$NestedEmployeeDataToJson(this);
}