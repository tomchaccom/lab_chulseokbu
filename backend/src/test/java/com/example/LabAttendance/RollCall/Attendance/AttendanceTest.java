package com.example.LabAttendance.RollCall.Attendance;


import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;

import java.time.LocalTime;

public class AttendanceTest {

    @Test
    @DisplayName("랩실 잔류 시간 계산 해보기 ")
    public void testAttendance() {
        Attendance attendance = new Attendance();
        attendance.onCreate();

        attendance.startCount();
        System.out.println("attendance.getStartTime() = " + attendance.getStartTime());
        LocalTime endTime = LocalTime.now();

        attendance.calculateAttendance(endTime);

        Assertions.assertEquals(
                attendance.getTotal(),
                java.time.Duration.between(attendance.getStartTime(), endTime)
                        .toMinutes());

    }
}
