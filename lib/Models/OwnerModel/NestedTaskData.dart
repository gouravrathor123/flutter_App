
import 'package:flutter_app/Models/OwnerModel/TaskData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NestedTaskData.g.dart';

@JsonSerializable()
class NestedTaskData{
  TaskData result;
  NestedTaskData({this.result});
  factory NestedTaskData.fromJson(Map<String,dynamic> json) => _$NestedTaskDataFromJson(json);
  Map<String,dynamic> toJson() => _$NestedTaskDataToJson(this);
}