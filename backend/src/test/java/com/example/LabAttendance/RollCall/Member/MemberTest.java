package com.example.LabAttendance.RollCall.Member;

import com.example.LabAttendance.RollCall.global.Gender;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class MemberTest {

    @Autowired
    private MemberRepository memberRepository;

    @Test
    void deleteAllAndInsertNewMembers() {
        // 1️⃣ 기존 데이터 삭제
        memberRepository.deleteAll();
        System.out.println("모든 Member 삭제 완료!");

        // 2️⃣ 새로운 Member 데이터 추가
        Member m1 = Member.builder()
                .memberId(2025001L)
                .nickname("홍길동")
                .password("password1")
                .email("member1@example.com")
                .phone("010-1111-1111")
                .gender(Gender.MALE)
                .build();
        memberRepository.save(m1);
        System.out.println("저장 확인: 학번=" + m1.getMemberId() + ", 닉네임=" + m1.getNickname() + ", 이메일=" + m1.getEmail());

        Member m2 = Member.builder()
                .memberId(2025002L)
                .nickname("김철수")
                .password("password2")
                .email("member2@example.com")
                .phone("010-2222-2222")
                .gender(Gender.MALE)
                .build();
        memberRepository.save(m2);
        System.out.println("저장 확인: 학번=" + m2.getMemberId() + ", 닉네임=" + m2.getNickname() + ", 이메일=" + m2.getEmail());
    }
}
