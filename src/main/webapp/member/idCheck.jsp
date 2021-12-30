<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/idCheck.jsp</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
function ok() {
	var uID=$("input[id='uID']");
	// join.jsp(opener) 아이디 상자에 넣기  <=  idCheck.jsp에서 찾은아이디
	opener.document.getElementById("uID").value=uID.val();
	//창닫기
	window.close();
}
</script>
</head>
<body>
<%
String uID=request.getParameter("uID");
// 디비작업
//MemberDAO 객체생성
MemberDAO memberDAO=new MemberDAO();
//MemberDTO memberDTO = getMember(String id)메서드 호출 
MemberDTO memberDTO=memberDAO.getMember(uID);
// 아이디 없으면 null   => 아이디 중복아님  아이디 사용가능
// 아이디 있으면 null아님 => 아이디 중복  아이디 사용못함
if(memberDTO==null){
	%>아이디 사용가능 <input type="button" value="아이디사용" onclick="ok()"><%
}else{
	%>아이디 중복<%
}
%>
<form action="idCheck.jsp" method="get">
아이디 : <input type="text" name="uID" class="id" id="uID" value="<%=uID%>">
<input type="submit" value="아이디 찾기">
</form>
</body>
</html>

