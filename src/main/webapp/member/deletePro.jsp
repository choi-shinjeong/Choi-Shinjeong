<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/deletePro.jsp</title>
</head>
<body>
<%
//id pass request 파라미터 가져오기
String id = request.getParameter("id");
String pass = request.getParameter("pass");

//자바파일안에 디비연동작업 userCheck(id,pass)메서드 정의 하고 
//자바파일 객체생성(기억장소할당)하고 메서드 호출
MemberDAO memberDAO = new MemberDAO();
MemberDTO memberDTO = memberDAO.userCheck(id, pass);

if(memberDTO!=null){
	// delete 조건 id => deleteMember(id) 정의 호출
	memberDAO.deleteMember(id);
	// 세션초기화
	session.invalidate();
	// 메인이동
	response.sendRedirect("../main/main.jsp");
}else{
	%>
	<script type="text/javascript">
		alert("입력하신 정보가 틀립니다.");
		history.back();
	</script>
	<%
}
%>
</body>
</html>

