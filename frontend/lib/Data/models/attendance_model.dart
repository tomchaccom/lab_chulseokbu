import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_model.freezed.dart';
part 'attendance_model.g.dart';

@freezed
abstract class AttendanceRecordModel with _$AttendanceRecordModel {
  const factory AttendanceRecordModel({
    required String date,
    required int timeInMinutes,
    required double timeInHours,
  }) = _AttendanceRecordModel;

  factory AttendanceRecordModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceRecordModelFromJson(json);
}

@freezed
abstract class ToggleResponseModel with _$ToggleResponseModel {
  const factory ToggleResponseModel({
    required bool isActive,
    required String lastOnTime,
  }) = _ToggleResponseModel;

  factory ToggleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ToggleResponseModelFromJson(json);
}