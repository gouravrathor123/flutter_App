import 'package:json_annotation/json_annotation.dart';

part 'OwnerData.g.dart';

@JsonSerializable()
class OwnerData{
  // ignore: non_constant_identifier_names
  String first_name;
  // ignore: non_constant_identifier_names
  String last_name;
  String avatar;
  String token;
  String email;
  // ignore: non_constant_identifier_names
  OwnerData({this.first_name,this.last_name,this.email,this.token,this.avatar});
  factory OwnerData.fromJson(Map<String,dynamic> json) => _$OwnerDataFromJson(json);
  Map<String,dynamic> toJson() => _$OwnerDataToJson(this);
}