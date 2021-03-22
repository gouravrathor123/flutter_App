// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DirectoryData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DirectoryData _$DirectoryDataFromJson(Map<String, dynamic> json) {
  return DirectoryData(
    owner: json['owner'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
  );
}

Map<String, dynamic> _$DirectoryDataToJson(DirectoryData instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'name': instance.name,
      'phone': instance.phone,
    };
