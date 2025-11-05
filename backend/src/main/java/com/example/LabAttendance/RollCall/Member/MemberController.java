package com.example.LabAttendance.RollCall.Member;


import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class MemberController
{
    private final MemberService memberService;

}
