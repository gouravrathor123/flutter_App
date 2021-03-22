// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NestedETaskData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedETaskData _$NestedETaskDataFromJson(Map<String, dynamic> json) {
  return NestedETaskData(
    result: json['result'] == null
        ? null
        : ETaskData.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NestedETaskDataToJson(NestedETaskData instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
