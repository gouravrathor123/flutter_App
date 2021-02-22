// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NestedTaskData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedTaskData _$NestedTaskDataFromJson(Map<String, dynamic> json) {
  return NestedTaskData(
    result: json['result'] == null
        ? null
        : TaskData.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NestedTaskDataToJson(NestedTaskData instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
