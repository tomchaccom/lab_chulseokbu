package com.example.LabAttendance.RollCall.Member;

import com.example.LabAttendance.RollCall.Attendance.Attendance;
import com.example.LabAttendance.RollCall.global.Gender;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Member {

    @Id // 고유 식별 ID
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long memberId; // 학번

    @Column(nullable = false)   // 이름 또는 별명
    private String nickname;

    @Column(nullable = false)   // 비밀 번호
    private String password;

    @Column(nullable = false, unique = true)    //unique : 무조건 데이터가 달라야함.
    private String email;

    @Column(nullable = false)
    private String phone;

    @Column(nullable = false)
    private Gender gender;

    // orphanRemoval = true : 자식 객체 자동 제거
    // cascade = CascadeType.ALL : member를 삭제하면 Attendance도 자동 삭제
    // mappedBy = "member" : 이쪽(Member)은 읽기 전용이고,
    // 반대쪽(Attendance의 member 필드)이 실제 DB 연결을 관리한다
    @OneToMany(mappedBy = "member", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Attendance> attandenceList = new ArrayList<>();
}