// lib/notification_view.dart
import 'dart:async';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------
//
// -----------------------------------------------------------------

// 알림의 상태를 구분하는 열거형
enum AlarmStatus {
  pending,
  active,
  respondedYes,
  respondedNo,
  timedOut,
}

// 각 알림 항목이 가질 데이터 모델
class AlarmData {
  final String id;
  final String time;
  final String date;
  final AlarmStatus status;
  final Duration? initialCountdown;

  const AlarmData({
    required this.id,
    required this.time,
    required this.date,
    required this.status,
    this.initialCountdown,
  });
}

// 알림 화면 전체를 구성하는 위젯
class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  // 이 데이터는 실제로는 서버나 데이터베이스에서 받아와야 합니다.
  final List<AlarmData> mockAlarms = const [
    AlarmData(
      id: '1',
      time: '11:15',
      date: '오늘',
      status: AlarmStatus.active,
      initialCountdown: Duration(minutes: 15),
    ),
    AlarmData(
      id: '2',
      time: '09:15',
      date: '오늘',
      status: AlarmStatus.respondedYes,
    ),
    AlarmData(
      id: '3',
      time: '17:15',
      date: '어제',
      status: AlarmStatus.timedOut,
    ),
    AlarmData(
      id: '4',
      time: '11:15',
      date: '오늘',
      status: AlarmStatus.pending,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('알림 (테스트)', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: mockAlarms.length,
        itemBuilder: (context, index) {
          return AlarmCard(alarm: mockAlarms[index]);
        },
      ),
    );
  }
}

// 개별 알림 카드의 UI와 로직을 담당하는 위젯
class AlarmCard extends StatefulWidget {
  final AlarmData alarm;
  const AlarmCard({super.key, required this.alarm});
  @override
  State<AlarmCard> createState() => _AlarmCardState();
}

class _AlarmCardState extends State<AlarmCard> {
  late AlarmStatus _currentStatus;
  Timer? _countdownTimer;
  late Duration _remainingTime;
  late Duration _totalDuration;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.alarm.status;
    if (_currentStatus == AlarmStatus.active) {
      _totalDuration = const Duration(minutes: 20);
      _remainingTime = widget.alarm.initialCountdown ?? _totalDuration;
      startTimer();
    }
  }

  void startTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() {
        if (_remainingTime.inSeconds > 0) {
          _remainingTime = _remainingTime - const Duration(seconds: 1);
        } else {
          timer.cancel();
          _currentStatus = AlarmStatus.timedOut;
        }
      });
    });
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _onRespondYes() {
    _countdownTimer?.cancel();
    setState(() { _currentStatus = AlarmStatus.respondedYes; });
    print("User responded: YES to alarm ${widget.alarm.id}");
  }

  void _onRespondNo() {
    _countdownTimer?.cancel();
    setState(() { _currentStatus = AlarmStatus.respondedNo; });
    print("User responded: NO to alarm ${widget.alarm.id}");
  }

  @override
  Widget build(BuildContext context) {
    final Color cardColor = _currentStatus == AlarmStatus.active ? const Color(0xFFFFF4E0) : Colors.white;
    final Color borderColor = _currentStatus == AlarmStatus.active ? const Color(0xFFFFCC80) : Colors.transparent;

    return Card(
      color: cardColor,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: borderColor, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _currentStatus == AlarmStatus.timedOut ? Icons.warning_amber_rounded : Icons.notifications_none_outlined,
                  color: _currentStatus == AlarmStatus.timedOut ? Colors.red : Colors.grey.shade600,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '랩실에 계신가요?',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                ),
                const Spacer(),
                Text(widget.alarm.time, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Text(widget.alarm.date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 28, top: 12),
              child: _buildStatusSection(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusSection() {
    switch (_currentStatus) {
      case AlarmStatus.active:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _buildResponseButton(icon: Icons.check, color: Colors.green, onPressed: _onRespondYes),
                const SizedBox(width: 12),
                _buildResponseButton(icon: Icons.close, color: Colors.red, onPressed: _onRespondNo),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: _remainingTime.inSeconds / _totalDuration.inSeconds,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFFFFA726),
              minHeight: 6,
              borderRadius: BorderRadius.circular(3),
            ),
            const SizedBox(height: 6),
            Text(
              '${_remainingTime.inMinutes}분 ${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}초 남음',
              style: const TextStyle(color: Color(0xFFE65100), fontWeight: FontWeight.bold),
            ),
          ],
        );
      case AlarmStatus.respondedYes:
        return const Text(
          '✓ 응답함: 랩실에 있음',
          style: TextStyle(color: Color(0xFF2E7D32), fontWeight: FontWeight.bold, fontSize: 15),
        );
      case AlarmStatus.respondedNo:
        return Text(
          '✓ 응답함: 랩실에 없음',
          style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold, fontSize: 15),
        );
      case AlarmStatus.timedOut:
        return const Text(
          '! 자동 퇴실 처리됨 (무응답)',
          style: TextStyle(color: Color(0xFFC62828), fontWeight: FontWeight.bold, fontSize: 15),
        );
      case AlarmStatus.pending:
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildResponseButton({required IconData icon, required Color color, required VoidCallback onPressed}) {
    return Material(
      color: color.withOpacity(0.1),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        splashColor: color.withOpacity(0.3),
        child: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.5), width: 1.5),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
      ),
    );
  }
}
void main() {
  runApp(
    //내 화면(NotificationView)만 단독으로 실행하는 테스트용 앱
    MaterialApp(
      title: 'Notification View Test',
      home: NotificationView(),
    ),
  );
}