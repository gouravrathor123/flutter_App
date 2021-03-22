// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NestedEmployeeData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedEmployeeData _$NestedEmployeeDataFromJson(Map<String, dynamic> json) {
  return NestedEmployeeData(
    result: json['result'] == null
        ? null
        : EmployeeData.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NestedEmployeeDataToJson(NestedEmployeeData instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
