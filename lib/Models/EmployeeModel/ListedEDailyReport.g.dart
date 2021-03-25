// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListedEDailyReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListedEDailyReport _$ListedEDailyReportFromJson(Map<String, dynamic> json) {
  return ListedEDailyReport(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : EDailyReport.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedEDailyReportToJson(ListedEDailyReport instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
