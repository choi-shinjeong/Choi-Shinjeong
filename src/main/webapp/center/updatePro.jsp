<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/updatePro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");

// request 태그 파라미터 가져오기 num name pass subject content
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// BoardDTO 객체 저장
BoardDTO boardDTO = new BoardDTO();
// set 통해 값 저장
boardDTO.setNum(num);
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);

// BoardDAO 객체 생성
BoardDAO boardDAO = new BoardDAO();

// updateBoard(boardDTO) 메서드 호출
boardDAO.updateBoard(boardDTO);

// notice.jsp 이동
response.sendRedirect("notice.jsp");

%>
</body>
</html>