import 'package:json_annotation/json_annotation.dart';

part 'DailyReports.g.dart';

@JsonSerializable()
class DailyReports{
  @JsonKey(name: '_id')
  String id;
  @JsonKey(name: 'user_id')
  // ignore: non_constant_identifier_names
  String user_id;
  String report;
  // ignore: non_constant_identifier_names
  DateTime createdAt;
  // ignore: non_constant_identifier_names
  DailyReports({this.id,this.report,this.user_id,this.createdAt});
  factory DailyReports.fromJson(Map<String,dynamic> json) => _$DailyReportsFromJson(json);
  Map<String,dynamic> toJson() => _$DailyReportsToJson(this);
}