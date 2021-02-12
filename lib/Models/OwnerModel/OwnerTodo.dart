import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'OwnerTodo.g.dart';

@JsonSerializable()
class OwnerTodo{
  @JsonKey(name: '_id')
  String id;
  String description;
  bool completed;
  OwnerTodo({this.id,this.description,this.completed});
  factory OwnerTodo.fromJson(Map<String,dynamic> json) => _$OwnerTodoFromJson(json);
  Map<String,dynamic> toJson() => _$OwnerTodoToJson(this);
}