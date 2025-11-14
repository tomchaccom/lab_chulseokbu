package com.example.LabAttendance.RollCall.Member;

import com.example.LabAttendance.RollCall.Member.DTO.*;
import com.example.LabAttendance.RollCall.global.*;
import com.example.LabAttendance.RollCall.global.jwt.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.stereotype.Service;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

@RequiredArgsConstructor
@Service
@Transactional
public class MemberService {

    private final MemberRepository memberRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;

    public MemberResponseDto create(MemberSignupRequestDto requestDto) {

        if (memberRepository.existsByEmail(requestDto.email())) {
            throw new DuplicateEmailException("이미 존재하는 이메일입니다: " + requestDto.email());
        }

        String hashedPassword = passwordEncoder.encode(requestDto.password());

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
                member.getId(),
                member.getMemberId(),
                member.getNickname(),
                member.getEmail()
        );
    }

    public LoginResponseDto login(LoginRequestDto requestDto) {

        Member member = memberRepository.findByEmail(requestDto.email())
                .orElseThrow(() -> new MemberNotFoundException("가입되지 않은 이메일입니다."));

        if (!passwordEncoder.matches(requestDto.password(), member.getPassword())) {
            throw new BadCredentialsException("비밀번호가 일치하지 않습니다.");
        }


        String jwtToken = jwtTokenProvider.generateToken(member.getId(), member.getEmail());

        return new LoginResponseDto(
                jwtToken,    // accessToken
                member.getId(),
                member.getNickname(),
                member.getPhone(),
                member.getEmail()
        );
    }
}
