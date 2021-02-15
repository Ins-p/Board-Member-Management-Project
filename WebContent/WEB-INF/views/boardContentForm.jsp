<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<%@include file="common.jsp" %>
<head><title>게시판 상세보기</title>
	<script>
	 	$(document).ready(function(){
			$('[name=boardForm]').hide();
	
			<c:forEach items="${paramValues.date}" var = "date">
				$("[name=boardForm] [name=date]").filter("[value=${date}]").prop("checked", true);
			</c:forEach>
		}) 
	
		function goBoardUpDelForm(){
			document.boardForm.action="${requestScope.croot}/boardUpDelForm.do";
			document.boardForm.submit();
		}
		
		function goBoardRegForm(){
			document.boardForm.action="${requestScope.croot}/boardRegForm.do";
			document.boardForm.submit();
		}

		function goBoardListForm(){
			document.boardForm.action="${requestScope.croot}/boardList.do";
			document.boardForm.submit();
		}

		function insa(){
			alert("안녕하세요 홈페이지 개발자 박인선입니다. 환영합니다!!")
		}

		function goMemberListForm(){
			document.memberList.submit();
		}
	</script>
</head>
<body bgcolor="${requestScope.bodyBgcolor }"><center>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" 
				data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="javascript:insa()">인선 포트폴리오</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="/board_memberMGMT/boardList.do">게시판</a></li>
				<c:if test="${sessionScope.admin_id == 'abc'}">
				<li><a href="javascript:goMemberListForm();" >회원 멤버 목록</a></li>
				</c:if>
			</ul>
				
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class = "dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
					
					<ul class="dropdown-menu">
						<c:if test="${sessionScope.admin_id != null}">
							<li class="active"><a href="/board_memberMGMT/logout.do">로그아웃</a></li>
						</c:if>
						
						<c:if test="${sessionScope.admin_id == null}">
							<li class="active"><a href="/board_memberMGMT/loginForm.do">로그인</a></li>
						</c:if>
						<li><a href="/board_memberMGMT/memberRegForm.do">회원가입</a></li>
					</ul>				
				</li>
			</ul>
		</div>
	</nav>

	
	<div class="container">
		<h3 style="text-align: center;">[글 상세 내용]</h3>
		<table class="tbcss1" width="500" border=1 bordercolor="#DDDDDD" cellpadding="5" align="center">
			<tr>
				<td colspan="4" style="background-color: #FFFAF0;">
					<div style="font-size: 22px; height: 50px; margin: 10px; ">
						<br><b>${requestScope.board.subject}<b>
					</div>
					
					<div style="font-size: 12px; height: 50px; background-color: #FFFAF0; color: grey; margin: 10px; margin-bottom: 0px">
						${requestScope.board.writer}
						<div style="text-align: left; font-size: 5px; color: lightgrey;">
							조회 | ${requestScope.board.readcount} | 작성일 | ${requestScope.board.reg_date}
						</div>
					</div>
			<tr>
				<th bgcolor="${requestScope.thBgcolor }">
				<td width=150 colspan=3 style="font-size: 18px;">
					<textarea name="content" rows="13" cols="70" style="border:0; margin: 10px" readonly>${requestScope.board.content}</textarea>
		</table><br>
			<input type="button" value="댓글쓰기" onClick="goBoardRegForm();">&nbsp;
			<input type="button" value="수정/삭제" onClick="goBoardUpDelForm();">&nbsp;
			<input type="button" value="글 목록 보기" onClick="goBoardListForm();">
	</div>

	<form name="boardForm" method="post">
		<input type="hidden" name="b_no" value="${param.b_no}">
		<input type="hidden" name="selectPageNo" value="${param.selectPageNo}">
		<input type="hidden" name="rowCntPerPage" value="${param.rowCntPerPage}">
		<input type="hidden" name="keyword1" value="${param.keyword1}">
		<input type="checkbox" name="date" value="오늘">
		<input type="checkbox" name="date" value="어제">
	</form>
	
	<form name="regForm" type="post"></form>
</body>
</html>

