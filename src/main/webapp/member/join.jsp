<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">

<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="CheckForm.js"></script>
 
<script type="text/javascript">
 	function CheckId() {

		var uID=$("input[id='uID']");
		if(uID.val()==""){
			alert("아이디 입력하세요");
			uID.focus();
			return false;
		}
		//창열기
		window.open("idCheck.jsp?uID="+uID.val(),"","width=500,height=300");
	}
 	
 	// <input type="button" class="dup"> 클릭했을때 
 	$(document).ready(function(){	
 		// 버튼을 클릭했을때
 		$('.dup').click(function(){

				// idCheck2.jsp에 아이디를 들고 가서  아이디를 중복체크 아이디 중복, 아이디 사용가능 출력
			$.ajax('idCheck2.jsp',{
				data:{uID:$('#uID').val()},
				success:function(rdata){
					//#dupdiv 대상에  가져온 값을 출력
					$('#dupdiv').html(rdata);
				}
			});	
 		});
 	});
 	
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
   function kakaopost() {
      new daum.Postcode(
            {
               oncomplete : function(data) {
   
                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('postcode').value = data.zonecode;
                  document.getElementById("address").value = data.address;
                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("detailAddress").focus();
                  
               }
            }).open();
   }
</script>
 	 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">Join us</a></li>
<li><a href="#">Privacy policy</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h2>회원가입</h2>
<form action="joinPro.jsp" id="join" method="post" onsubmit="return CheckForm();">
<fieldset>
<legend>기본 정보</legend>
<label>아이디</label>
<input type="text" name="id" class="id"  id="uID">
<input type="button" value="아이디 중복 확인" class="dup">
<!-- <input type="button" value="아이디 중복 확인" class="dup" onclick="CheckId()"><br> -->
<div id="dupdiv"></div><br>
<label>비밀번호</label>
<input type="password" name="pass" id="pass"><br>
<label>비밀번호 확인</label>
<input type="password" name="pass2" id="pass2"><br>
<label>이름</label>
<input type="text" name="name" id="name"><br>
<label>이메일</label>
<input type="email" name="email" id="email"><br>
<label>이메일 확인</label>
<input type="email" name="email2" id="email2"><br>
</fieldset>

<fieldset>
<legend>추가 정보</legend>
<label>주소</label>
<input type="text" name="postcode" id="postcode" readonly placeholder="우편번호" >
<button type="button" onclick="kakaopost();" class="btn">우편번호 찾기</button><br>
<label></label>
<input type="text" name="address" id="address"  readonly placeholder="주소"><br>
<label></label>
<input type="text" name="detailAddress" id="detailAddress"  placeholder="상세주소"><br>
<label>전화번호</label>
<input type="text" name="phone" id="phone"><br>
<label>휴대전화</label>
<input type="text" name="mobile" id="mobile"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
<input type="reset" value="취소" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>