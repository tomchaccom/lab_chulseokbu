import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/attendance_repository.dart';
import '../entities/attendance_entity.dart';

class AttendanceResponseUsecase {
  final AttendanceRepository repository;
  AttendanceResponseUsecase(this.repository);

  Future<AttendanceResponseEntity> execute(String responseType) async {
    // Repository를 통해 응답을 백엔드에 전달하고 결과(새로운 잔류 상태)를 받습니다.
    final result = await repository.sendAttendanceResponse(responseType);

    // 백엔드에서 잔류 시간 계산 및 ON/OFF 처리가 완료됨
    return result;
  }
}

final attendanceResponseUsecaseProvider = Provider<AttendanceResponseUsecase>((ref) {
  return AttendanceResponseUsecase(ref.watch(attendanceRepositoryProvider));
});