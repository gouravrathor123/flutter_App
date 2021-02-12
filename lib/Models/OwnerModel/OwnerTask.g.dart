// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OwnerTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerTask _$OwnerTaskFromJson(Map<String, dynamic> json) {
  return OwnerTask(
    id: json['_id'] as String,
    assigned_to: json['assigned_to'] as String,
    due_date: json['due_date'] == null
        ? null
        : DateTime.parse(json['due_date'] as String),
    description: json['description'] as String,
    status: json['status'] as bool,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$OwnerTaskToJson(OwnerTask instance) => <String, dynamic>{
      '_id': instance.id,
      'assigned_to': instance.assigned_to,
      'title': instance.title,
      'due_date': instance.due_date?.toIso8601String(),
      'status': instance.status,
      'description': instance.description,
    };
