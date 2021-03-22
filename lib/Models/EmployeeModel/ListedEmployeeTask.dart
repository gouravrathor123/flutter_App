import 'package:flutter_app/Models/EmployeeModel/EmployeeTask.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListedEmployeeTask.g.dart';

@JsonSerializable()
class ListedEmployeeTask{
  List<EmployeeTask> result;
  ListedEmployeeTask({this.result});
  factory ListedEmployeeTask.fromJson(Map<String,dynamic> json) => _$ListedEmployeeTaskFromJson(json);
  Map<String,dynamic> toJson() => _$ListedEmployeeTaskToJson(this);
}