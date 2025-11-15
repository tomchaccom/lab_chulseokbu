package com.example.LabAttendance.RollCall.Attendance;


import com.example.LabAttendance.RollCall.Member.Member;
import com.example.LabAttendance.RollCall.Member.MemberRepository;
import com.example.LabAttendance.RollCall.global.Exception.NotAttendanceTodayException;
import com.example.LabAttendance.RollCall.global.Gender;
import jakarta.persistence.EntityNotFoundException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.springframework.test.util.ReflectionTestUtils;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Optional;

import static org.assertj.core.api.Assertions.*;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class AttendanceServiceTest {

    @InjectMocks
    AttendanceService attendanceService;

    @Mock
    AttendanceRepository attendanceRepository;

    @Mock
    MemberRepository memberRepository;

    Member member;
    Attendance attendance;

    @BeforeEach
    void setUp() {
        member = new Member();
        ReflectionTestUtils.setField(member, "id", 1L);
        ReflectionTestUtils.setField(member, "memberId", 20250001L);
        ReflectionTestUtils.setField(member, "nickname", "Tom");
        ReflectionTestUtils.setField(member, "password", "pass123");
        ReflectionTestUtils.setField(member, "email", "tom@test.com");
        ReflectionTestUtils.setField(member, "phone", "01012345678");
        ReflectionTestUtils.setField(member, "gender", Gender.MALE);

        attendance = mock(Attendance.class);
    }

    @Test
    void checkInLab_shouldCreateOrStartAttendance() {
        // member 존재
        when(memberRepository.findById(1L)).thenReturn(Optional.of(member));
        when(attendanceRepository.findByMemberIdAndDate(member.getId(), LocalDate.now()))
                .thenReturn(Optional.of(attendance));

        attendanceService.checkInLab(1L);

        verify(attendance).startCount();
    }

    @Test
    void checkInLab_shouldCreateNewAttendance_whenMemberNull() {
        when(memberRepository.findById(1L)).thenReturn(Optional.empty());

        attendanceService.checkInLab(1L);

        verify(attendanceRepository).save(any(Attendance.class));
    }

    @Test
    void checkOutLab_shouldCalculateAttendance() throws NotAttendanceTodayException {
        when(memberRepository.findById(1L)).thenReturn(Optional.of(member));
        when(attendanceRepository.findByMemberIdAndDate(member.getId(), LocalDate.now()))
                .thenReturn(Optional.of(attendance));

        attendanceService.checkOutLab(1L);

        verify(attendance).calculateAttendance(any(LocalTime.class));
    }

    @Test
    void checkOutLab_shouldThrow_whenNoAttendanceToday() {
        when(memberRepository.findById(1L)).thenReturn(Optional.of(member));
        when(attendanceRepository.findByMemberIdAndDate(member.getId(), LocalDate.now()))
                .thenReturn(Optional.empty());

        assertThatThrownBy(() -> attendanceService.checkOutLab(1L))
                .isInstanceOf(NotAttendanceTodayException.class)
                .hasMessageContaining("오늘 체크인한 이력이 없습니다. 체크인 부탁드립니다");
    }

    @Test
    void checkOutLab_shouldThrow_whenMemberNotFound() {
        when(memberRepository.findById(1L)).thenReturn(Optional.empty());

        assertThatThrownBy(() -> attendanceService.checkOutLab(1L))
                .isInstanceOf(EntityNotFoundException.class)
                .hasMessageContaining("Member not found");
    }
}
