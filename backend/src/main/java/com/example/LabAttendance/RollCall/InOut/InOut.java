package com.example.LabAttendance.RollCall.InOut;

import com.example.LabAttendance.RollCall.Attendance.Attendance;
import jakarta.persistence.*;
import lombok.Getter;

import java.time.LocalTime;

@Entity
@Getter
public class InOut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne()
    @JoinColumn(name ="attendance_id")
    private Attendance attendance;

    @Column(nullable = false)
    private LocalTime startTime;

    @Column(nullable = false)
    private LocalTime endTime;

}
