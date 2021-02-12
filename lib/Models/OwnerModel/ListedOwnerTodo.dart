import 'package:flutter_app/Models/OwnerModel/OwnerData.dart';
import 'package:flutter_app/Models/OwnerModel/OwnerTodo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListedOwnerTodo.g.dart';

@JsonSerializable()
class ListedOwnerTodo{
  List<OwnerTodo> result;
  ListedOwnerTodo({this.result});
  factory ListedOwnerTodo.fromJson(Map<String,dynamic> json) => _$ListedOwnerTodoFromJson(json);
  Map<String,dynamic> toJson() => _$ListedOwnerTodoToJson(this);
}