function CheckForm(){
	var uID = $("input[id='uID']");
	var pass = $("input[id='pass']");
	var pass2 = $("input[id='pass2']");
	var name = $("input[id='name']");
	var email = $("input[id='email']");
	var email2 = $("input[id='email2']");
	var postcode = $("input[id='postcode']");
	var address = $("input[id='address']");
	var detailAddress = $("input[id='detailAddress']");
	var phone = $("input[id='phone']");
	var mobile = $("input[id='mobile']");

	if (uID.val() == "") {
			alert("아이디를 입력하세요.");
			uID.focus();
			return false;
	}
	if (pass.val() == "") {
			alert("비밀번호를 입력하세요.");
			pass.focus();
			return false;
	}
	if (pass2.val() == "") {
			alert("비밀번호 재확인 하세요.");
			pass2.focus();
			return false;
	}
	 //이름을 입력하지 않았을 경우
	if (name.val() == "") {
			alert("이름을 입력하세요.");
			name.focus();
			return false;
	}
	if (email.val() == "") {
			alert("이메일을 입력하세요.");
			email.focus();
			return false;
	}
	if (email2.val() == "") {
			alert("이메일을 재확인하세요.");
			email2.focus();
			return false;
	}
	if (postcode.val() == "") {
			alert("우편번호를 입력하세요.");
			postcode.focus();
			return false;
	}
	if (address.val() == "") {
			alert("주소를 입력하세요.");
			address.focus();
			return false;
	}
	if (detailAddress.val() == "") {
			alert("상세주소를 입력하세요.");
			detailAddress.focus();
			return false;
	}
	if (phone.val() == "") {
			alert("전화번호를 입력하세요.");
			phone.focus();
			return false;
	}
	if (mobile.val() == "") {
			alert("휴대전화를 입력하세요.");
			mobile.focus();
			return false;
	}
	if(pass.val()!= pass2.val()){
			//두 비밀번호가 일치하지 않습니다. 경고메세지창
			alert("두 비밀번호가 일치하지 않습니다.");
			//비밀번호 확인 입력 공간에 입력되어 있는 정보들을 빈공백을 주어 제거
			pass2.value = pass2.val("");
			return false;
	}
	if(email.val()!= email2.val()){
			alert("두 이메일이 일치하지 않습니다.");
			email2.value = email2.val("");
			return false;
	}

}