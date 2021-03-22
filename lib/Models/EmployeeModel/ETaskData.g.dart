// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ETaskData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ETaskData _$ETaskDataFromJson(Map<String, dynamic> json) {
  return ETaskData(
    description: json['description'] as String,
    due_date: json['due_date'] as String,
    title: json['title'] as String,
    status: json['status'] as bool,
  );
}

Map<String, dynamic> _$ETaskDataToJson(ETaskData instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'due_date': instance.due_date,
    };
