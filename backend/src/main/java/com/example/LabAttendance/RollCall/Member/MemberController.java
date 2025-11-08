package com.example.LabAttendance.RollCall.Member;

import lombok.RequiredArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;



@RestController
@RequiredArgsConstructor
@RequestMapping("/lab_chulseokbu/user")

public class MemberController
{
    private final MemberService memberService;

    @GetMapping("/signup")
    public String signup(Member member)
    {
        return "signup_form";
    }


    @PostMapping("/signup")
    public ResponseEntity<?> signup(@Validated @RequestBody Member member, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body("입력값이 올바르지 않습니다.");
        }

        try {
            memberService.create(member);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }

        return ResponseEntity.ok("회원가입이 완료되었습니다.");
    }

}