package com.example.LabAttendance.RollCall.global.Exception;
// RuntimeException을 상속받아 정의합니다.
public class MemberNotFoundException extends RuntimeException {

    public MemberNotFoundException(String message) {
        super(message);
    }
}