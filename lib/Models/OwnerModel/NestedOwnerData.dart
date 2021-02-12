import 'package:flutter_app/Models/OwnerModel/OwnerData.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NestedOwnerData.g.dart';

@JsonSerializable()
class NestedOwnerData{
    OwnerData result;
    NestedOwnerData({this.result});
    factory NestedOwnerData.fromJson(Map<String,dynamic> json) => _$NestedOwnerDataFromJson(json);
    Map<String,dynamic> toJson() => _$NestedOwnerDataToJson(this);
}