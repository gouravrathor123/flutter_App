// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListedDailyReports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListedDailyReports _$ListedDailyReportsFromJson(Map<String, dynamic> json) {
  return ListedDailyReports(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : DailyReports.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedDailyReportsToJson(ListedDailyReports instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
