import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/attendance_repository.dart';
import '../entities/attendance_entity.dart';

class GetMyRecordsUsecase {
  final AttendanceRepository repository;
  GetMyRecordsUsecase(this.repository);

  Future<List<AttendanceRecordEntity>> execute() async {
    final records = await repository.getMyMonthlyRecords();
    return records;
  }
}

final getMyRecordsUsecaseProvider = Provider<GetMyRecordsUsecase>((ref) {
  return GetMyRecordsUsecase(ref.watch(attendanceRepositoryProvider));
});