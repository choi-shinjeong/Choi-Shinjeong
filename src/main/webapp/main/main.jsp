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
<link href="../css/front.css" rel="stylesheet" type="text/css">

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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_img.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">

<div id="news_notice">
<h3 class="brown">News &amp; Board</h3>
<table>
<%
//BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();
//한화면에 보여줄 글개수  5개 설정
int pageSize = 5;
//페이지 번호 가져오기 1페이지 설정
String pageNum = "1";
//시작하는 행번호 구하기
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1;
//select * from board order by num desc limit 시작행-1, 가져올개수
List<BoardDTO> boardList=boardDAO.getBoardList(startRow, pageSize);
//날짜 형식
SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy.MM.dd");
for(int i = 0; i < boardList.size(); i++){
	BoardDTO boardDTO=boardList.get(i);
	%>
<tr><td class="contxt"><a href="../center/content.jsp?num=<%=boardDTO.getNum()%>">
                       <%=boardDTO.getSubject() %></a></td>
    <td><%=dateFormat.format(boardDTO.getDate()) %></td></tr>	
	<%
}
%>

</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>