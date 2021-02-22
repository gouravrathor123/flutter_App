// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmployeeDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDetails _$EmployeeDetailsFromJson(Map<String, dynamic> json) {
  return EmployeeDetails(
    id: json['_id'] as String,
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    occupation: json['occupation'] as String,
    email: json['email'] as String,
    date_of_birth: json['date_of_birth'] == null
        ? null
        : DateTime.parse(json['date_of_birth'] as String),
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$EmployeeDetailsToJson(EmployeeDetails instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'occupation': instance.occupation,
      'date_of_birth': instance.date_of_birth?.toIso8601String(),
      'phone': instance.phone,
      'email': instance.email,
    };
