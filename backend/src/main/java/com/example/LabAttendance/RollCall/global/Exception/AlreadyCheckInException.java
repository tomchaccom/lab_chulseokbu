package com.example.LabAttendance.RollCall.global.Exception;

public class AlreadyCheckInException extends RuntimeException {
    public AlreadyCheckInException(String message) {
        super(message);
    }
}
