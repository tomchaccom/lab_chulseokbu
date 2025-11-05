package com.example.LabAttendance.RollCall.Attendance;

import com.example.LabAttendance.RollCall.Member.Member;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalTime;

@Entity
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class Attendance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    private LocalDate date; // 얘는 생성 시점에 결정, 그날의 날짜이기 때문

    private LocalTime startTime; // 얘는 객체를 생성, 호출하는 시점에 할당

    private Long total; // 객체 생성 시점에 0으로 할당.

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name ="member_id")
    private Member member;


}
