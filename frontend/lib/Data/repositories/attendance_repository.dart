import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/entities/group_entity.dart';
import '../data_sources/remote_data_source.dart';
import '../models/attendance_model.dart';

abstract class AttendanceRepository {
  Future<AttendanceToggleEntity> toggleAttendance(String action);
  Future<AttendanceResponseEntity> sendAttendanceResponse(String responseType);
  Future<List<AttendanceRecordEntity>> getMyMonthlyRecords();
  Future<List<GroupMemberStatusEntity>> getGroupMemberStatus(int groupId);
}

class AttendanceRepositoryImpl implements AttendanceRepository {
  final RemoteDataSource remoteDataSource;
  AttendanceRepositoryImpl(this.remoteDataSource);

  @override
  Future<AttendanceToggleEntity> toggleAttendance(String action) async {
    final model = await remoteDataSource.toggleAttendance(action);
    return AttendanceToggleEntity(
      isActive: model.isActive,
      lastOnTime: DateTime.parse(model.lastOnTime),
    );
  }

  @override
  Future<List<AttendanceRecordEntity>> getMyMonthlyRecords() async {
    final models = await remoteDataSource.fetchMyMonthlyRecords();
    return models.map((model) => AttendanceRecordEntity(date: model.date, timeInMinutes: model.timeInMinutes)).toList();
  }

  @override
  Future<AttendanceResponseEntity> sendAttendanceResponse(String responseType) async {
    final data = await remoteDataSource.sendAttendanceResponse(responseType);
    return AttendanceResponseEntity(
      success: data['success'] as bool,
      newIsActive: data['new_is_active'] as bool,
    );
  }

  @override
  Future<List<GroupMemberStatusEntity>> getGroupMemberStatus(int groupId) async {
    final models = await remoteDataSource.fetchGroupMemberStatus(groupId);
    return models.map((model) => GroupMemberStatusEntity(
      nickname: model.nickname,
      isActive: model.isActive,
      totalHours: model.totalHours,
      memberId: model.memberId,
    )).toList();
  }
}

final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  return AttendanceRepositoryImpl(ref.watch(remoteDataSourceProvider));
});