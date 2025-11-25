class GroupMemberStatusEntity {
  final String nickname;
  final bool isActive;
  final double totalHours;
  final int memberId;
  GroupMemberStatusEntity({
    required this.nickname,
    required this.isActive,
    required this.totalHours,
    required this.memberId,
  });
}