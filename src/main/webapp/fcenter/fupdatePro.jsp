<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/fupdatePro.jsp</title>
</head>
<body>
<%
// request 한글처리 
// request.setCharacterEncoding("utf-8");

//업로드
String uploadPath=request.getRealPath("/upload");
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// multi 태그파라미터 가져오기 num pass name subject content
int num=Integer.parseInt(multi.getParameter("num"));
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
//첨부파일
String file=multi.getFilesystemName("file");
//첨부파일이 없으면
if(file==null){
	//기존파일이름 가져오기
	file=multi.getParameter("oldfile");
}

// BoardDTO 객체 생성
BoardDTO boardDTO=new BoardDTO();
// set통해서 값 저장
boardDTO.setNum(num);
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
// file 추가
boardDTO.setFile(file);

// BoardDAO 객체생성 
BoardDAO boardDAO=new BoardDAO();
//  fupdateBoard(boardDTO) 메서드 호출
boardDAO.fupdateBoard(boardDTO);

// fnotice.jsp 이동 
response.sendRedirect("fnotice.jsp");
%>
</body>
</html>