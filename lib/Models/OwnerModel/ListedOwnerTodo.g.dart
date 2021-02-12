// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListedOwnerTodo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListedOwnerTodo _$ListedOwnerTodoFromJson(Map<String, dynamic> json) {
  return ListedOwnerTodo(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : OwnerTodo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedOwnerTodoToJson(ListedOwnerTodo instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
