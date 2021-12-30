<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
//세션값 가져오기
String id=(String)session.getAttribute("id");
if(id==null){
	//세션값 없음 로그인이 안된 상태
	%>
<div id="login"><a href="../member/login.jsp">로그인</a> | 
                <a href="../member/join.jsp">회원가입</a></div>	
	<%
}else{
	//세션값 있음 로그인이 된 상태
	%>
<div id="login"><%=id %>님 | <a href="../member/logout.jsp">로그아웃</a> | 
                             <a href="../member/update.jsp">회원정보수정</a> |
                             <a href="../member/delete.jsp">회원탈퇴</a> </div>	
	<%
}
%>

<div class="clear"></div>
<!-- 로고들어가는 곳 -->
<div id="logo"><img src="../images/logo_shinjeong.png" width="265" height="65" alt="Fun Web"></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../main/main.jsp">Home</a></li>
	<li><a href="../company/welcome.jsp">About</a></li>
<!-- 	<li><a href="#">SOLUTIONS</a></li> -->
	<li><a href="../center/notice.jsp">Board</a></li>
<!-- 	<li><a href="#">Contact</a></li> -->
</ul>
</nav>
</header>