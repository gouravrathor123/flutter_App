import 'package:json_annotation/json_annotation.dart';

part 'DirectoryData.g.dart';

@JsonSerializable()
class DirectoryData{
  @JsonKey(name: 'owner')
  String owner;
  String name;
  String phone;
  DirectoryData({this.owner,this.name,this.phone});
  factory DirectoryData.fromJson(Map<String,dynamic> json) => _$DirectoryDataFromJson(json);
  Map<String,dynamic> toJson() => _$DirectoryDataToJson(this);
}