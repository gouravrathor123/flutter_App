// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmployeeTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeTask _$EmployeeTaskFromJson(Map<String, dynamic> json) {
  return EmployeeTask(
    id: json['_id'] as String,
    due_date: json['due_date'] == null
        ? null
        : DateTime.parse(json['due_date'] as String),
    description: json['description'] as String,
    status: json['status'] as bool,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$EmployeeTaskToJson(EmployeeTask instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'due_date': instance.due_date?.toIso8601String(),
      'status': instance.status,
      'description': instance.description,
    };
