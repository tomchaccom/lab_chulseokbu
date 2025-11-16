package com.example.LabAttendance.RollCall.Attendance;

import com.example.LabAttendance.RollCall.InOut.InOut;
import com.example.LabAttendance.RollCall.InOut.InOutRepository;
import com.example.LabAttendance.RollCall.Member.Member;
import com.example.LabAttendance.RollCall.Member.MemberRepository;
import com.example.LabAttendance.RollCall.global.Exception.AlreadyCheckInException;
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
    public Long checkInLab(Long memberId) {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(EntityNotFoundException::new);

        Attendance entity = attendanceRepository.findByIdAndDate(memberId, LocalDate.now())
                .orElse(null);

        LocalTime time = LocalTime.now(); // 시작 시간

        if (entity == null) {
            entity = new Attendance();
            entity.onCreate();
            entity.checkInMember(member);
            attendanceRepository.save(entity);

        }else {
            if(entity.getStatus() == AttendanceStatus.IN){
                throw new AlreadyCheckInException("이미 체크인 되었습니다");
            }
            if (entity.getStatus() == AttendanceStatus.OUT) {
                entity.toggleAttendance();
            }
        }

        InOut inOut = new InOut();
        inOut.checkStart(entity,time);

        attendanceRepository.save(entity);
        InOut savedIn = inOutRepository.save(inOut);
        return savedIn.getId();
    }


    public void checkOutLab(long memberId, long inoutId) throws NotAttendanceTodayException {
        Member member = memberRepository.findById(memberId)
                .orElseThrow(() ->new EntityNotFoundException("Member not found"));
        InOut inOut = inOutRepository.findById(inoutId)
                .orElseThrow(() ->new EntityNotFoundException("InOut not found"));

        LocalTime end = LocalTime.now();
        if (inOut.getAttendance().getStatus() != AttendanceStatus.IN){
            throw new NotAttendanceTodayException("오늘 체크인한 이력이 없습니다. 체크인 부탁드립니다");
        }
        inOut.checkEnd(end);

        Attendance entity = attendanceRepository.findByIdAndDate(member.getId(), LocalDate.now())
                .orElse(null);

        if (entity == null) {
            throw new NotAttendanceTodayException("오늘 체크인한 이력이 없습니다. 체크인 부탁드립니다");
        }

        entity.calculateAttendance(end);
        entity.toggleAttendance();
        attendanceRepository.save(entity);
        inOutRepository.save(inOut);
    }

}
