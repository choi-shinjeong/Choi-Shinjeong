<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/joinPro.jsp</title>
</head>
<body>
<%
// http가 폰에서 입력한 정보를 서버에 들고오면
// 서버에서 request내장객체 생성하고 request에 들고온 정보를 저장
// request 한글처리
request.setCharacterEncoding("utf-8");
// request 파라미터 가져오기
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String postcode=request.getParameter("postcode");
String address=request.getParameter("address");
String detailAddress=request.getParameter("detailAddress");
String phone=request.getParameter("phone");
String mobile=request.getParameter("mobile");
// 날짜내장객체 <= 시스템 날짜 가져오기 
Timestamp date=new Timestamp(System.currentTimeMillis());

// 패키지 member 파일 MemberDTO 만들기
// 멤버변수 정의 set get 정의 
// MemberDTO 객체생성
MemberDTO memberDTO =new MemberDTO();
// 멤버변수에 폼에서 가져온 내용을 set호출해서 저장
memberDTO.setId(id);
memberDTO.setPass(pass);
memberDTO.setName(name);
memberDTO.setEmail(email);
memberDTO.setPostcode(postcode);
memberDTO.setAddress(address);
memberDTO.setDetailAddress(detailAddress);
memberDTO.setPhone(phone);
memberDTO.setMobile(mobile);
memberDTO.setDate(date);

// 패키지 member 파일 MemberDAO 만들기
// insertMember(바구니주소) 메서드 정의
// MemberDAO 객체생성  
MemberDAO memberDAO=new MemberDAO();
// insertMember(주소) 메서드 호출
memberDAO.insertMember(memberDTO);

// "회원가입성공"  login.jsp 이동
%>
<script type="text/javascript">
	alert("회원가입성공");
	location.href="login.jsp";
</script>
</body>
</html>




