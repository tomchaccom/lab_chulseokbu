package com.example.LabAttendance.RollCall.Attendance;

import com.example.LabAttendance.RollCall.InOut.InOut;
import com.example.LabAttendance.RollCall.InOut.InOutRepository;
import com.example.LabAttendance.RollCall.Member.Member;
import com.example.LabAttendance.RollCall.Member.MemberRepository;
import com.example.LabAttendance.RollCall.global.Exception.NotAttendanceTodayException;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;

@Service
@RequiredArgsConstructor
public class AttendanceService {

    private final AttendanceRepository attendanceRepository;
    private final MemberRepository memberRepository;
    private final InOutRepository inOutRepository;

    // 체크인 로직
    // 내이름으로 만들어진 오늘 날짜의 출석 정보가 존재하면 start 사용 아니면 생성
    public Long checkInLab(long memberId) {
        Member member = memberRepository.findById(memberId).orElse(null);
        Attendance entity;

        LocalTime time = LocalTime.now();

        if (member == null) {
            entity = new Attendance();
            attendanceRepository.save(entity);
        } else {
            entity = attendanceRepository.findByMemberIdAndDate(memberId, LocalDate.now())
                    .orElse(new Attendance());
        }
        InOut inOut = new InOut();
        inOut.checkStart(entity,time);

        entity.startCount(time);
        entity.checkInMember(member);

        attendanceRepository.save(entity);
        InOut savedIn = inOutRepository.save(inOut);
        return savedIn.getId();
    }


    public void checkOutLab(long memberId) throws NotAttendanceTodayException {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() ->new EntityNotFoundException("Member not found"));

        Attendance entity = attendanceRepository.findByMemberIdAndDate(member.getId(), LocalDate.now())
                .orElse(null);

        if (entity == null) {
            throw new NotAttendanceTodayException("오늘 체크인한 이력이 없습니다. 체크인 부탁드립니다");
        }

        entity.calculateAttendance(LocalTime.now());
        attendanceRepository.save(entity);
    }


}
