package com.example.LabAttendance.RollCall.Attendance;


import com.example.LabAttendance.RollCall.global.Exception.NotAttendanceTodayException;
import com.example.LabAttendance.RollCall.global.ResponneType.ApiResponse;
import com.example.LabAttendance.RollCall.global.ResponneType.NoDataApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/lab/attendance")
public class AttendanceController {

    private final AttendanceService attendanceService;

    @PostMapping("/in")
    public ResponseEntity<ApiResponse<Long>> checkIn(
            @AuthenticationPrincipal Long memberId)
            {
        attendanceService.checkInLab(memberId);

        return ResponseEntity.status(200)
                .body(ApiResponse.success(attendanceService.checkInLab(memberId),"체크인 되었습니다."));
    }

    @PostMapping("/out")
    public ResponseEntity<NoDataApiResponse> checkOut(
            @AuthenticationPrincipal Long memberId
    ){
        try{
            attendanceService.checkOutLab(memberId);
            return ResponseEntity.status(200)
                    .body(NoDataApiResponse.success("체크아웃 되었습니다"));
        }catch (NotAttendanceTodayException e){
            return ResponseEntity.status(400)
                    .body(NoDataApiResponse.failure("체크인 먼저 진행해주세요"));
        }
    }


}
