import 'package:json_annotation/json_annotation.dart';

part 'EDailyReport.g.dart';

@JsonSerializable()
class EDailyReport{
  @JsonKey(name: '_id')
  String id;
  String report;
  EDailyReport({this.id,this.report});
  factory EDailyReport.fromJson(Map<String,dynamic> json) => _$EDailyReportFromJson(json);
  Map<String,dynamic> toJson() => _$EDailyReportToJson(this);
}