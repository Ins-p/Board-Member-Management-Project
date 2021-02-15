
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<%@include file="common.jsp" %>

<head><title>회원가입</title>
	<script>
		function checkRegisterForm(){
			if( checkEmpty( "[name=member_ID]", "아이디를 입력해주세요.") ){ 
				$("[name=member_ID]").focus();
				return; 
			}
			if( checkPattern( "[name=member_ID]", /^[a-z][a-z0-9]{4,9}$/, "아이디는 5~10글자로 영어 소문자로 시작하여 숫자로 이루어진 아이디를 입력해주세요 .")  ){ 
				$("[name=member_ID]").focus();
				return; 
			}
			
			if( checkEmpty( "[name=member_pwd]", "비밀번호를 입력해주세요.") ){ 
				$("[name=member_pwd]").focus();
				return; 
			}
			if( checkPattern( "[name=member_pwd]", /^[a-z0-9]{5,10}$/, "암호는 5~10 글자로 영어소문자 또는 숫자를 입력해주세요 .")  ){ 
				$("[name=member_pwd]").focus();
				return; 
			}
			if( checkEmpty( "[name=member_pwd_check]", "비밀번호 확인을 입력해주세요.") ){ 
				$("[name=member_pwd_check]").focus();
				return; 
			}
			
			if($("[name=member_pwd]").val() != $("[name=member_pwd_check]").val()){
				alert("비밀번호와 일치 하지 않습니다.")
				$("[name=member_pwd_check]").val("")
				$("[name=member_pwd_check]").focus();
				return;
			}
			
			if( checkEmpty( "[name=member_name]", "이름을 입력해주세요.") ){ 
				$("[name=member_name]").focus();
				return; 
			}
			
			if( checkEmpty( "[name=member_email]", "이메일을 입력해주세요.") ){
				$("[name=member_email]").focus();
				 return; 
			}
	
			if( checkEmpty( "[name=member_birth]", "생년월일을 입력해주세요.") ){
				$("[name=member_birth]").focus();
				 return; 
			}
				
			if( checkPattern( "[name=member_birth]", /^[0-9]{8}$/, "생년월일을 8자로 입력해주세요 ex)20001020")  ){ 
				$("[name=member_birth]").focus();
				return; 
			}
	
			var member_birth = $("[name=member_birth]").val();
			var member_year = member_birth.slice(0, 4);			
			var member_month = member_birth.slice(4, 6);		
			var member_day = member_birth.slice(6, 8);
			var today = new Date();
			var yearNow = today.getFullYear();
			
		    var member_date = new Date(
		        parseInt(member_year, 10),
		        parseInt(member_month, 10)-1,
		        parseInt(member_day, 10)
		    );
	
		    if(1900 > member_year){
		    	alert("없는 날짜를 선택하셨습니다.")
		    	$("[name=member_birth]").val("");
		    	$("[name=member_birth]").focus();
		    	return;
		    }
	
		    else if(member_month < 1 || member_month > 12){
		    	alert("없는 날짜를 선택하셨습니다.")
		    	$("[name=member_birth]").val("");
		    	$("[name=member_birth]").focus();
		    	return;
		    }
	
		    else if(member_day < 1 || member_day > 31){
		    	alert("없는 날짜를 선택하셨습니다.")
		    	$("[name=member_birth]").val("");
		    	$("[name=member_birth]").focus();
		    	return;
		    }
	
		    else if((member_month==04 || member_month==6 || member_month==9 || member_month==11) && member_day==31){
		    	alert("없는 날짜를 선택하셨습니다.")
		    	$("[name=member_birth]").val("");
		    	$("[name=member_birth]").focus();
		    	return;
		    }
	
		    else if(member_month == 2){
				var yoondal = (member_year % 4 == 0 && (member_year % 100 != 0 || member_year % 400 == 0));
				if(member_day > 29 || (member_day==29 && !yoondal)){
					alert("없는 날짜를 선택하셨습니다.")
			    	$("[name=member_birth]").val("");
			    	$("[name=member_birth]").focus();
			    	return;
				}
		    }
	
		    if(today.getTime() < member_date.getTime()){
		    	alert("현재날짜보다 미래를 선택하셨습니다.")
		       $("[name=member_birth]").val("");
			   $("[name=member_birth]").focus();
		        return;
		    }
	
			$.ajax({
				url : "${requestScope.croot}/memberRegProc.do",
				type: "post",
				data : $("[name=regForm]").serialize(),
				success : function(getInsertCnt){
					if(getInsertCnt == 1){
						alert("회원가입 성공!")
						document.goLoginForm.submit()
					}
					else if(getInsertCnt == -1){
						alert("중복된 아이디가 있습니다.")
						$("[name=member_ID]").val("");
						$("[name=member_ID]").focus();
						return;
					}
					
					else
						alert("회원가입 실패")
				},
				error : function(){
					alert("서버 접속 실패")
				}
			})
		} 
	
		function insa(){
			alert("안녕하세요 홈페이지 개발자 박인선입니다. 환영합니다!!")
		}
	
		function withoutLog(){
			alert('로그인 후 게시판 이용 가능합니다.')
			document.goLoginForm.submit()
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
					<li><a href="/board_memberMGMT/loginForm.do">로그인</a></li>
					<li class="active"><a href="/board_memberMGMT/memberRegForm.do">회원가입</a></li>
				</ul>				
			</li>
		</ul>
	</div>
</nav>

	
<form name="regForm" method="post" action="${requestScope.croot}/memberRegProc.do">
	<div class="container">
	<div class="col-lg-4"></div>
	<div class="col-lg-4">
		<div class="jumbotron" style="padding-top : 10px; padding-bottom: 10px;" >
			<h3 style="text-align: center;"><b>[회원가입]</b></h3><br>
			
			<!-- 아이디 입력 -->
			<h6 style="text-align: left;"><b>아이디</b></h6>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="아이디" name="member_ID" maxlength="20">
			</div>
			
			<!-- 비번 입력 -->
			<h6 style="text-align: left;"><b>비밀번호</b></h6>
			<div class="form-group">
				<input type="password" class="form-control" placeholder="비밀번호" name="member_pwd" maxlength="20">
			</div>
			
			<!-- 비번 입력 -->
			<h6 style="text-align: left;"><b>비밀번호 확인</b></h6>
			<div class="form-group">
				<input type="password" class="form-control" placeholder="비밀번호 확인" name="member_pwd_check" maxlength="20">
			</div>
			
			<!-- 이름입력 -->
			<h6 style="text-align: left;"><b>이름</b></h6>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="이름" name="member_name" maxlength="20">
			</div>
			
			<!-- 이메일 입력 -->
			<h6 style="text-align: left;"><b>이메일</b></h6>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="이메일" name="member_email" maxlength="20">
			</div>
			
			<!-- 생년월일 입력 -->
			<h6 style="text-align: left;"><b>생년월일</b></h6>
			<div class="form-group">
				<input type="text" class="form-control" placeholder="생년월일 8자리" name="member_birth" maxlength="8"  onkeydown='return onlyNumber(event)' onkeyup='removeChar(event)'>
			</div>
			
			<!-- 성별입력 -->
			<h5 style="text-align: center;"><b>성별</b></h5>
			<div class="form-group" style="text-align: center;">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-primary active">
						<input type="radio" name="gender_code" autocomplete="off" value="1" checked>남자
					</label>
					
					<label class="btn btn-primary">
						<input type="radio" name="gender_code" autocomplete="off" value="2">여자
					</label>
				</div>
			</div>
			
			<!-- 학력입력 -->
			<h5 style="text-align: center;"><b>최종학력</b></h5>
			<div class="form-group" style="text-align: center;">
				<div class="btn-group" data-toggle="buttons">
					<label class="btn btn-primary active">
						<input type="radio" name="school_code" autocomplete="off" value="1" checked>고졸
					</label>
					
					<label class="btn btn-primary">
						<input type="radio" name="school_code" autocomplete="off" value="2">전문대졸
					</label>
					
					<label class="btn btn-primary">
						<input type="radio" name="school_code" autocomplete="off" value="3">대졸
					</label>
				</div>
			</div>
			
			<!-- 종교입력 -->
			<h5 style="text-align: center;"><b>종교</b></h5>
			<div class="form-group" style="text-align: center;">
				<div class="btn-group" data-toggle="buttons">
				<select class="form-control" name="religion_code">
				  <option value="1">기독교</option>
				  <option value="2">불교</option>
				  <option value="3">천주교</option>
				  <option value="4">이슬람교</option>
				  <option value="5">무교</option>
				</select>
				</div>
			</div><br>
			<div>
				<input type="button" name="join" class="btn btn-success form-control" value="회원가입" onClick="checkRegisterForm()">
			</div><br>
			<div>
				<input type="button" name="join" class="btn btn-danger form-control" value="회원가입 취소" onClick="document.goLoginForm.submit()">
			</div>
		</div>
	</div>
</form>
	
<form name="goLoginForm" method="post" action="${requestScope.croot}/loginForm.do"></form>
	
</body>
</html>