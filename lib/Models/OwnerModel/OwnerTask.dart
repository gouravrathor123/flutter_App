import 'package:json_annotation/json_annotation.dart';

part 'OwnerTask.g.dart';

@JsonSerializable()
class OwnerTask{
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'assigned_to')
  // ignore: non_constant_identifier_names
  String assigned_to;
  String title;
  // ignore: non_constant_identifier_names
  DateTime due_date;
  bool status;
  String description;
  // ignore: non_constant_identifier_names
  OwnerTask({this.id,this.assigned_to,this.due_date,this.description,this.status,this.title});
  factory OwnerTask.fromJson(Map<String,dynamic> json) => _$OwnerTaskFromJson(json);
  Map<String,dynamic> toJson() => _$OwnerTaskToJson(this);
}