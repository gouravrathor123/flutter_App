// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListedOwnerTask.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListedOwnerTask _$ListedOwnerTaskFromJson(Map<String, dynamic> json) {
  return ListedOwnerTask(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : OwnerTask.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedOwnerTaskToJson(ListedOwnerTask instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
