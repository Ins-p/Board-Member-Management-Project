<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@include file="common.jsp" %>

<html>
<head><title>게시판 목록</title>
	<script>	
		$(document).ready(function( ){
			$('[name=boardContentForm], [name=boardRegForm]').hide();
			$('[name=rowCntPerPage]').change(function( ){
				search_when_pageNoClick( );
			});
			
			inputData(".keyword1", "${requestScope.boardSearchDTO.keyword1}");
			inputData(".selectPageNo", "${requestScope.boardSearchDTO.selectPageNo}");
			inputData(".rowCntPerPage", "${requestScope.boardSearchDTO.rowCntPerPage}");
			inputData(".orderby", "${requestScope.boardSearchDTO.orderby}");

			<c:if test = "${empty requestScope.boardSearchDTO.orderby}">
				$(".readCnt").text("조회수");
			</c:if>
			
			<c:if test = "${requestScope.boardSearchDTO.orderby == 'readcount desc'}">
				$(".readCnt").text("조회수▼");
			</c:if>
			
			<c:if test = "${requestScope.boardSearchDTO.orderby == 'readcount asc'}">
				
				$(".readCnt").text("조회수▲");
			</c:if>
			
			<c:forEach items="${boardSearchDTO.date}" var = "date">
				inputData("[name=boardListForm] [name=date]", "${date}");
			</c:forEach>

			$(".pagingNumber").html(
					getPagingNumber(
						"${requestScope.boardListAllCnt}"      
						,"${requestScope.boardSearchDTO.selectPageNo}"        
						,"${requestScope.boardSearchDTO.rowCntPerPage}"      
						,"15"                       
						,"search_when_pageNoClick( );"              
					)
			);
			
			setTableTrBgColor(
					"boardTable"             
					, "#7FFFAA"                 
					, "white"                        
					, "#FFFAF0"		      
					, "lightblue"           
			);

			inputBlank_to_tdth( ".boardTable", 3  );
			<c:if test="${sessionScope.admin_id == 'abc'}">
				$(".readCnt").click(function(){
					var txt = $(this).text();
					if( txt == "조회수"){
						$(".orderby").val("readcount desc");
					}
					
					else if( txt == "조회수▼"){
						$(".orderby").val("readcount asc")
					}
					
					else if( txt == "조회수▲"){
						$(".orderby").val("");
					}
					
					document.boardListForm.submit();
				}) 
			</c:if>
		});
		

		function goBoardRegForm( ){
			$("[name=boardRegForm] [name=selectPageNo]").val( 
				$("[name=boardListForm] [name=selectPageNo]").val( )
			);
	
			$("[name=boardRegForm] [name=rowCntPerPage]").val( 
				$("[name=boardListForm] [name=rowCntPerPage]").val( )
			);
			
			$("[name=boardRegForm] [name=keyword1]").val( 
				$("[name=boardListForm] [name=keyword1]").val( )
			);
			
		 	$("[name=boardListForm] [name=date]").filter(":checked").each(function(){
				var value= $(this).val();
				$("[name=boardRegForm] [name=date]").filter("[value="+value+"]").prop("checked", true);
			});
			
			document.boardRegForm.submit();
		}

		function goContentForm(b_no){
			$("[name=boardContentForm] [name=selectPageNo]").val( 
				$("[name=boardListForm] [name=selectPageNo]").val( )
			);
		
			$("[name=boardContentForm] [name=rowCntPerPage]").val( 
				$("[name=boardListForm] [name=rowCntPerPage]").val( )
			);
			
			$("[name=boardContentForm] [name=keyword1]").val( 
				$("[name=boardListForm] [name=keyword1]").val( )
			);
			
			$("[name=boardContentForm] [name=b_no]").val(b_no);
			
			$("[name=boardListForm] [name=date]").filter(":checked").each(function(){
				var value= $(this).val();
				$("[name=boardContentForm] [name=date]").filter("[value="+value+"]").prop("checked", true);
			});
		
			document.boardContentForm.submit();
		}

		function goMemberListForm(){
			document.memberList.submit();
		}

		function search_when_pageNoClick(){
			var keyword1 = $("[name=keyword1]").val();
			if( keyword1!=null && keyword1.split(" ").join("")!="" ){
				keyword1 = $.trim(keyword1);
				$("[name=keyword1]").val(keyword1);
			}
			document.boardListForm.submit( );
		}
	
		function search(){
			var keyword1 = $("[name=keyword1]").val();
			if(isEmpty($("[name=keyword1]")) && isEmpty($("[name=date]"))){
				alert("검색 조건이 비어 있어 검색할 수 없습니다.");
				$("[name=keyword1]").val("");
				return;
			}
			keyword1 = $.trim(keyword1);
			$("[name=keyword1]").val(keyword1);
			document.boardListForm.submit( );
		}

		function searchAll(){
			$("[name=selectPageNo]").val("1");
			$("[name=keyword1]").val("");
			$("[name=date]").prop("checked", false);
			document.boardListForm.submit( );
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

<form name="boardListForm" method="post" action="${requestScope.croot}/boardList.do">   
    <div class="container">
		<div class="jumbotron" style="padding-top : 10px;">
					<h3 style="text-align: center;">[게시판]</h3>
			<table class="boardTable table table-striped">
				<div style="text-align: right">
				<select name="rowCntPerPage" class="rowCntPerPage" style="text-align: right">
					<option value="10">10 행</option>
					<option value="15">15 행</option>
					<option value="20">20 행</option>
					<option value="25">25 행</option>
					<option value="30">30 헹</option>
				</select>
				<div class="boardListAllCnt" style="text-align: left">[총 게시글 수] : ${requestScope.boardListAllCnt}</div>
				<tr>
					<th style="text-align: center;">번호</th>
					<th style="text-align: center;">제목</th>
					<th style="text-align: center;">글쓴이</th>
					<th style="text-align: center;">등록일</th>
					<c:if test="${sessionScope.admin_id == 'abc'}">
						<th><span class="readCnt" name="readCnt" style="cursor:pointer">조회수</span>
					</c:if>
					
					<c:if test="${sessionScope.admin_id != 'abc'}">
						<th><span class="readCnt" name="readCnt">조회수</span>
					</c:if>
					
					<c:forEach items="${requestScope.boardList}" var="board" varStatus="loopTagStatus">
						<tr style="cursor:pointer" onClick="goContentForm(${board.b_no});">
							<td align=center>				
								${boardListAllCnt-(boardSearchDTO.selectPageNo*boardSearchDTO.rowCntPerPage-boardSearchDTO.rowCntPerPage+1+loopTagStatus.index)+1}
							</td>
							
							<td>
								<c:if test="${board.print_level>0}">
									<c:forEach begin="0" end="${board.print_level}">
										&nbsp;&nbsp;
									</c:forEach>
									ㄴ
								</c:if>
								${board.subject}
							</td>
							<td align=center>${board.writer}</td>
							<td align=center>${board.reg_date}</td>
							<td style="text-align: center;">${board.readcount}</td> 
					</c:forEach>
			</table>
			
			<c:if test="${empty requestScope.boardList}">
				<h5>검색 조건에 맞는 데이터가 없습니다.</h5>
			</c:if>
			<div>&nbsp;<span class="pagingNumber"></span>&nbsp;</div><br>
			[키워드] : <input type="text" name="keyword1" class="keyword1">&nbsp;&nbsp;&nbsp;
			<input type="button" value="검색" class="contactSearch" onClick="search( );">&nbsp;
			<input type="button" value="     모두검색     " class="contactSearchAll" onClick="searchAll( );">&nbsp;
			<a href="javascript:goBoardRegForm( );" >[새글쓰기]</a>
		</div>
	</div>

	<div>
		<input type="hidden" name="selectPageNo" class="selectPageNo">			
		<input type="hidden" name="orderby" class="orderby"> 
	</div>
</form>

<form name="boardContentForm" method="post" action="${requestScope.croot}/boardContentForm.do">
	<input type="hidden" name="b_no">
	<input type="hidden" name="selectPageNo">  
	<input type="hidden" name="rowCntPerPage">  
	<input type="hidden" name="keyword1">  
	<input type="checkbox" name="date" value="오늘">  
	<input type="checkbox" name="date" value="어제">  
</form>

<form name="boardRegForm" method="post" action="${requestScope.croot}/boardRegForm.do">
	<input type="hidden" name="selectPageNo">  
	<input type="hidden" name="rowCntPerPage">  
	<input type="hidden" name="keyword1"> 
	<input type="checkbox" name="date" value="오늘">   
	<input type="checkbox" name="date" value="어제">  
</form>

<form name="memberList" method="post" action="${requestScope.croot}/memberList.do"></form>
	
</body>
</html>		


