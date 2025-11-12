package com.example.LabAttendance.RollCall.Member;

import com.example.LabAttendance.RollCall.Member.DTO.LoginRequestDto;
import com.example.LabAttendance.RollCall.Member.DTO.LoginResponseDto;
import com.example.LabAttendance.RollCall.Member.DTO.MemberResponseDto;
import com.example.LabAttendance.RollCall.Member.DTO.MemberSignupRequestDto;
import com.example.LabAttendance.RollCall.global.DuplicateEmailException;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.authentication.BadCredentialsException;
import com.example.LabAttendance.RollCall.global.MemberNotFoundException;

@RequiredArgsConstructor
@Service
@Transactional

public class MemberService
{
    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;

    public MemberResponseDto create(MemberSignupRequestDto requestDto)
    {

        if (memberRepository.existsByEmail(requestDto.email())) {
            throw new DuplicateEmailException("이미 존재하는 이메일입니다: " + requestDto.email());
        }

        String rawPassword = requestDto.password();
        String hashedPassword = passwordEncoder.encode(rawPassword);


        Member member = Member.builder()
                .memberId(requestDto.memberId())
                .nickname(requestDto.nickname())
                .password(hashedPassword)
                .email(requestDto.email())
                .phone(requestDto.phone())
                .gender(requestDto.gender())
                .build();

        memberRepository.save(member);

        return new MemberResponseDto(
                member.getId(),     // Long 타입 ID
                member.getMemberId(),
                member.getNickname(),
                member.getEmail()
        );
    }

    public LoginResponseDto login(LoginRequestDto requestDto)
    {

        Member member = memberRepository.findByEmail(requestDto.email())
                .orElseThrow(() -> new MemberNotFoundException("가입되지 않은 이메일입니다."));


        if (!passwordEncoder.matches(requestDto.password(), member.getPassword())) {
            throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
        }

        String generatedToken = "temp-jwt-token-for-user-" + member.getId();

        return new LoginResponseDto(
                // 인증 토큰 관련 필드 (임시 값)
                generatedToken,    // accessToken
                "Bearer",          // tokenType

                // 사용자 정보 필드
                member.getId(),
                member.getNickname(),
                member.getPhone(),
                member.getEmail()
        );
    }


}