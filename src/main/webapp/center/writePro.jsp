<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/writePro.jsp</title>
</head>
<body>
<%
//request 한글처리
request.setCharacterEncoding("utf-8");
// request 태그파라미터 가져오기 name pass subject content
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// BoardDTO 객체생성
BoardDTO boardDTO = new BoardDTO();
// set메서드 호출 저장
// name  pass subject content
// readcount 조회수 0 설정
// date 시스템 날짜 저장
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(0);
boardDTO.setDate(new Timestamp(System.currentTimeMillis()));

// BoardDAO 객체생성 
BoardDAO boardDAO = new BoardDAO();
// insertBoard(boardDTO) 호출 
boardDAO.insertBoard(boardDTO);

// notice.jsp 이동
response.sendRedirect("notice.jsp");
%>
</body>
</html>


