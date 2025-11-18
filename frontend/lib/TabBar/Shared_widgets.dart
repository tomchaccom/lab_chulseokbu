import 'package:flutter/material.dart';

// ⭐ BottomNavigationBar 위젯을 별도의 StatelessWidget으로 분리
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int)? onItemSelected; // 탭 전환 로직을 받기 위한 함수

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
      // 선택 이벤트 핸들러 추가 (탭 전환 로직이 있다면 사용)
      onTap: onItemSelected,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
        BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: '구성원'),
        BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: '잔류현황'),
      ],
      currentIndex: currentIndex,
    );
  }
}