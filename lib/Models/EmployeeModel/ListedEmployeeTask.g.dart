// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListedEmployeeTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListedEmployeeTask _$ListedEmployeeTaskFromJson(Map<String, dynamic> json) {
  return ListedEmployeeTask(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : EmployeeTask.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedEmployeeTaskToJson(ListedEmployeeTask instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
