<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<%@include file="common.jsp" %>

<head><title>로그인</title>
	<script>
		$(document).ready(function(){
			$("[name=loginForm] [name=login]").click(function(){
				checkLoginForm();
			});
			$("[name=admin_id]").val("${cookie.admin_id.value}");
			$("[name=pwd]").val("${cookie.pwd.value}");
			$("[name=is_login]").prop(
				"checked",
				${!empty cookie.admin_id.value}
			);
		});

		function checkLoginForm(){
			var admin_id = $('[name=admin_id]').val();
			if(admin_id.split(" ").join("")==""){
				alert("아이디 입력 요망");
				$('[name=admin_id]').val("");
				return;
			}

			var pwd = $("[name=pwd]").val();
			if(pwd.split(" ").join("")==""){
				alert("암호 입력 요망");
				$("[name=pwd]").focus();
				return;
			}

			$.ajax({
				url : "${requestScope.croot}/loginProc.do"
				, type : "post"
				, data : $("[name=loginForm]").serialize()
				, success : function(admin_idCnt){
					if(admin_idCnt==1){
						alert("멤버 모드 로그인")
						location.replace("${requestScope.croot}/boardList.do")
					}

					else if(admin_idCnt==2){
						alert("관리자 모드 로그인")
						location.replace("${requestScope.croot}/boardList.do")
					}	
					
					else{
						alert("입력하신 아이디 또는 암호가 틀리거나 회원등급이 결정되지 않았습니다.")
					}
				}
				, error : function(){
					alert("서버 접속 실패");
				}
			});
		}

	
		function gomemRegForm(){
			document.memberRegForm.submit()
		}
	
		function insa(){
			alert("안녕하세요 홈페이지 개발자 박인선입니다. 환영합니다!!")
		}
	
		function withoutLog(){
			alert('로그인 후 게시판 이용 가능합니다.')
		}
	
		function goMemberListForm(){
			document.memberList.submit();
		}
	</script>
</head>
<body><center>

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
			<li><a href="javascript:withoutLog()">게시판</a></li>
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


<form name="loginForm" method="post" action="${requestScope.croot}/loginProc.do">
	<div class="container">
		<div class="col-lg-4"></div>
		<div class="col-lg-4">
			<div class="jumbotron" style="padding-top : 20px;">
				<h3 style="text-align: center;">LOGIN</h3>
				<div class="form-group">
					<input type="text" class="form-control" placeholder="아이디" name="admin_id" maxlength="20">
				</div>
				
				<div class="form-group">
					<input type="password" class="form-control" placeholder="비밀번호" name="pwd" maxlength="20">
				</div>
				<input type="button" name="login" class="btn btn-primary form-control" value="로그인">
				<input type="checkbox" class="" name="is_login" value="y"> 아이디,암호 기억

				<table>
					<tr>
						<div><br></div>
					</tr>
					
					<tr>
						<td><input type="button" name="register" class="btn btn-success form-control" value="회원가입" onClick="gomemRegForm()"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</form>
	
<form name="memberRegForm" method="post" action="${requestScope.croot}/memberRegForm.do"></form>

</body>
</html>