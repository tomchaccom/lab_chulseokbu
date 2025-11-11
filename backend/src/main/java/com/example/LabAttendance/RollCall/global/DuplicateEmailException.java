package com.example.LabAttendance.RollCall.global;

public class DuplicateEmailException extends RuntimeException
{
    public DuplicateEmailException(String message) {
        super(message);
    }
}