package com.example.LabAttendance.RollCall.Member;

import com.example.LabAttendance.RollCall.Member.DTO.MemberSignupRequestDto;

import lombok.RequiredArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import jakarta.validation.Valid;
import com.example.LabAttendance.RollCall.Member.DTO.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/lab/users")
public class MemberController
{
    private final MemberService memberService;

    // 1. GET 요청 제거 (API 서버이므로 폼 요청 제거)
    /* @GetMapping("auth/sign/form") ... */


    @PostMapping("/sign") // ⭐ URL 단축
    public ResponseEntity<?> signup(@Valid @RequestBody MemberSignupRequestDto requestDto, BindingResult bindingResult) {

        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getFieldErrors());
        }

        try {
            MemberResponseDto responseDto = memberService.create(requestDto);
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage()); // 409 CONFLICT
        }

        return ResponseEntity.status(HttpStatus.CREATED).body("회원가입이 완료되었습니다.");
    }
}