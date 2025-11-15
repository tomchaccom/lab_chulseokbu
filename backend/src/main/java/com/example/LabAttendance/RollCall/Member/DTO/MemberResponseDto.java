package com.example.LabAttendance.RollCall.Member.DTO;

public record MemberResponseDto(
        Long id,
        Long memberId,
        String nickname,
        String email
){

}