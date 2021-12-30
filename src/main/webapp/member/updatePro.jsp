<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/updatePro.jsp</title>
</head>
<body>
<%
// 한글처리
request.setCharacterEncoding("utf-8");
// 파라미터 가져오기 
String id=request.getParameter("id");
String pass=request.getParameter("pass");
String name=request.getParameter("name");
String email=request.getParameter("email");
String postcode=request.getParameter("postcode");
String address=request.getParameter("address");
String detailAddress=request.getParameter("detailAddress");
String phone=request.getParameter("phone");
String mobile=request.getParameter("mobile");

// MemberDTO  memberDTO 객체생성
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

//MemberDAO 객체생성
MemberDAO memberDAO=new MemberDAO();
// MemberDTO memberDTO2  =  userCheck(id,pass)메서드 호출
MemberDTO memberDTO2=memberDAO.userCheck(id, pass);
if(memberDTO2!=null){
	//일치 updateMember(memberDTO) 메서드 정의
	memberDAO.updateMember(memberDTO);
	// ../main/main.jsp
	response.sendRedirect("../main/main.jsp");
}else{
	//틀림 "입력하신 정보 틀림" 뒤로이동
	%>
	<script type="text/javascript">
		alert("입력하신 정보 틀림");
		history.back();
	</script>
	<%
}

%>
</body>
</html>



