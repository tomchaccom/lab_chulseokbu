package com.example.LabAttendance.RollCall.global.Exception;


public class NotAttendanceTodayException extends RuntimeException {
    public NotAttendanceTodayException(String message) {
        super(message);
    }
}
