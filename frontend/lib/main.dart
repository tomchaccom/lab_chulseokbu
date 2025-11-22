// lib/main_test_notification.dart
// (이 파일은 테스트용입니다. 나중에 삭제해도 됩니다.)

import 'package:flutter/material.dart';
import 'notification_view.dart'; // 학생분이 만든 알림 화면 import

// 이 파일에는 'main' 함수가 있습니다!
void main() {
  // 다른 건 다 필요 없고, 오직 'NotificationView' 화면만 띄우는 앱
  runApp(const TestMyApp());
}

class TestMyApp extends StatelessWidget {
  const TestMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 우리가 테스트하려는 화면을 home으로 설정
      home: const NotificationView(),
    );
  }
}