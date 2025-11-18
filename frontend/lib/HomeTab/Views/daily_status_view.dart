import 'package:flutter/material.dart';
// 1. 출석 기록을 위한 간단한 데이터 모델
class AttendanceRecord {
  final String date;
  final String status;
  final String checkIn;
  final String checkOut;
//record
  AttendanceRecord({
    required this.date,
    required this.status,
    required this.checkIn,
    required this.checkOut,
  });
}

// 2. 이 파일의 메인 위젯 (StatefulWidget)
class DailyStatusView extends StatefulWidget {
  const DailyStatusView({super.key});

  @override
  State<DailyStatusView> createState() => _DailyStatusViewState();
}

class _DailyStatusViewState extends State<DailyStatusView> {
  // 3. 탭 버튼의 상태를 관리할 변수
  bool _isListView = true; // 기본값은 리스트 뷰

  // 30일치 더미 데이터 생성 함수
  List<AttendanceRecord> _generateDummyData(int count) {
    return List.generate(count, (index) {
      final day = 30 - index;
      return AttendanceRecord(
        date: '8월 $day일 (${['월', '화', '수', '목', '금', '토', '일'][index % 7]})',
        status: (index % 10 == 0) ? '결석' : '출석',
        checkIn: (index % 10 == 0) ? '' : '9:${index + 10}', // 결석 시 데이터 비워둠
        checkOut: (index % 10 == 0) ? '' : '18:${index + 20}', // 결석 시 데이터 비워둠
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // 4. AppBar, BottomNav 제거. SafeArea 추가
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Scaffold 배경색
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 5. 요청한 새 헤더 (제목 + 탭 버튼)
              _buildHeader(),
              const SizedBox(height: 16),

              // 6. 이미지에 있던 빈 사각형 플레이스홀더
              _buildFilterPlaceholder(),
              const SizedBox(height: 16),

              // 7. 스크롤 가능한 리스트 영역
              Expanded(
                child: ListView(
                  children: [
                    MemberAttendanceCard(
                      name: '김학생',
                      role: '박사과정',
                      percentage: '85 %',
                      initial: '김',
                      color: Colors.orange, // 연주황색
                      allRecords: _generateDummyData(30),
                    ),
                    const SizedBox(height: 12),
                    MemberAttendanceCard(
                      name: '이연구',
                      role: '석사과정',
                      percentage: '92 %',
                      initial: '이',
                      color: Colors.orange, // 연주황색
                      allRecords: _generateDummyData(30),
                    ),
                    const SizedBox(height: 12),
                    MemberAttendanceCard(
                      name: '박조교',
                      role: '연구원',
                      percentage: '78 %',
                      initial: '박',
                      color: Colors.orange, // 연주황색
                      allRecords: _generateDummyData(30),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 위젯 빌드 헬퍼 함수 ---

  // 8. 헤더 위젯 (제목 + 탭 버튼)
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          '랩실 구성원 출석 현황',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        _buildToggleButtons(), // 탭 버튼
      ],
    );
  }

  // 9. 탭 버튼 위젯
  Widget _buildToggleButtons() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFECECEC), // 탭 버튼 배경색
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildToggleButton(Icons.grid_view_rounded, !_isListView),
          _buildToggleButton(Icons.format_list_bulleted_rounded, _isListView),
        ],
      ),
    );
  }

  // 10. 개별 탭 버튼
  Widget _buildToggleButton(IconData icon, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          // 아이콘에 따라 _isListView 상태 변경
          _isListView = (icon == Icons.format_list_bulleted_rounded);
          // (참고: 실제 그리드뷰/리스트뷰 전환 로직은 여기에 추가해야 함)
        });
      },
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent, // 선택 시 흰색
          borderRadius: BorderRadius.circular(6),
          boxShadow: isSelected
              ? [ // 선택 시 그림자 효과
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            )
          ]
              : [],
        ),
        child: Icon(
          icon,
          color: isSelected ? Colors.black87 : Colors.grey[600],
          size: 20,
        ),
      ),
    );
  }

  // 11. 이미지에 있던 빈 사각형
  Widget _buildFilterPlaceholder() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFF0F0F0)), // 매우 옅은 테두리
      ),
    );
  }
}

// -----------------------------------------------------------------
// 12. 멤버 카드 위젯
// -----------------------------------------------------------------
class MemberAttendanceCard extends StatefulWidget {
  final String name;
  final String role;
  final String percentage;
  final String initial;
  final Color color;
  final List<AttendanceRecord> allRecords;

  const MemberAttendanceCard({
    super.key,
    required this.name,
    required this.role,
    required this.percentage,
    required this.initial,
    required this.color,
    required this.allRecords,
  });

  @override
  State<MemberAttendanceCard> createState() => _MemberAttendanceCardState();
}

class _MemberAttendanceCardState extends State<MemberAttendanceCard> {
  bool _isSeeMoreClicked = false;
  late List<AttendanceRecord> _recentRecords;

  @override
  void initState() {
    super.initState();
    _recentRecords = widget.allRecords.take(7).toList();
  }

  @override
  Widget build(BuildContext context) {
    final recordsToShow = _isSeeMoreClicked ? widget.allRecords : _recentRecords;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        // --- ⬇️ 요청하신 수정 사항 적용 ⬇️ ---
        onExpansionChanged: (bool isExpanding) {
          // 타일이 닫힐 때 (isExpanding이 false가 될 때)
          if (!isExpanding) {
            // '더 보기' 상태를 초기화(false)시켜 '간략히 보기'로 되돌립니다.
            setState(() {
              _isSeeMoreClicked = false;
            });
          }
        },
        // --- ⬆️ 여기까지 ⬆️ ---
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: widget.color.withOpacity(0.2),
              child: Text(
                widget.initial,
                style: TextStyle(color: widget.color, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(widget.role, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const Spacer(),
            Text(
              widget.percentage,
              style: TextStyle(
                color: widget.color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: const Icon(Icons.keyboard_arrow_down),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          _buildHeaderRow(),
          const Divider(),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: recordsToShow.length,
            itemBuilder: (context, index) {
              return _buildAttendanceRow(recordsToShow[index]);
            },
            separatorBuilder: (context, index) => const SizedBox(height: 8),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {
              setState(() {
                _isSeeMoreClicked = !_isSeeMoreClicked;
              });
            },
            child: Text(
              _isSeeMoreClicked
                  ? '간략히 보기'
                  : '더 보기 (총 ${widget.allRecords.length}일)',
              style: const TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    const style = TextStyle(color: Colors.grey, fontSize: 12);
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 3, child: Text('날짜', style: style)),
          Expanded(flex: 2, child: Text('출석 여부', style: style, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text('체크인', style: style, textAlign: TextAlign.center)),
          Expanded(flex: 2, child: Text('체크아웃', style: style, textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  // '결석'일 경우 '-' 표시
  Widget _buildAttendanceRow(AttendanceRecord record) {
    bool isPresent = record.status == '출석';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(record.date, style: const TextStyle(fontSize: 13)),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isPresent ? Colors.green.shade50 : Colors.red.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  record.status,
                  style: TextStyle(
                    color: isPresent ? Colors.green.shade700 : Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              isPresent ? record.checkIn : '-', // 출석일 때만 시간 표시
              textAlign: TextAlign.center,
              style: TextStyle(color: isPresent ? Colors.black87 : Colors.grey),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              isPresent ? record.checkOut : '-', // 출석일 때만 시간 표시
              textAlign: TextAlign.center,
              style: TextStyle(color: isPresent ? Colors.black87 : Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}