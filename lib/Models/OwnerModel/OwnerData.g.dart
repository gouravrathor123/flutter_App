// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OwnerData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnerData _$OwnerDataFromJson(Map<String, dynamic> json) {
  return OwnerData(
    first_name: json['first_name'] as String,
    last_name: json['last_name'] as String,
    token: json['token'] as String,
  );
}

Map<String, dynamic> _$OwnerDataToJson(OwnerData instance) => <String, dynamic>{
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'token': instance.token,
    };
