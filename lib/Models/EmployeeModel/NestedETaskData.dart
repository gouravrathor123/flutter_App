import 'package:flutter_app/Models/EmployeeModel/ETaskData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NestedETaskData.g.dart';

@JsonSerializable()
class NestedETaskData{
  ETaskData result;
  NestedETaskData({this.result});
  factory NestedETaskData.fromJson(Map<String,dynamic> json) => _$NestedETaskDataFromJson(json);
  Map<String,dynamic> toJson() => _$NestedETaskDataToJson(this);
}