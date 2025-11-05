package com.example.LabAttendance.RollCall.Member;

import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class MemberService
{
    private final MemberRepository memberRepository;

    // 1. id, 학번이 중복인지 아닌지 확인하기
    // 1-1. 중복이면 다시 입력받게 만든다.(즉, 회원가입 하는 화면으로 돌려보냄)
    // 2. 비밀번호 해시 적용
    // 3. 입력받은 데이터를 상자에 담고, 리포지터리로 처리



}
