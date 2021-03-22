// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmployeeData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeData _$EmployeeDataFromJson(Map<String, dynamic> json) {
  return EmployeeData(
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    email: json['email'] as String,
    token: json['token'] as String,
    avatar: json['avatar'] as String,
  );
}

Map<String, dynamic> _$EmployeeDataToJson(EmployeeData instance) =>
    <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'avatar': instance.avatar,
      'token': instance.token,
      'email': instance.email,
    };
