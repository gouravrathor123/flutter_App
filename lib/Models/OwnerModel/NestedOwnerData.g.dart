// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NestedOwnerData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NestedOwnerData _$NestedOwnerDataFromJson(Map<String, dynamic> json) {
  return NestedOwnerData(
    result: json['result'] == null
        ? null
        : OwnerData.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$NestedOwnerDataToJson(NestedOwnerData instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
