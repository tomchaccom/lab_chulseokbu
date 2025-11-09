package com.example.LabAttendance.RollCall.Member;

import com.example.LabAttendance.RollCall.Member.DTO.MemberResponseDto;
import com.example.LabAttendance.RollCall.Member.DTO.MemberSignupRequestDto;
import org.springframework.stereotype.Service;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.annotation.Transactional;

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

}