import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 클립보드 사용

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '랩실 출석부 데모',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MeetingTab(),
    );
  }
}

// 데이터 모델
class MeetingModel {
  final String title;
  final String code;
  final String date;
  final List<String> members; // 참여자 리스트

  MeetingModel({
    required this.title,
    required this.code,
    required this.date,
    required this.members,
  });

  int get memberCount => members.length; // 실제 참여자 수
}

const Color primaryColor = Color(0xFFFA6600);

class MeetingTab extends StatefulWidget {
  const MeetingTab({super.key});

  @override
  State<MeetingTab> createState() => _MeetingTabState();
}

class _MeetingTabState extends State<MeetingTab> {
  // 초기 데이터: AI 연구실 10명, 데이터과학 8명
  final List<MeetingModel> _myMeetings = [
    MeetingModel(
      title: "AI 연구실",
      code: "ABC1234",
      date: "2024-01-15",
      members: ["김", "이", "박", "최", "정", "강", "조", "윤", "장", "임"],
    ),
    MeetingModel(
      title: "데이터과학 스터디",
      code: "XYZ789",
      date: "2024-02-01",
      members: ["김", "이", "박", "최", "정", "강", "조", "윤"],
    ),
  ];

  final TextEditingController _createNameController = TextEditingController();
  final TextEditingController _joinCodeController = TextEditingController();
  final FocusNode _createFocusNode = FocusNode();

  @override
  void dispose() {
    _createNameController.dispose();
    _joinCodeController.dispose();
    _createFocusNode.dispose();
    super.dispose();
  }

  // 랜덤 코드 생성 함수
  String _generateRandomCode([int length = 6]) {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  // 모임 참여 다이얼로그
  void _showJoinDialog() {
    _joinCodeController.clear();
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(24),
            width: 340,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("모임 참여", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.grey),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("모임 코드 입력", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(height: 8),
                TextField(
                  controller: _joinCodeController,
                  decoration: InputDecoration(
                    hintText: "XXXXXX",
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("취소"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          String enteredCode = _joinCodeController.text.trim();

                          final existingIndex = _myMeetings.indexWhere((m) => m.code == enteredCode);

                          if (existingIndex != -1) {
                            setState(() {
                              if (!_myMeetings[existingIndex].members.contains("김")) {
                                _myMeetings[existingIndex].members.add("김");
                              }
                            });

                            MeetingModel targetMeeting = _myMeetings[existingIndex];
                            Navigator.pop(context);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeetingDetailScreen(meeting: targetMeeting),
                              ),
                            );
                          } else {
                            String newCode = enteredCode.isNotEmpty ? enteredCode : _generateRandomCode();
                            MeetingModel newMeeting = MeetingModel(
                              title: "새 모임",
                              code: newCode,
                              members: ["김"],
                              date: "2025-11-30",
                            );

                            setState(() {
                              _myMeetings.add(newMeeting);
                            });

                            Navigator.pop(context);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("새 모임이 생성되었습니다. 코드: $newCode")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text("참여하기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  // 모임 생성 다이얼로그 (한국어 입력 가능)
  void _showCreateDialog() {
    _createNameController.clear();
    String newCode = _generateRandomCode();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateSB) {
            // 포커스 요청
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _createFocusNode.requestFocus();
            });

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(24),
                width: 340,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("모임 생성", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Text("모임 이름", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _createNameController,
                      focusNode: _createFocusNode,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      enableSuggestions: true,
                      autocorrect: true,
                      decoration: InputDecoration(
                        hintText: "예: AI 연구실",
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("모임 코드", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: newCode));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("모임 코드가 복사되었습니다!"), duration: Duration(seconds: 1)),
                        );
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF4E6),
                          border: Border.all(color: primaryColor.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              newCode,
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
                            ),
                            const SizedBox(width: 10),
                            Icon(Icons.copy, size: 20, color: Colors.grey[600])
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        "상자를 터치하여 코드를 복사하세요",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[200],
                              foregroundColor: Colors.black,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("취소"),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              if (_createNameController.text.isNotEmpty) {
                                setState(() {
                                  _myMeetings.add(MeetingModel(
                                    title: _createNameController.text,
                                    code: newCode,
                                    members: ["김"],
                                    date: "2025-11-30",
                                  ));
                                });
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("모임 이름을 입력해주세요.")),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: const Text("생성하기", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("랩실 출석부", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: primaryColor,
              child: const Text("김", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("내 모임", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("참여 중인 모임을 관리하세요", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.login,
                    label: "모임 참여",
                    isPrimary: false,
                    onTap: _showJoinDialog,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.add,
                    label: "모임 생성",
                    isPrimary: true,
                    onTap: _showCreateDialog,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _myMeetings.length,
              itemBuilder: (context, index) {
                final meeting = _myMeetings[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildMeetingCard(meeting),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required bool isPrimary, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: isPrimary ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isPrimary ? null : Border.all(color: Colors.grey[300]!, width: 1),
          boxShadow: [
            if (isPrimary) BoxShadow(color: primaryColor.withOpacity(0.3), blurRadius: 8, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: isPrimary ? Colors.white : primaryColor),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isPrimary ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeetingCard(MeetingModel meeting) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MeetingDetailScreen(meeting: meeting),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(meeting.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(meeting.code, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.people, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text("${meeting.memberCount}명", style: const TextStyle(color: Colors.grey)),
                const SizedBox(width: 16),
                Text("생성일: ${meeting.date}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 상세 화면
class MeetingDetailScreen extends StatelessWidget {
  final MeetingModel meeting;

  const MeetingDetailScreen({super.key, required this.meeting});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("랩실 출석부", style: TextStyle(color: Colors.black, fontSize: 16)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: primaryColor,
              child: Text("김", style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, size: 16, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("모임 목록으로", style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(meeting.title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const Text("구성원 출석 현황", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("랩실 구성원 출석 현황", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.list, color: Colors.black),
                )
              ],
            ),
            const SizedBox(height: 16),
            ...meeting.members.map((member) => _buildMemberTile(member[0], member, "학생", true)),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberTile(String avatar, String name, String position, bool isPresent) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          CircleAvatar(backgroundColor: primaryColor, child: Text(avatar, style: const TextStyle(color: Colors.white))),
          const SizedBox(width: 12),
          Expanded(child: Text("$name ($position)", style: const TextStyle(fontSize: 14))),
          Icon(Icons.circle, size: 12, color: isPresent ? Colors.green : Colors.red)
        ],
      ),
    );
  }
}
