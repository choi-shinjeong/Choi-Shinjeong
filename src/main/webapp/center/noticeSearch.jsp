<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">Notice</a></li>
<!-- <li><a href="#">Public News</a></li> -->
<li><a href="../fcenter/fnotice.jsp">Driver Download</a></li>
<!-- <li><a href="#">Service Policy</a></li> -->
</ul>
</nav>
<!-- 왼쪽메뉴 -->

<!-- 게시판 -->
<%
// 한글처리
request.setCharacterEncoding("utf-8");
// search
String search = request.getParameter("search");

//BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();

//한화면에 보여줄 글개수  15개 설정
int pageSize = 15;
// http://localhost:8181/FunWeb/center/notice.jsp
// http://localhost:8181/FunWeb/center/notice.jsp?pageNum=3
//페이지 번호 가져오기 
String pageNum = request.getParameter("pageNum");
//페이지번호가 없으면 -> 1
if(pageNum == null){
	pageNum = "1";
}

//시작하는 행번호 구하기
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
//끝나는 행번호 구하기
int endRow = startRow+pageSize - 1;

//메서드 호출
//List<BoardDTO> boardList = boardDAO.getBoardList(startRow, pageSize);
//select * from board order by num desc limit 시작행-1, 가져올개수
// List<BoardDTO> boardList = boardDAO.getBoardList(startRow, pageSize);
List<BoardDTO> boardList = boardDAO.getBoardList(startRow, pageSize, search);

//게시판 전체 글 개수
//select count(*) from board
int count = boardDAO.getBoardCount(search);
%>
<article>
<h2>게시판 검색 [전체글개수 : <%=count %>]</h2>
<table id="notice">
<tr><th class="tno">글번호</th>
    <th class="ttitle">제목</th>
    <th class="twrite">작성자</th>
    <th class="tdate">작성일</th>
    <th class="tread">조회수</th></tr>
    <%
    // 날짜 포맷 변경 => 문자열
    SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy.MM.dd");
    
    for(int i=0;i<boardList.size();i++){
    	BoardDTO boardDTO=boardList.get(i);
    	%>
<tr onclick="location.href='content.jsp?num=<%=boardDTO.getNum()%>'"><td><%=boardDTO.getNum() %></td>
    <td class="left"><%=boardDTO.getSubject() %></td>
    <td><%=boardDTO.getName() %></td>
    <td><%=dateFormat.format(boardDTO.getDate()) %></td>
    <td><%=boardDTO.getReadcount() %></td></tr>    	
    	<%
    }
    %>
</table>

<%
//로그인(세션값 있음) => 글쓰기 버튼 보임
String id=(String)session.getAttribute("id");
if(id!=null){
	%>
<div id="table_search">
<input type="button" value="글쓰기" class="btn" onclick="location.href='writeForm.jsp'">
</div>	
	<%
}
%>

<div id="table_search">
<form action="noticeSearch.jsp" method="get">
<input type="text" name="search" class="input_box">
<input type="submit" value="검색" class="btn">
</form>
</div>

<div class="clear"></div>
<div id="page_control">
<%
// 한 페이지에 보여줄 페이지 개수 설정
int pageBlock = 10;

// 시작하는 페이지 번호
int startPage = (currentPage - 1) / pageBlock * pageBlock + 1;
// 끝나는 페이지 번호
int endPage = startPage + pageBlock - 1;
// 전체 글 페이지 수 구하기
int pageCount = count / pageSize + (count % pageSize==0?0:1);
if (endPage >  pageCount) {
// 끝나는페이지번호 =  전체글페이지수
	endPage = pageCount;
}
%>

<%

if (startPage > pageBlock) {
	%>
	<a href="noticeSearch.jsp?pageNum=<%=startPage-pageBlock%>&search=<%=search%>">Prev</a>
	<%
}
for (int i = startPage; i <= endPage; i++) {
	%>
	<a href="noticeSearch.jsp?pageNum=<%=i%>&search=<%=search%>"><%=i %></a>
	<%
}
if (endPage < pageCount) {
	%>
	<a href="noticeSearch.jsp?pageNum=<%=startPage+pageBlock%>&search=<%=search%>">Next</a>
	<%
}
%>

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>