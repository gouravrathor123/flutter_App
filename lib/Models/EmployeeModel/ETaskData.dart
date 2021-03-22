import 'package:json_annotation/json_annotation.dart';

part 'ETaskData.g.dart';

@JsonSerializable()
class ETaskData{
  String title;
  String description;
  bool status;
  // ignore: non_constant_identifier_names
  String due_date;
  // ignore: non_constant_identifier_names
  ETaskData({this.description,this.due_date,this.title,this.status});
  factory ETaskData.fromJson(Map<String,dynamic> json) => _$ETaskDataFromJson(json);
  Map<String,dynamic> toJson() => _$ETaskDataToJson(this);
}