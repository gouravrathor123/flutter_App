import 'package:flutter_app/Models/OwnerModel/DailyReports.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListedDailyReports.g.dart';

@JsonSerializable()
class ListedDailyReports{
  List<DailyReports> result;
  ListedDailyReports({this.result});
  factory ListedDailyReports.fromJson(Map<String,dynamic> json) => _$ListedDailyReportsFromJson(json);
  Map<String,dynamic> toJson() => _$ListedDailyReportsToJson(this);
}