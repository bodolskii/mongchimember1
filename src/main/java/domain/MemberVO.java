package domain;

import lombok.*;

import java.time.LocalDate;


@Builder
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class MemberVO {
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
