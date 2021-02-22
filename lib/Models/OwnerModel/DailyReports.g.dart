// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailyReports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyReports _$DailyReportsFromJson(Map<String, dynamic> json) {
  return DailyReports(
    id: json['_id'] as String,
    report: json['report'] as String,
    user_id: json['user_id'] as String,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );
}

Map<String, dynamic> _$DailyReportsToJson(DailyReports instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user_id': instance.user_id,
      'report': instance.report,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
