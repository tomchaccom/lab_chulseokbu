import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_model.freezed.dart';
part 'group_model.g.dart';

@freezed
abstract class GroupMemberStatusModel with _$GroupMemberStatusModel {
  const factory GroupMemberStatusModel({
    required int memberId,
    required String nickname,
    required bool isActive,
    required double totalHours,
  }) = _GroupMemberStatusModel;

  factory GroupMemberStatusModel.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberStatusModelFromJson(json);
}