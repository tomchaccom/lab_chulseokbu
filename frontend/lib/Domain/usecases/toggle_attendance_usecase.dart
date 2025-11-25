import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/attendance_repository.dart';
import '../entities/attendance_entity.dart';

class ToggleAttendanceUsecase {
  final AttendanceRepository repository;
  ToggleAttendanceUsecase(this.repository);

  Future<AttendanceToggleEntity> execute(bool turnOn) async {
    final action = turnOn ? 'ON' : 'OFF';
    final result = await repository.toggleAttendance(action);

    // ON 성공 시, 2시간 알림 타이머 예약 로직 필요
    if (result.isActive) {
      print('Attendance ON. Scheduling 2-hour alert.');
    } else {
      print('Attendance OFF. Cancelling scheduled alerts.');
    }
    return result;
  }
}

final toggleAttendanceUsecaseProvider = Provider<ToggleAttendanceUsecase>((ref) {
  return ToggleAttendanceUsecase(ref.watch(attendanceRepositoryProvider));
});