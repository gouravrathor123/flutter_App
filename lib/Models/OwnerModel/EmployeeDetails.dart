import 'package:json_annotation/json_annotation.dart';

part 'EmployeeDetails.g.dart';

@JsonSerializable()
class EmployeeDetails{
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
  EmployeeDetails({this.id,this.first_name,this.last_name,this.occupation,this.email,this.date_of_birth,this.phone});
  factory EmployeeDetails.fromJson(Map<String,dynamic> json) => _$EmployeeDetailsFromJson(json);
  Map<String,dynamic> toJson() => _$EmployeeDetailsToJson(this);
}