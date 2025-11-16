package com.example.LabAttendance.RollCall.Attendance;


import com.example.LabAttendance.RollCall.global.Exception.AlreadyCheckInException;
import com.example.LabAttendance.RollCall.global.Exception.NotAttendanceTodayException;
import com.example.LabAttendance.RollCall.global.ResponneType.ApiResponse;
import com.example.LabAttendance.RollCall.global.ResponneType.NoDataApiResponse;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/lab/attendance")
public class AttendanceController {

    private final AttendanceService attendanceService;

    @PostMapping("/in")
    public ResponseEntity<ApiResponse<Long>> checkIn(
            @AuthenticationPrincipal Long memberId)
            {
        try{
            return ResponseEntity.status(200)
                    .body(ApiResponse.success(attendanceService.checkInLab(memberId),"체크인 되었습니다."));
        }catch (AlreadyCheckInException e){
            return ResponseEntity.status(400).body(ApiResponse.failure(e.getMessage()));
        }
    }

    @PostMapping("/out/{inout_id}")
    public ResponseEntity<NoDataApiResponse> checkOut(
            @AuthenticationPrincipal Long memberId,
            @PathVariable(name ="inout_id") Long inoutId
    ){
        try{
            attendanceService.checkOutLab(memberId, inoutId);
            return ResponseEntity.status(200)
                    .body(NoDataApiResponse.success("체크아웃 되었습니다"));
        }catch (NotAttendanceTodayException e){
            return ResponseEntity.status(400)
                    .body(NoDataApiResponse.failure("체크인 먼저 진행해주세요"));
        }
    }


}
