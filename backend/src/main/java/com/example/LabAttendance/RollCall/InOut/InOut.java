package com.example.LabAttendance.RollCall.InOut;

import com.example.LabAttendance.RollCall.Attendance.Attendance;
import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalTime;

@Entity
@Getter
public class InOut {

    @Id
    @ManyToOne()
    @JoinColumn(name ="attendance_id")
    private Attendance attendance;

    @Column(name="start")
    private LocalTime startTime;

    @Column(name="end")
    private LocalTime endTime;

}
