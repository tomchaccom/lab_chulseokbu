// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GroupMemberStatusModel _$GroupMemberStatusModelFromJson(
  Map<String, dynamic> json,
) => _GroupMemberStatusModel(
  memberId: (json['memberId'] as num).toInt(),
  nickname: json['nickname'] as String,
  isActive: json['isActive'] as bool,
  totalHours: (json['totalHours'] as num).toDouble(),
);

Map<String, dynamic> _$GroupMemberStatusModelToJson(
  _GroupMemberStatusModel instance,
) => <String, dynamic>{
  'memberId': instance.memberId,
  'nickname': instance.nickname,
  'isActive': instance.isActive,
  'totalHours': instance.totalHours,
};
