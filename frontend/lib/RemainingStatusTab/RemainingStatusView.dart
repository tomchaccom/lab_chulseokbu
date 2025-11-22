import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: LabStatusPage(),
    debugShowCheckedModeBanner: false,
  ));
}

// 1. 데이터 모델 (학생 정보)
class Student {
  final String name;
  final String role; // 박사과정, 석사과정 등
  final String status; // 작업 중, 휴식 중, 회의 중, 퇴실
  final String timeInfo; // 체크인 시간 또는 마지막 퇴실 시간
  final String duration; // 체류 시간 (퇴실 시 빈 문자열)
  final bool isPresent; // 현재 랩실에 있는지 여부

  Student({
    required this.name,
    required this.role,
    required this.status,
    required this.timeInfo,
    required this.duration,
    required this.isPresent,
  });
}

class LabStatusPage extends StatefulWidget {
  const LabStatusPage({super.key});

  @override
  State<LabStatusPage> createState() => _LabStatusPageState();
}

class _LabStatusPageState extends State<LabStatusPage> {
  // 2. 데이터 리스트 (총 10명) - 반복문을 돌리기 위한 데이터 소스
  final List<Student> studentList = [
    Student(name: '김학생', role: '박사과정', status: '작업 중', timeInfo: '09:15', duration: '3시간 45분', isPresent: true),
    Student(name: '이연구', role: '석사과정', status: '휴식 중', timeInfo: '08:30', duration: '4시간 30분', isPresent: true),
    Student(name: '박조교', role: '연구원', status: '', timeInfo: '어제 18:30', duration: '', isPresent: false), // 퇴실
    Student(name: '정박사', role: '박사과정', status: '회의 중', timeInfo: '10:05', duration: '2시간 55분', isPresent: true),
    Student(name: '최석사', role: '석사과정', status: '', timeInfo: '오늘 11:20', duration: '', isPresent: false), // 퇴실
    // ... 아래는 반복 패턴을 보여주기 위한 더미 데이터 (총 10명을 채움)
    Student(name: '강학부', role: '학부연구생', status: '작업 중', timeInfo: '13:00', duration: '0시간 10분', isPresent: true),
    Student(name: '조선배', role: '석사과정', status: '작업 중', timeInfo: '09:00', duration: '4시간 00분', isPresent: true),
    Student(name: '임후배', role: '학부연구생', status: '휴식 중', timeInfo: '10:30', duration: '2시간 30분', isPresent: true),
    Student(name: '한교수', role: '교수', status: '회의 중', timeInfo: '09:00', duration: '4시간 00분', isPresent: true),
    Student(name: '송조교', role: '행정조교', status: '', timeInfo: '오늘 12:00', duration: '', isPresent: false),
  ];

  @override
  Widget build(BuildContext context) {
    // 현재 출석 인원 계산
    int presentCount = studentList.where((s) => s.isPresent).length;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      // 상단 앱바
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('출석부', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        leading: const Icon(Icons.menu_book, color: Colors.orange),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: [
                const Text('김학생', style: TextStyle(color: Colors.grey, fontSize: 14)),
                const SizedBox(width: 8),
                CircleAvatar(backgroundColor: Colors.orange, radius: 16, child: const Text('김', style: TextStyle(color: Colors.white, fontSize: 12))),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // 1. 상단 헤더 (랩실 잔류 현황)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('랩실 잔류 현황', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.orange[100], borderRadius: BorderRadius.circular(20)),
                  child: Text('$presentCount/${studentList.length} 명 출석', style: TextStyle(color: Colors.orange[800], fontWeight: FontWeight.bold, fontSize: 12)),
                )
              ],
            ),
          ),

          // 2. 공지 배너 (현재 시간 기준...)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(12)), // 연한 주황 배경
            child: Row(
              children: [
                const Icon(Icons.access_time, color: Colors.orange),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('현재 시간 13:00 기준', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('실시간 랩실 인원 현황입니다', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 10),

          // 3. 학생 리스트 (여기가 핵심! 반복문 사용)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              itemCount: studentList.length, // 리스트 길이만큼 반복 (10명)
              itemBuilder: (context, index) {
                return _buildStudentCard(studentList[index]);
              },
            ),
          ),
        ],
      ),

      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // 잔류현황 탭 활성화
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: '구성원'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: '잔류현황'),
        ],
      ),
    );
  }

  // 학생 카드 위젯 (디자인 로직)
  Widget _buildStudentCard(Student student) {
    // 상태에 따른 색상 및 아이콘 설정
    Color borderColor = student.isPresent ? Colors.green.withOpacity(0.3) : Colors.grey.withOpacity(0.2);
    Color avatarColor = student.isPresent ? Colors.orange[100]! : Colors.grey[200]!;
    Color nameColor = student.isPresent ? Colors.black : Colors.grey;

    // 상태 배지 색상 (작업중: 파랑, 휴식중: 주황, 회의중: 보라)
    Color statusColor = Colors.blue;
    IconData statusIcon = Icons.person;
    if (student.status == '휴식 중') {
      statusColor = Colors.orange;
      statusIcon = Icons.coffee;
    } else if (student.status == '회의 중') {
      statusColor = Colors.purple;
      statusIcon = Icons.people;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          // 1. 프로필 아바타
          Stack(
            children: [
              Container(
                width: 50, height: 50,
                decoration: BoxDecoration(color: avatarColor, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Text(student.name[0], style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: student.isPresent ? Colors.orange : Colors.grey)),
              ),
              if (student.isPresent)
                Positioned(bottom: 0, right: 0, child: const CircleAvatar(backgroundColor: Colors.white, radius: 8, child: Icon(Icons.check_circle, color: Colors.green, size: 16))),
              if (!student.isPresent)
                Positioned(bottom: 0, right: 0, child: const CircleAvatar(backgroundColor: Colors.white, radius: 8, child: Icon(Icons.cancel, color: Colors.grey, size: 16))),
            ],
          ),
          const SizedBox(width: 16),

          // 2. 이름 및 체크인 정보
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(student.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: nameColor)),
                    const SizedBox(width: 6),
                    Text(student.role, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(student.isPresent ? '체크인: ${student.timeInfo}' : '마지막 퇴실: ${student.timeInfo}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),

          // 3. 우측 상태 배지 및 체류 시간
          if (student.isPresent)
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(statusIcon, size: 12, color: statusColor),
                      const SizedBox(width: 4),
                      Text(student.status, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text('체류 시간: ', style: TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                    Text(student.duration, style: const TextStyle(fontSize: 11, color: Colors.green, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            )
        ],
      ),
    );
  }
}