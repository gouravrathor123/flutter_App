import 'package:flutter_app/Models/EmployeeModel/EDailyReport.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListedEDailyReport.g.dart';

@JsonSerializable()
class ListedEDailyReport{
  List<EDailyReport> result;
  ListedEDailyReport({this.result});
  factory ListedEDailyReport.fromJson(Map<String,dynamic> json) => _$ListedEDailyReportFromJson(json);
  Map<String,dynamic> toJson() => _$ListedEDailyReportToJson(this);
}