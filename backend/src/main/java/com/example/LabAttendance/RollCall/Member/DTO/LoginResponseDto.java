package com.example.LabAttendance.RollCall.Member.DTO;

public record LoginResponseDto(
        // 인증 토큰
        String accessToken,
        String tokenType,

        Long memberId,
        String username,
        String phone,
        String email


){

}