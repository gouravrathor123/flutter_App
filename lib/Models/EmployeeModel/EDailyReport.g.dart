// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EDailyReport.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EDailyReport _$EDailyReportFromJson(Map<String, dynamic> json) {
  return EDailyReport(
    id: json['_id'] as String,
    report: json['report'] as String,
  );
}

Map<String, dynamic> _$EDailyReportToJson(EDailyReport instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'report': instance.report,
    };
