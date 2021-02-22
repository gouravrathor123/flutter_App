// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NestedEmployeeDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedEmployeeDetails _$NestedEmployeeDetailsFromJson(
    Map<String, dynamic> json) {
  return NestedEmployeeDetails(
    result: json['result'] == null
        ? null
        : EmployeeDetails.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NestedEmployeeDetailsToJson(
        NestedEmployeeDetails instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
