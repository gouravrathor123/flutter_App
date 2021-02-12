// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OwnerTodo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerTodo _$OwnerTodoFromJson(Map<String, dynamic> json) {
  return OwnerTodo(
    id: json['_id'] as String,
    description: json['description'] as String,
    completed: json['completed'] as bool,
  );
}

Map<String, dynamic> _$OwnerTodoToJson(OwnerTodo instance) => <String, dynamic>{
      '_id': instance.id,
      'description': instance.description,
      'completed': instance.completed,
    };
