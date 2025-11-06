import 'package:flutter/material.dart';

// 랩실 상태를 정의하는 enum
enum LabStatus { inLab, outLab }

const Color White = Color(0xFFFFFFFF);
const Color Grey = Color(0xFF9CA3AF);
const Color LightGrey = Color(0xFFE5E7EB); // 비활성화된 버튼 배경색

// 화면의 한 부분을 구성하는 메인 상태 관리 위젯
class LabStatusCard extends StatefulWidget {
  const LabStatusCard({super.key});

  @override
  State<LabStatusCard> createState() => _LabStatusCardState();
}

class _LabStatusCardState extends State<LabStatusCard> {
  // 현재 랩실 상태를 저장하는 변수 (기본값: 랩실 밖에 있음)
  LabStatus _currentStatus = LabStatus.outLab;

  // 상태 업데이트 함수
  void _updateStatus(LabStatus newStatus) {
    if (_currentStatus != newStatus) {
      setState(() {
        _currentStatus = newStatus;
      });
      // 실제 로직에서는 여기에 서버 통신 등을 추가합니다.
      print('Status updated to: ${_currentStatus == LabStatus.inLab ? 'In Lab' : 'Out Lab'}');
    }
  }

  @override
  Widget build(BuildContext context) {
    // 시각적 구분을 위해 Card 위젯 사용
    return Card(
      // 카드 내부의 여백 설정
      margin: const EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        // 모든 요소를 세로로 배치
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            // 1. 섹션 제목
            const Text(
              '랩실 상태',
              style: TextStyle(
                fontSize: 15.3,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16), // 간격

            // 2. 현재 상태 표시 영역 (상태 변수에 따라 텍스트/색상 변경)
            _CurrentStatus(status: _currentStatus),
            const SizedBox(height: 16), // 간격

            // 3. 들어오기/나가기 버튼 영역 (상태 업데이트 함수 전달)
            _InOutButtons(
              currentStatus: _currentStatus,
              onUpdateStatus: _updateStatus,
            ),
            const SizedBox(height: 16), // 간격

            // 4. 직접 상태 변경 토글 영역
            const _ManualToggle(),
          ],
        ),
      ),
    );
  }
}

// --- 하위 위젯들을 분리하여 구현 (가독성 향상) ---

// 2. 현재 상태 표시 위젯 (LabStatus를 받아 상태에 따라 내용 변경)
class _CurrentStatus extends StatelessWidget {
  final LabStatus status;
  const _CurrentStatus({required this.status});

  @override
  Widget build(BuildContext context) {
    // 상태에 따른 텍스트 및 색상 설정
    final isInLab = status == LabStatus.inLab;
    final statusText = isInLab ? '랩실 안에 있습니다' : '랩실 밖에 있습니다';
    final statusDetail = isInLab ? '마지막 체크인: 오늘 09:45' : '마지막 체크아웃: 어제 18:30';
    final statusColor = isInLab ? Colors.green.shade600 : Grey;

    // 아이콘과 텍스트를 가로로 배치
    return Row(
      children: [
        // 시계 아이콘 (색상 변화)
        Icon(Icons.schedule, size: 64, color: statusColor),
        const SizedBox(width: 16),
        // 상태 텍스트
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statusText,
              style: TextStyle(
                fontSize: 15.3,
                color: statusColor, // 색상 변화
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
                statusDetail,
                style: const TextStyle(fontSize: 11.9, color: Grey)
            ),
          ],
        ),
      ],
    );
  }
}

// 3. 들어오기/나가기 버튼 위젯 (상태에 따라 스타일 변화)
class _InOutButtons extends StatelessWidget {
  final LabStatus currentStatus;
  final Function(LabStatus) onUpdateStatus;

  const _InOutButtons({required this.currentStatus, required this.onUpdateStatus});

  @override
  Widget build(BuildContext context) {
    final isInLab = currentStatus == LabStatus.inLab;

    // --- 버튼 스타일 정의 ---

    // 랩실 '안에 있음' 버튼 스타일 (선택/비선택)
    final inStyle = ElevatedButton.styleFrom(
      backgroundColor: isInLab ? Colors.deepOrange : LightGrey, // 선택되면 주황, 아니면 밝은 회색
      foregroundColor: isInLab ? White : Grey, // 선택되면 흰색, 아니면 회색
      minimumSize: const Size(double.infinity, 80),
      elevation: isInLab ? 4 : 0, // 선택되면 그림자 추가
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    // 랩실 '밖에 있음' 버튼 스타일 (선택/비선택)
    final outStyle = ElevatedButton.styleFrom(
      backgroundColor: !isInLab ? Colors.deepOrange : LightGrey, // 선택되면 주황, 아니면 밝은 회색
      foregroundColor: !isInLab ? White : Grey, // 선택되면 흰색, 아니면 회색
      minimumSize: const Size(double.infinity, 80),
      elevation: !isInLab ? 4 : 0, // 선택되면 그림자 추가
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );

    return Row(
      children: [
        // 들어오기 버튼 (IN_LAB)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 4.0), // 버튼 사이 간격 조정
            child: ElevatedButton.icon(
              onPressed: () => onUpdateStatus(LabStatus.inLab),
              icon: const Icon(Icons.arrow_forward_ios, size: 20),
              label: const Text('들어오기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: inStyle,
            ),
          ),
        ),

        // 나가기 버튼 (OUT_LAB)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0), // 버튼 사이 간격 조정
            child: ElevatedButton.icon(
              onPressed: () => onUpdateStatus(LabStatus.outLab),
              icon: const Icon(Icons.arrow_back_ios, size: 20),
              label: const Text('나가기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: outStyle,
            ),
          ),
        ),
      ],
    );
  }
}

// 4. 직접 상태 변경 토글 위젯
class _ManualToggle extends StatefulWidget {
  const _ManualToggle();

  @override
  State<_ManualToggle> createState() => _ManualToggleState();
}

class _ManualToggleState extends State<_ManualToggle> {
  bool _isManualEnabled = false; // 토글 상태 변수

  @override
  Widget build(BuildContext context) {
    // 텍스트와 스위치를 가로로 배치
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 양쪽 끝으로 벌림
      children: [
        const Text('직접 상태 변경', style: TextStyle(fontSize: 14, color: Grey)),
        // 토글 스위치 (상태 관리 필요)
        Switch(
          value: _isManualEnabled,
          onChanged: (bool newValue) {
            setState(() {
              _isManualEnabled = newValue;
            });
            // 로직: 수동 상태 변경이 켜지면 자동 감지 기능을 끄는 등의 로직 구현
          },
        ),
      ],
    );
  }
}