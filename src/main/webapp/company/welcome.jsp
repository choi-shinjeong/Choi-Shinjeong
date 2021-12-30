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
<!-- 헤더가 들어가는 곳 -->
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더가 들어가는 곳 -->

<!-- 본문 들어가는 곳 -->
<!-- 서브페이지 메인이미지 -->
<div id="sub_img"></div>
<!-- 서브페이지 메인이미지 -->
<!-- 왼쪽메뉴 -->
<!-- <nav id="sub_menu"> -->
<!-- <ul> -->
<!-- <li><a href="#">Welcome</a></li> -->
<!-- <li><a href="#">History</a></li> -->
<!-- <li><a href="#">Newsroom</a></li> -->
<!-- <li><a href="#">Public Policy</a></li> -->
<!-- </ul> -->
<!-- </nav> -->
<!-- 왼쪽메뉴 -->
<!-- 내용 -->
<article>
<h2>About Me</h2>
<figure class="ceo"><img src="../images/company/about_shinjeong.jpg" width="180" height="252" 
alt="CEO">
</figure>
<br>
<p>
<h3>PROFILE</h3>
<table>
<tr><td><b>NAME</b></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;최신정</td></tr>	
<tr><td><b>AGES</b></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;28(1994.01.01)</td></tr>
<tr><td><b>ADDRESS</b></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;부산광역시</td></tr>
<tr><td><b>EMAIL</b></td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;csj2886@naver.com</td></tr>
</table>
</p><br>
<p>
<h3>LICENSE</h3>
<table>
<tr><td>2020.10</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전산세무2급</td></tr>	
<tr><td>2020.08</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;전산회계1급</td></tr>
<tr><td>2020.08</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;회계정보처리(FAT)1급</td></tr>
<tr><td>2014.02</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2종보통운전면허</td></tr>
</table>
</p><br>
<p>
<b><h3>더</b> 생각하여 <b>더</b> 창의적이고 <b>더</b> 나은 업무를 하도록
언제나 노력하며 한 발 앞서 나가겠습니다.</h3>
</p>

</article>
<!-- 내용 -->
<!-- 본문 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>



    