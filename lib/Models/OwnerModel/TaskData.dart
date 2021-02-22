import 'package:json_annotation/json_annotation.dart';

part 'TaskData.g.dart';

@JsonSerializable()
class TaskData{
  String title;
  String description;
  bool status;
  // ignore: non_constant_identifier_names
  String due_date;
  // ignore: non_constant_identifier_names
  TaskData({this.description,this.due_date,this.title,this.status});
  factory TaskData.fromJson(Map<String,dynamic> json) => _$TaskDataFromJson(json);
  Map<String,dynamic> toJson() => _$TaskDataToJson(this);
}