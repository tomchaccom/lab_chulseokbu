package com.example.LabAttendance.RollCall.Member;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController // Http 처리 요청
@RequiredArgsConstructor
public class MemberController
{
    private final MemberService memberService;

    //매핑 하기


}
