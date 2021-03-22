import 'package:json_annotation/json_annotation.dart';

part 'EmployeeData.g.dart';

@JsonSerializable()
class EmployeeData{
  // ignore: non_constant_identifier_names
  String first_name;
  // ignore: non_constant_identifier_names
  String last_name;
  String avatar;
  String token;
  String email;
  // ignore: non_constant_identifier_names
  EmployeeData({this.first_name,this.last_name,this.email,this.token,this.avatar});
  factory EmployeeData.fromJson(Map<String,dynamic> json) => _$EmployeeDataFromJson(json);
  Map<String,dynamic> toJson() => _$EmployeeDataToJson(this);
}