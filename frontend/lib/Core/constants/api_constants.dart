class ApiConstants {
  static const String baseUrl = 'https://your-backend-api.com';

  static const String login = '/api/v1/auth/login';
  static const String joinGroup = '/api/v1/groups/join';

  static const String toggleAttendance = '/api/v1/attendance/toggle';
  static const String attendanceResponse = '/api/v1/attendance/response';
  static const String myRecords = '/api/v1/attendance/my-record';

  static const String groupStatus = '/api/v1/groups/{groupId}/status';
  static const String groupMonthly = '/api/v1/groups/{groupId}/monthly';
}