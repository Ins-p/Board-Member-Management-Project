<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<%@include file="common.jsp" %>
<head><title>게시판 글쓰기</title>
	<script>	

		$(document).ready(function(){
			$('[name=boardListForm]').hide();

			<c:forEach items="${paramValues.date}" var = "date">
				$("[name=boardListForm] [name=date]").filter("[value=${date}]").prop("checked", true);
			</c:forEach>

			 $('#summernote').summernote();
		}) 
		function checkBoardRegForm(){	
			if( checkEmpty( "[name=writer]", "이름을 입력해주세요.") ){ return; }
			if( checkEmpty( "[name=subject]", "제목을 입력해주세요.") ){ return; }
			if( checkEmpty( "[name=content]", "내용을 입력해주세요.") ){ return; }
			if( checkEmpty( "[name=pwd]", "암호을 입력해주세요.") ){ return; }
			if( checkPattern( "[name=pwd]", /^[0-9]{4}$/, "암호는 숫자 4자리를 입력해주세요.")  ){ return; }

			if(confirm("정말 등록 하시겠습니까?")==false) {return;}

			$.ajax({
				url : "${requestScope.croot}/boardRegProc.do"
				, type : "post"
				, data : $('[name=boardRegForm]').serialize()
				, success : function(boardRegCnt){	
					if(boardRegCnt==1){
						alert("게시판 ${requestScope.b_no==0?'새글':'댓글'} 등록 성공!");
						document.boardListForm.submit();
					}
					else{
						alert("게시판 등록 실패! 관리자에게 문의 바람.");
					}
				}
				, error : function(){
					alert("서버 접속 실패");
				}
			});
		}
		
		function goMemberListForm(){
			document.memberList.submit();
		}

		function insa(){
			alert("안녕하세요 홈페이지 개발자 박인선입니다. 환영합니다!!")
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

<form name="boardRegForm" method="post" action="${requestScope.croot}/boardRegProc.do">
	<div class="container">
		<div class="jumbotron" style="padding-top : 10px;">
		<c:if test="${requestScope.b_no==0}">
		<h3 style="text-align: center;">[새글쓰기]</h3><br>
		<input type="text" class="form-control" placeholder="제목" name="subject">

		</c:if>
		<c:if test="${requestScope.b_no!=0}">
		<h3 style="text-align: center;">[댓글쓰기]</h3><br>
		<input type="text" class="form-control" placeholder="제목" name="subject" value="${regInfo.subject }">
		</c:if>

		<table class="tbcss1"  border=1  bordercolor="${requestScope.thBgcolor }" cellpadding=5 align=center>
			<tr>
				<div class="form-group">
					<textarea name="content" class="form-control" placeholder="내용을 입력해주세요" rows="13" cols="40"  maxlength=300></textarea>
				</div>
				<div style="width: 100px; text-align: left">
					<input type="password" class="form-control" placeholder="비밀번호" name="pwd" maxlength="4" style="text-align: left">
				</div>
			</tr>
			<input type="hidden" size="10" name="writer" maxlength=10 value="${sessionScope.admin_id}">
		</table>
		<div style="height:6"></div>
		<input type="hidden" name="b_no" value="${requestScope.b_no}">
		<input type="button" value="저장" onClick="checkBoardRegForm()">
		<input type="reset" value="다시작성">
		<input type="button" value="목록보기" onClick="document.boardListForm.submit();">
		</div>
	</div>
</form>

<form name="boardListForm" method="post" action="${requestScope.croot}/boardList.do">	
	<input type="hidden" name="selectPageNo" value="${param.selectPageNo}">
	<input type="hidden" name="rowCntPerPage" value="${param.rowCntPerPage}">
	<input type="hidden" name="keyword1" value="${param.keyword1}">
	<input type="checkbox" name="date" value="오늘">
	<input type="checkbox" name="date" value="어제">
</form>

</body>
</html>
