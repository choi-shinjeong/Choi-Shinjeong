<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//request 태그 파라미터 가져오기 num name pass
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String pass = request.getParameter("pass");

//BoardDAO 객체 생성
BoardDAO boardDAO = new BoardDAO();

//deleteBoard(boardDTO) 메서드 호출
boardDAO.deleteBoard(num);

//notice.jsp 이동
response.sendRedirect("notice.jsp");

%>
</body>
</html>