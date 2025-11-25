import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Domain/entities/attendance_entity.dart';
import '../../Domain/usecases/toggle_attendance_usecase.dart';
import '../../Domain/usecases/get_my_records_usecase.dart';
import '../../Domain/usecases/attendance_response_usecase.dart'; // ⭐️ 추가
import 'dart:async';

class AttendanceState {
  final bool isActive;
  final DateTime? lastOnTime;
  final List<AttendanceRecordEntity> monthlyRecords;
  final bool isLoading;
  final String? errorMessage;

  AttendanceState({
    this.isActive = false,
    this.lastOnTime,
    this.monthlyRecords = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  AttendanceState copyWith({
    bool? isActive,
    DateTime? lastOnTime,
    List<AttendanceRecordEntity>? monthlyRecords,
    bool? isLoading,
    String? errorMessage,
  }) {
    return AttendanceState(
      isActive: isActive ?? this.isActive,
      lastOnTime: lastOnTime ?? this.lastOnTime,
      monthlyRecords: monthlyRecords ?? this.monthlyRecords,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

final attendanceProvider = StateNotifierProvider<AttendanceNotifier, AttendanceState>((ref) {
  return AttendanceNotifier(
    ref.read(toggleAttendanceUsecaseProvider),
    ref.read(getMyRecordsUsecaseProvider),
    ref.read(attendanceResponseUsecaseProvider), // ⭐️ 알림 응답 UseCase 주입
  );
});

class AttendanceNotifier extends StateNotifier<AttendanceState> {
  final ToggleAttendanceUsecase _toggleUsecase;
  final GetMyRecordsUsecase _recordsUsecase;
  final AttendanceResponseUsecase _responseUsecase; // ⭐️ 추가

  AttendanceNotifier(
      this._toggleUsecase,
      this._recordsUsecase,
      this._responseUsecase, // ⭐️ 생성자 완성
      ) : super(AttendanceState()) {
    loadMonthlyRecords();
  }

  // 1. 잔류 상태 토글 요청
  Future<void> toggleStatus(bool turnOn) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final result = await _toggleUsecase.execute(turnOn);

      state = state.copyWith(
        isActive: result.isActive,
        lastOnTime: result.isActive ? result.lastOnTime : null,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: '상태 변경 실패: $e');
    }
  }

  // 2. 월별 잔류 기록 로드
  Future<void> loadMonthlyRecords() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final records = await _recordsUsecase.execute();
      state = state.copyWith(monthlyRecords: records, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: '기록 로드 실패: $e');
    }
  }

  // 3. 알림 응답 처리 (YES/NO/TIMEOUT)
  Future<void> handleAlertReonse(String responseType) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final result = await _responseUsecase.execute(responseType);

      if (result.success) {
        // 백엔드 처리 결과에 따라 상태 업데이트
        state = state.copyWith(
          isActive: result.newIsActive,
          isLoading: false,
        );

        // 잔류 연장(YES) 시, lastOnTime을 현재 시간으로 업데이트해야 함 (UI 타이머 리셋용)
        if (responseType == 'YES') {
          state = state.copyWith(lastOnTime: DateTime.now());
        } else {
          // NO 또는 TIMEOUT 시, 잔류 종료
          state = state.copyWith(lastOnTime: null);
        }

      } else {
        state = state.copyWith(isLoading: false, errorMessage: '응답 처리 실패: 서버 오류');
      }

      // 잔류 시간이 변경되었을 수 있으므로 기록을 새로고침합니다.
      loadMonthlyRecords();

    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: '알림 응답 처리 중 오류 발생: $e');
    }
  }
}