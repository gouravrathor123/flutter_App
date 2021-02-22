import 'package:flutter_app/Models/OwnerModel/OwnerTeam.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListedOwnerTeam.g.dart';

@JsonSerializable()
class ListedOwnerTeam{
  List<OwnerTeam> result;
  ListedOwnerTeam({this.result});
  factory ListedOwnerTeam.fromJson(Map<String,dynamic> json) => _$ListedOwnerTeamFromJson(json);
  Map<String,dynamic> toJson() => _$ListedOwnerTeamToJson(this);
}