package com.example.LabAttendance.RollCall.InOut;

import com.example.LabAttendance.RollCall.Attendance.Attendance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InOutRepository extends JpaRepository<InOut, Long> {

}
