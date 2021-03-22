import 'package:json_annotation/json_annotation.dart';

part 'EmployeeTask.g.dart';

@JsonSerializable()
class EmployeeTask{
  @JsonKey(name: '_id')
  String id;
  String title;
  // ignore: non_constant_identifier_names
  DateTime due_date;
  bool status;
  String description;
  // ignore: non_constant_identifier_names
  EmployeeTask({this.id,this.due_date,this.description,this.status,this.title});
  factory EmployeeTask.fromJson(Map<String,dynamic> json) => _$EmployeeTaskFromJson(json);
  Map<String,dynamic> toJson() => _$EmployeeTaskToJson(this);
}