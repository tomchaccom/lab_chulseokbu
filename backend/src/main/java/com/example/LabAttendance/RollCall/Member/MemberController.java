package com.example.LabAttendance.RollCall.Member;

import com.example.LabAttendance.RollCall.Member.DTO.MemberSignupRequestDto;

import lombok.RequiredArgsConstructor;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.http.ResponseEntity;
import org.springframework.http.HttpStatus;
import jakarta.validation.Valid;
import com.example.LabAttendance.RollCall.Member.DTO.*;
import com.example.LabAttendance.RollCall.global.*;
import org.springframework.security.authentication.BadCredentialsException;

@RestController
@RequiredArgsConstructor
@RequestMapping("/lab/users")
public class MemberController
{
    private final MemberService memberService;

    @PostMapping("/sign")
    public ResponseEntity<?> signup(@Valid @RequestBody MemberSignupRequestDto requestDto,
                                    BindingResult bindingResult)
    {

        if (bindingResult.hasErrors())
        {
            return ResponseEntity.badRequest().body(bindingResult.getFieldErrors());
        }

        MemberResponseDto responseDto;

        try
        {
            responseDto = memberService.create(requestDto);
        }
        catch (DuplicateEmailException e)
        {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }

        return ResponseEntity.status(HttpStatus.CREATED).body(responseDto);
    }


    @PostMapping("/login")
    public ResponseEntity<?> login
            (@Valid @RequestBody LoginRequestDto loginRequestDto,
             BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            return ResponseEntity.badRequest().body(bindingResult.getFieldErrors());
        }

        LoginResponseDto responseDto;

        try
        {
            responseDto = memberService.login(loginRequestDto);

        }
        catch (MemberNotFoundException | BadCredentialsException e)
        {
            // 이메일 불일치, 비밀번호 불일치 모두 401 Unauthorized 및 동일 메시지 반환
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("이메일 또는 비밀번호가 일치하지 않습니다.");
        }
        catch (Exception e)
        {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("로그인 처리 중 서버 오류가 발생했습니다.");
        }

        return ResponseEntity.ok(responseDto);
    }
}