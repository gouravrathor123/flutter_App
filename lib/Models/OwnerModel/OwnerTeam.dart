import 'package:json_annotation/json_annotation.dart';

part 'OwnerTeam.g.dart';

@JsonSerializable()
class OwnerTeam{
  @JsonKey(name: '_id')
  String id;
  // ignore: non_constant_identifier_names
  String first_name;
  // ignore: non_constant_identifier_names
  String last_name;
  String occupation;
  // ignore: non_constant_identifier_names
  DateTime date_of_birth;
  String phone;
  String email;
  // ignore: non_constant_identifier_names
  OwnerTeam({this.id,this.first_name,this.last_name,this.occupation,this.email,this.date_of_birth,this.phone});
  factory OwnerTeam.fromJson(Map<String,dynamic> json) => _$OwnerTeamFromJson(json);
  Map<String,dynamic> toJson() => _$OwnerTeamToJson(this);
}