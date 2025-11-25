// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AttendanceRecordModel _$AttendanceRecordModelFromJson(
  Map<String, dynamic> json,
) => _AttendanceRecordModel(
  date: json['date'] as String,
  timeInMinutes: (json['timeInMinutes'] as num).toInt(),
  timeInHours: (json['timeInHours'] as num).toDouble(),
);

Map<String, dynamic> _$AttendanceRecordModelToJson(
  _AttendanceRecordModel instance,
) => <String, dynamic>{
  'date': instance.date,
  'timeInMinutes': instance.timeInMinutes,
  'timeInHours': instance.timeInHours,
};

_ToggleResponseModel _$ToggleResponseModelFromJson(Map<String, dynamic> json) =>
    _ToggleResponseModel(
      isActive: json['isActive'] as bool,
      lastOnTime: json['lastOnTime'] as String,
    );

Map<String, dynamic> _$ToggleResponseModelToJson(
  _ToggleResponseModel instance,
) => <String, dynamic>{
  'isActive': instance.isActive,
  'lastOnTime': instance.lastOnTime,
};
