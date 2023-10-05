package dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;


@Builder
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberDTO {
    private int mno;
    private String emailId;
    private String password;
    private String memberName;
    private String phone;
    private String zipCode;
    private String address01;
    private String address02;
    private String address03;
    private LocalDate addDate;
    private LocalDate birthday;
    private String uuid;

}
