
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>정보수정</title>
</head>
<body>

<form action="/modify" method="post">
    <p>이메일 <input type="email" name="emailId" value="${dto.emailId}" readonly></p>
    <p><a href="/modifyPassword">비밀번호 변경</a> </p>
    <p>이름 <input type="text" name="memberName" value="${dto.memberName}" readonly></p>
    <p>전화번호 <input type="text" name="phone" value="${dto.phone}" required></p>
    <p> 생일 <input type="date" name="birthday" value="${dto.birthday}" readonly></p>
    <p>우편번호 <input type="text" name="zipCode" id="zipCode" placeholder="우편번호" value="${dto.zipCode}">
        <input type="button" name="findCode" value="우편번호 찾기"><br></p>
    <p>번지수/도로명 <input type="text" name="address01" value="${dto.address01}"  id="address01" placeholder="주소"></p>
    <p>상세주소 <input type="text" name="address02" value="${dto.address02}"  id="address02" placeholder="상세주소"></p>
    <p>배송 요청사항 <input type="text" name="address03" value="${dto.address03}"  placeholder="요청사항"></p>

    <button name="modify" type="submit">정보수정</button> <a href="#" id="removeMemberLink">회원탈퇴</a>
</form>
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script>
    document.getElementById('removeMemberLink').addEventListener('click', function (e) {
        e.preventDefault(); // 기본 링크 동작 방지

        // 확인 대화상자를 표시하고 사용자의 응답을 확인합니다.
        var confirmRemove = confirm("정말로 회원을 탈퇴하시겠습니까?");

        // 사용자가 확인 버튼을 눌렀을 때만 회원 탈퇴를 수행합니다.
        if (confirmRemove) {
            window.location.href = "/removeMember"; // 실제 회원 탈퇴 페이지로 이동
        }
    });

    document.querySelector('input[name="findCode"]').addEventListener('click', execDaumPostcode);

    /* 카카오 우편번호 검색 가이드 페이지 :  https://postcode.map.daum.net/guide */
    function execDaumPostcode() {
        /* 상황에 맞춰서 변경해야 하는 부분 */
        const zipcode = document.getElementById('zipCode');
        const address01 = document.getElementById('address01');
        const address02 = document.getElementById('address02');

        /* 수정없이 사용 하는 부분 */
        new daum.Postcode({
            oncomplete: function (data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') {
                    // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;
                } else {
                    // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if (data.userSelectedType === 'R') {
                    //법정동명이 있을 경우 추가한다.
                    if (data.bname !== '') {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if (data.buildingName !== '') {
                        extraAddr += extraAddr !== '' ? ', ' + data.buildingName : data.buildingName;
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += extraAddr !== '' ? ' (' + extraAddr + ')' : '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                zipcode.value = data.zonecode; //5자리 새우편번호 사용
                address01.value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                address02.focus();
            },
        }).open();
    }


    document.addEventListener("DOMContentLoaded", function () {


        p2.addEventListener("focusout", function () {
            if (p1.value !== p2.value) {
                c1.style.color = "red";
                c1.innerHTML = "비밀번호가 일치하지 않습니다!";
                p1.value = "";
                p2.value = "";
            } else if(p1.value === p2.value){
                c1.style.color = "green";
                c1.innerHTML = "비밀번호가 일치합니다!";
            }
        });
    });
</script>
</body>
</html>
