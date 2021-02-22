// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListedOwnerTeam.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListedOwnerTeam _$ListedOwnerTeamFromJson(Map<String, dynamic> json) {
  return ListedOwnerTeam(
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : OwnerTeam.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ListedOwnerTeamToJson(ListedOwnerTeam instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
