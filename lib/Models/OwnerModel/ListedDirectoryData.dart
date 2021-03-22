import 'package:flutter_app/Models/OwnerModel/DirectoryData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListedDirectoryData.g.dart';

@JsonSerializable()
class ListedDirectoryData{
  List<DirectoryData> result;
  ListedDirectoryData({this.result});
  factory ListedDirectoryData.fromJson(Map<String,dynamic> json) => _$ListedDirectoryDataFromJson(json);
  Map<String,dynamic> toJson() => _$ListedDirectoryDataToJson(this);
}