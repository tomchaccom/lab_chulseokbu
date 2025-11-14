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
            // 이메일 불일치, 비밀번호 불일치 오류는 401 반환
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                    .body("이메일 또는 비밀번호가 일치하지 않습니다.");
        }
        catch (Exception e)
        {
            // 500 오류 시, 상세한 오류 정보를 반환하여 디버깅을 돕습니다. (임시 코드)
            e.printStackTrace(); // 서버 콘솔에 스택 트레이스를 출력
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("서버 오류 발생: " + e.getMessage()); // Postman에 오류 메시지 노출
        }

        return ResponseEntity.ok(responseDto);
    }
}