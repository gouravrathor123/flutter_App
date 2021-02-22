import 'package:flutter_app/Models/OwnerModel/OwnerTask.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListedOwnerTask.g.dart';

@JsonSerializable()
class ListedOwnerTask{
  List<OwnerTask> result;
  ListedOwnerTask({this.result});
  factory ListedOwnerTask.fromJson(Map<String,dynamic> json) => _$ListedOwnerTaskFromJson(json);
  Map<String,dynamic> toJson() => _$ListedOwnerTaskToJson(this);
}