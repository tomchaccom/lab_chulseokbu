package com.example.LabAttendance.RollCall.global.ResponneType;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class NoDataApiResponse {

    private Boolean success;
    private String message;

    public static NoDataApiResponse success(String message) {
        return new NoDataApiResponse(true, message);
    }

    public static NoDataApiResponse failure(String message) {
        return new NoDataApiResponse(false, message);
    }


}
