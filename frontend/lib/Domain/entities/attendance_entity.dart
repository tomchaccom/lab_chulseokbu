class AttendanceRecordEntity {
  final String date;
  final int timeInMinutes;
  AttendanceRecordEntity({required this.date, required this.timeInMinutes});
}

class AttendanceToggleEntity {
  final bool isActive;
  final DateTime lastOnTime;
  AttendanceToggleEntity({required this.isActive, required this.lastOnTime});
}

class AttendanceResponseEntity {
  final bool success;
  final bool newIsActive;
  AttendanceResponseEntity({required this.success, required this.newIsActive});
}