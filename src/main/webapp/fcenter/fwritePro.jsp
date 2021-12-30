<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fwritePro.jsp</title>
</head>
<body>
<%
//request 한글처리
// request.setCharacterEncoding("utf-8");

// 파일업로드
// lib 폴더에 cos.jar 프로그램 설치
// webapp upload 폴더 만들고 => 물리적 경로
// C:\Program Files\Apache Software Foundation\Tomcat 8.5\wtpwebapps\FunWeb
String uploadPath = request.getRealPath("/upload");
// 파일 크기 10M
int maxsize = 10*1024*1024;
MultipartRequest multi = new MultipartRequest(request, uploadPath, maxsize, "utf-8", new DefaultFileRenamePolicy());

// request 태그파라미터 가져오기 name pass subject content
String name = multi.getParameter("name");
String pass = multi.getParameter("pass");
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");

// file
String file = multi.getFilesystemName("file");

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
// file
boardDTO.setFile(file);

// BoardDAO 객체생성 
BoardDAO boardDAO = new BoardDAO();
// insertBoard(boardDTO) 호출 
boardDAO.insertBoard(boardDTO);

// notice.jsp 이동
response.sendRedirect("fnotice.jsp");
%>
</body>
</html>


