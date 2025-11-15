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


        Member member = new Member(
                null, // id (DB에서 자동 생성되므로 null 전달)
                requestDto.memberId(),
                requestDto.nickname(),
                hashedPassword,
                requestDto.email(),
                requestDto.phone(),
                requestDto.gender(),
                null // attandenceList (생성 시에는 null 또는 new ArrayList() 전달)
        );

        memberRepository.save(member);

        // 생성자 호출 후 ID가 자동 생성되어 member 객체에 반영됨
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