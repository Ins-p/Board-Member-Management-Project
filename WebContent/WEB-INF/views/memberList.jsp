<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@include file="common.jsp" %>


<html>
<head><title>멤버목록</title>
	<script>	
		$(document).ready(function(){
			<c:if test="${sessionScope.admin_id != 'abc'}">
				alert("관리자만 접근 가능합니다.")
				document.boardList.submit();
			</c:if>
	
			var begin_year = $(".begin_year");
	        insertYear(begin_year, 1930);
	        
	        var begin_month = $(".begin_month");
	        insertMonth(begin_month); 
	
	        var end_year = $(".end_year");
	        insertYear(end_year, 1930);
	        
	        var end_month = $(".end_month");
	        insertMonth(end_month); 
	
	        $('[name=rowCntPerPage]').change(function( ){
				search_when_pageNoClick( );
			});
			
			$(".pagingNumber").html(
					getPagingNumber(
						"${requestScope.boardListAllCnt}"     
						,"${memberSearchDTO.selectPageNo}"      
						,"${memberSearchDTO.rowCntPerPage}"       
						,"10"                      
						,"search_when_pageNoClick();"             
					)
			);

			setTableTrBgColor(
					"boardTable"            
					, "#7FFFAA"                
					, "white"                 
					, "#FFFAF0"		    
					, "lightblue"          
			);
	
			inputData("[name=keyword]", "${requestScope.memberSearchDTO.keyword}");
			inputData("[name=gender]", "${requestScope.memberSearchDTO.gender}");
			inputData("[name=school]", "${requestScope.memberSearchDTO.school}");
			inputData("[name=religion]", "${requestScope.memberSearchDTO.religion}");
			inputData("[name=begin_year]", "${requestScope.memberSearchDTO.begin_year}");
			inputData("[name=begin_month]", "${requestScope.memberSearchDTO.begin_month}");
			inputData("[name=end_year]", "${requestScope.memberSearchDTO.end_year}");
			inputData("[name=end_month]", "${requestScope.memberSearchDTO.end_month}");
			inputData(".selectPageNo", "${requestScope.memberSearchDTO.selectPageNo}");
			inputData(".rowCntPerPage", "${requestScope.memberSearchDTO.rowCntPerPage}");
		})
	
		function checkListForm(member_no, memberCheck){
			$("[name=member_no]").val(member_no);
			$("[name=memberCheck]").val(memberCheck);
			 $.ajax({
				url : "${requestScope.croot}/memberCheckProc.do",
				type : "post",
				data : $("[name=memberList]").serialize(),
				success : function(update_cnt){
					if(update_cnt == 1){
						alert("체크가 되어 있으면 로그인이 가능합니다.")
					}
					else
						alert("회원여부 변경실패")
				},
				error : function(){
					alert("서버 접속 실패")
				}
			})
		}
	
		function search(){
			var cnt = 0;
			if(isEmpty($("[name=keyword]")) == false){cnt++}
			if(isEmpty($("[name=gender]")) == false){cnt++}
			if(isEmpty($("[name=school]")) == false){cnt++}
			if(isEmpty($("[name=religion]")) == false){cnt++}
			if(isEmpty($("[name=begin_year]")) == false){cnt++}
			if(isEmpty($("[name=begin_month]")) == false){cnt++}
			if(isEmpty($("[name=end_year]")) == false){cnt++}
			if(isEmpty($("[name=end_month]")) == false){cnt++}
			
			if(cnt == 0){
				alert("1개 이상 항목을 검색하셔야 합니다.")
				return;
			}
	
			var beginCnt = 0;
			if(isEmpty($("[name=begin_year]")) == false){beginCnt++}
			if(isEmpty($("[name=begin_month]")) == false){beginCnt++}
			if(beginCnt == 1){
				alert("최소날짜의 년과 월을 전부 입력해주세요")
				return;
			}
	
			var endCnt = 0;
			if(isEmpty($("[name=end_year]")) == false){beginCnt++}
			if(isEmpty($("[name=end_month]")) == false){beginCnt++}
			if(endCnt == 1){
				alert("최대날짜의 년과 월을 전부 입력해주세요")
				return;
			}
	
			document.memberList.submit();
		}
	
	function checkDate(){
			var begin_year = $(".begin_year").val();
	        var begin_month = $(".begin_month").val();
	        var end_year = $(".end_year").val();
	        var end_month = $(".end_month").val();
	
	        var begin_date = new Date(
	            parseInt(begin_year, 10),
	            parseInt(begin_month, 10)-1
	        );
	
	        var end_date = new Date(
	            parseInt(end_year, 10),
	            parseInt(end_month, 10)-1
	        );
	
	        var today = new Date();
	
	        if(today.getTime() < begin_date.getTime()){
	        	alert("현재날짜보다 미래를 선택하셨습니다.")
	            $(".begin_year").val("");
	        	$(".begin_month").val("");
	            return;
	        }
	
	        else if(today.getTime() < end_date.getTime()  ){
	        	alert("현재날짜보다 미래를 선택하셨습니다.")
	            $(".end_year").val("");
	        	$(".end_month").val("");
	            return;
	        }
	
	        if(end_date.getTime() < begin_date.getTime()){
	        	alert("최소날짜가 최대날짜보다 큽니다.")
	            $(".begin_year").val("");
	        	$(".begin_month").val("");
	        	$(".end_year").val("");
	        	$(".end_month").val("");
	        }
		}
	
		function search_when_pageNoClick( ){
				document.memberList.submit();
			}
		
		function searchAll(){
			$("[name=selectPageNo]").val("1");
			$("[name=keyword]").val("");
			$("[name=gender]").val("");
			$("[name=school]").val("");
			$("[name=religion]").val("");
			$("[name=begin_year]").val("");
			$("[name=begin_month]").val("");
			$("[name=end_year]").val("");
			$("[name=end_month]").val("");
			
			document.memberList.submit( );
		}
	
		function insa(){
			alert("안녕하세요 홈페이지 개발자 박인선입니다. 환영합니다!!")
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

<form name="memberList" method="post" action="${requestScope.croot}/memberList.do">
	<div class="container">
		<div class="jumbotron" style="padding-top : 10px;">
		<h3 style="text-align: center;">[회원정보 검색]</h3>
		<table class="table table1-bordered">
			<input type="hidden" name="selectPageNo" class="selectPageNo">  
			<input type="hidden" name="rowCntPerPage" class="rowCntPerPage">  

			<tr bgcolor="white">
				<th bgcolor="#7FFFAA" style="text-align: center"><b><br>아이디/이름/이메일</b></th>
				<div class="form-group">
					<td align=center colspan="4"><input type="text" name="keyword" class="form-control" size="20" ></td> 
				</div>
			</tr>
			
			<tr bgcolor="white">
				<th bgcolor="#7FFFAA" style="text-align: center"><b><br>성별</b>
				<td width="420px;">
					<div class="form-group" style="text-align: center;" >
						<div class="btn-group" data-toggle="buttons">
						<c:if test="${memberSearchDTO.gender != 1 and memberSearchDTO.gender != 2}">
							<label class="btn btn-default">
								<input type="radio" name="gender" autocomplete="off" value="1">남자
							</label>
							<label class="btn btn-default">
								<input type="radio" name="gender" autocomplete="off" value="2">여자
							</label>
						</c:if>
						
						<c:if test="${memberSearchDTO.gender == 1 }">
							<label class="btn btn-default active">
								<input type="radio" name="gender" autocomplete="off" value="1">남자
							</label>
							<label class="btn btn-default">
								<input type="radio" name="gender" autocomplete="off" value="2">여자
							</label>
						</c:if>
						
						<c:if test="${memberSearchDTO.gender == 2 }">
							<label class="btn btn-default">
								<input type="radio" name="gender" autocomplete="off" value="1">남자
							</label>
							<label class="btn btn-default active">
								<input type="radio" name="gender" autocomplete="off" value="2">여자
							</label>
						</c:if>
						</div>
					</div>
				</td>
				
				<th bgcolor="#7FFFAA" style="text-align: center"><br>학력</th>
				<td>
					<div class="form-group" style="text-align: center;">
						<div class="btn-group" data-toggle="buttons">
						
						<c:if test="${memberSearchDTO.school != 1 and memberSearchDTO.school != 2 and memberSearchDTO.school != 3}">
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "1"> 고졸
							</label>
							
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "2"> 전문대졸
							</label>
							
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "3"> 일반대졸
							</label>
						</c:if>
	
						
						<c:if test="${memberSearchDTO.school == 1}">
							<label class="btn btn-default active">
								<input type="radio" name="school" class="school" value = "1"> 고졸
							</label>
							
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "2"> 전문대졸
							</label>
							
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "3"> 일반대졸
							</label>
						</c:if>
						
						<c:if test="${memberSearchDTO.school == 2}">
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "1"> 고졸
							</label>
							
							<label class="btn btn-default active">
								<input type="radio" name="school" class="school" value = "2"> 전문대졸
							</label>
							
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "3"> 일반대졸
							</label>
						</c:if>
						
						<c:if test="${memberSearchDTO.school == 3}">
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "1"> 고졸
							</label>
							
							<label class="btn btn-default">
								<input type="radio" name="school" class="school" value = "2"> 전문대졸
							</label>
							
							<label class="btn btn-default active">
								<input type="radio" name="school" class="school" value = "3"> 일반대졸
							</label>
						</c:if>
						</div>
					</div>
				</td>				
			</tr>
			
			<tr bgcolor="white">
				<th bgcolor="#7FFFAA" style="text-align: center;  width: 100px;"><br>종교
				<td>
					<div class="form-group" style="text-align: center ;">
						<div class="btn-group" data-toggle="buttons">
						<select class="form-control" name="religion">
						  <option></option>
						  <option value="1">기독교</option>
						  <option value="2">천주교</option>
						  <option value="3">불교</option>
						  <option value="4">이슬람교</option>
						  <option value="5">무교</option>
						</select>
						</div>
					</div><br>
				</td>
           		<th bgcolor="#7FFFAA"style="text-align: center;"><b><br>생년월일</b>
	            <td colspan="5"><br>
		            <div style="text-align: center">
		               <select name="begin_year" class="begin_year"> 
		                   <option value=""></option>
		               </select>  년
						
		               <select name="begin_month" class="begin_month" onchange="checkDate()">
		                    <option value=""></option>
		               </select>  월
		                
		                ~
		                
		                 <select name="end_year" class="end_year"> 
		                   <option value=""></option>
		               </select>  년
		
		               <select name="end_month" class="end_month" onchange="checkDate()">
		                    <option value=""></option>
		               </select>  월
					</div>
	            </td> 
			</tr>
		</table>
			<input type="button" value="검색" class="contactSearch" onClick="search();">
			<input type="button" value="초기화" class="contactSearchAll" onClick="searchAll();">

			<div class="boardListAllCnt" style="text-align: left">[총 회원 수] : ${requestScope.boardListAllCnt}</div>
			<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div>
			
			<table class="boardTable table table-striped">
				<tr>
					<th style="text-align: center;">일련 번호</th>
					<th style="text-align: center;">회원 번호</th>
					<th style="text-align: center;">회원 ID</th>
					<th style="text-align: center;">비밀번호</th>
					<th style="text-align: center;">이름</th>
					<th style="text-align: center;">이메일</th>
					<th style="text-align: center;">생일</th>
					<th style="text-align: center;">성별</th>
					<th style="text-align: center;">최종학력</th>
					<th style="text-align: center;">종교</th>
					<th style="text-align: center;">가입일</th>
					<th style="text-align: center;">회원여부</th>
				<c:forEach items="${memberList }" var="member" varStatus="loopTagStatus">
					<tr>
						<td align=center>${member.rnum }</td>
						<td align=center>${member.member_no }</td>
						<td align=center>${member.member_ID }</td>
						<td align=center>${member.member_pwd }</td>
						<td align=center>${member.member_name }</td>
						<td align=center>${member.member_email }</td>
						<td align=center>${member.member_birth }</td>
						<td align=center>${member.gender_name }</td>
						<td align=center>${member.school_name }</td>
						<td align=center>${member.religion_name }</td>
						<td align=center>${member.reg_date }</td>
						<c:if test="${member.memberCheck=='true'}">
							<td align=center><input type="checkbox"  onClick="checkListForm(${member.member_no}, ${member.memberCheck})" checked></td>
						</c:if>
						
						<c:if test="${member.memberCheck=='false'}">
							<td align=center><input type="checkbox"  onClick="checkListForm(${member.member_no}, ${member.memberCheck})"></td>
						</c:if>		
					</tr>
				</c:forEach>
		</table>
		<c:if test="${empty requestScope.memberList}">
				<h5>검색 조건에 맞는 데이터가 없습니다.</h5>
		</c:if>
		</div>
	</div>
</form>

<form name="boardList" method="post" action="${requestScope.croot}/boardList.do"></form>

</body>
</html>		


