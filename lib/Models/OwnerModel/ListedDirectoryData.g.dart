// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListedDirectoryData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListedDirectoryData _$ListedDirectoryDataFromJson(Map<String, dynamic> json) {
  return ListedDirectoryData(
    result: (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : DirectoryData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedDirectoryDataToJson(
        ListedDirectoryData instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
