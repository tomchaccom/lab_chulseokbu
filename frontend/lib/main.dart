import 'package:flutter/material.dart';
import 'package:frontend/HomeTab/Views/InOutStateView.dart';
import 'package:frontend/MemberTab/MemberStateView.dart';
import 'package:frontend/TabBar/Shared_widgets.dart';

void main() {
  runApp(const MyApp());
}

const BGC = Color(0xFFFFFFFF);

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '랩실 출석부',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: BGC),
      ),
      home: const MyHomePage(title: '랩실 출석부'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ⭐ 1. 현재 선택된 탭의 인덱스를 상태로 관리합니다. (홈: 0, 구성원: 1, 잔류현황: 2)
  int _selectedIndex = 0;

  // ⭐ 2. 탭에 따라 body에 표시할 위젯 목록을 정의합니다.
  static final List<Widget> _widgetOptions = <Widget>[
    // [0] 홈 화면 (기존 MyHomePage의 body 내용)
    ListView(
      children: const <Widget>[
        // LabStatusCard는 이 파일 또는 다른 파일에 정의되어 있어야 합니다.
        LabStatusCard(),
      ],
    ),

    // [1] 구성원 화면 (MemberStateView.dart의 내용물)
    // AttendanceViewScreenContent는 Scaffold, AppBar, BottomBar가 없는 순수 내용물입니다.
    const AttendanceViewScreenContent(),

    // [2] 잔류현황 화면 (임시 위젯)
    const Center(
      child: Text(
        '잔류현황 화면 내용',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ),
  ];

  // ⭐ 3. BottomNavigationBar 탭 클릭 시 인덱스 업데이트 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // 이전의 _navigateToMemberStateView 함수는 이제 필요 없습니다.

  @override
  Widget build(BuildContext context) {
    // 현재 선택된 인덱스에 따라 AppBar의 타이틀을 변경할 수 있습니다.
    String currentTitle = widget.title;
    if (_selectedIndex == 1) {
      currentTitle = '출석뷰'; // 구성원 탭을 눌렀을 때 타이틀 변경
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: BGC,
        title: Text(currentTitle),
        // 필요하다면 앱바의 Actions(오른쪽 상단)도 여기에 배치할 수 있습니다.
      ),

      // ⭐ 4. body에 현재 선택된 인덱스의 위젯을 표시합니다.
      body: _widgetOptions.elementAt(_selectedIndex),

      // ⭐ 5. BottomNavigationBar를 CustomBottomNavBar로 연결
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex, // 현재 인덱스를 BottomBar에 전달
        onItemSelected: _onItemTapped, // 클릭 이벤트를 _onItemTapped에 연결
      ),
    );
  }
}