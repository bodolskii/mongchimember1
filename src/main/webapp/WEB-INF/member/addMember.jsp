<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 2023-09-24
  Time: 오후 3:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
</head>

<body>

    <form action="/addMember" method="post">
        <p>이메일<input type="email" name="emailId"></p><span class="memberEmailCheck"></span>
        <p>비번<input type="password" name="password"></p>
        <p>비번확인<input type="password" name="password2"></p><span class="passCheck"></span>
       <p>이름 <input type="text" name="memberName"></p>
        <p>전화번호 <input type="text" name="phone"></p>
        <p> 생일 <input type="date" name="birthday"></p>
        <button type="submit">회원가입</button>
    </form>
</body>
<script>


    document.addEventListener("DOMContentLoaded", function () {
        const p1 = document.querySelector('input[name="password"]');
        const p2 = document.querySelector('input[name="password2"]');
        const c1 = document.querySelector(".passCheck");
        const lowercaseRegex = /[a-z]/;
        const digitRegex = /[0-9]/;

        p1.addEventListener("keyup", function () {
            if (p1.value.length < 8) {
                c1.style.color = "red"
                c1.innerHTML = "비밀번호는 여덟자 이상이어야 합니다";
            } else if (!lowercaseRegex.test(p1.value) || !digitRegex.test(p1.value)) {
                c1.style.color = "red"
                c1.innerHTML = "비밀번호는 반드시 영문(소문자)와 숫자를 포함해야 합니다!";
            } else {
                c1.style.color = "green"
                c1.innerHTML = "비밀번호가 유효합니다.";
            }
        });



        const xhr = new XMLHttpRequest();
        const emailId = document.querySelector('input[name=emailId]');
        emailId.addEventListener('keyup',function () {
            const emailIdval = emailId.value;
            const memberEmailCheck = document.querySelector('.memberEmailCheck'); //결과문자열
            xhr.open('GET','./ajaxIdCheck.jsp?emailId='+emailIdval );
            xhr.send();
            xhr.onreadystatechange = () => {
                if(xhr.readyState !== XMLHttpRequest.DONE) return;

                if(xhr.status === 200) {
                    const json = JSON.parse(xhr.response);
                    if(json.result === 'true') {
                        memberEmailCheck.style.color = 'red';
                        memberEmailCheck.innerHTML = '동일한 아이디가 있습니다!';
                    }
                    else {
                        memberEmailCheck.style.color = 'gray';
                        memberEmailCheck.innerHTML = '동일한 아이디가 없습니다.'
                    }
                }
                else {
                    console.error('Error',xhr.status,xhr.statusText);
                }
            }
        });
    });
</script>
</html>
