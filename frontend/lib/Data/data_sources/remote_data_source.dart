import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Core/constants/api_constants.dart';
import '../models/attendance_model.dart';
import '../models/group_model.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
});

class RemoteDataSource {
  final Dio _dio;
  RemoteDataSource(this._dio);

  Future<ToggleResponseModel> toggleAttendance(String action) async {
    final response = await _dio.post(ApiConstants.toggleAttendance, data: {'action': action});
    return ToggleResponseModel.fromJson(response.data);
  }

  Future<Map<String, dynamic>> sendAttendanceResponse(String responseType) async {
    final response = await _dio.post(ApiConstants.attendanceResponse, data: {'response': responseType});
    return response.data;
  }

  Future<List<AttendanceRecordModel>> fetchMyMonthlyRecords() async {
    final response = await _dio.get(ApiConstants.myRecords);
    return (response.data['data'] as List).map((json) => AttendanceRecordModel.fromJson(json)).toList();
  }

  Future<List<GroupMemberStatusModel>> fetchGroupMemberStatus(int groupId) async {
    final endpoint = ApiConstants.groupStatus.replaceFirst('{groupId}', groupId.toString());
    final response = await _dio.get(endpoint);
    return (response.data as List).map((json) => GroupMemberStatusModel.fromJson(json)).toList();
  }
}

final remoteDataSourceProvider = Provider<RemoteDataSource>((ref) {
  return RemoteDataSource(ref.watch(dioProvider));
});