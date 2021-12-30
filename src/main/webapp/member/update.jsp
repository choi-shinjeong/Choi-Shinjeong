<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
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
<%
// 세션값 가져오기
String id=(String)session.getAttribute("id");
// MemberDAO 객체생성
MemberDAO memberDAO=new MemberDAO();
// id정보를 조회 MemberDTO getMember(id) 메서드 정의
// MemberDTO  memberDTO = getMember(id) 메서드 호출
MemberDTO memberDTO=memberDAO.getMember(id);
%>
<h2>회원정보수정</h2>
<form action="updatePro.jsp" id="join" method="post">
<fieldset>
<legend>기본 정보</legend>
<label>아이디</label>
<input type="text" name="id" class="id" value="<%=id %>" readonly><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
<label>이름</label>
<input type="text" name="name" value="<%=memberDTO.getName()%>"><br>
<label>이메일</label>
<input type="email" name="email" value="<%=memberDTO.getEmail()%>"><br>
</fieldset>

<fieldset>
<legend>추가 정보</legend>
<label>주소</label>
<input type="text" name="postcode" id="postcode" readonly placeholder="우편번호" value="<%=memberDTO.getPostcode()%>">
<button type="button" onclick="kakaopost();" class="btn">우편번호 찾기</button><br>
<label></label>
<input type="text" name="address" id="address"  readonly placeholder="주소" value="<%=memberDTO.getAddress()%>"><br>
<label></label>
<input type="text" name="detailAddress" id="detailAddress"  placeholder="상세주소" value="<%=memberDTO.getDetailAddress()%>"><br>
<label>전화번호</label>
<input type="text" name="phone" id="phone" value="<%=memberDTO.getPhone()%>"><br>
<label>휴대전화</label>
<input type="text" name="mobile" id="mobile" value="<%=memberDTO.getMobile()%>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="수정" class="submit">
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