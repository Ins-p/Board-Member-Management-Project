

// 페이징 처리 함수
function getPagingNumber(
	totRowCnt               
	, selectPageNo_str         
	, rowCntPerPage_str    
	, pageNoCntPerPage_str  
	, jsCodeAfterClick      
) {

	if( $('[name=selectPageNo]').length==0 ){
		alert("name=selectPageNo 을 가진 hidden 태그가 있어야 getPagingNumber(~) 함수 호출이 가능함.');" );
		return;
	}
	var arr = [];
	try{
		if( totRowCnt==0 ){	return ""; }
		if( jsCodeAfterClick==null || jsCodeAfterClick.length==0){
			alert("getPagingNumber(~) 함수의 5번째 인자는 존재하는 함수명이 와야 합니다");
			return "";
		}

		if( selectPageNo_str==null || selectPageNo_str.length==0 ) {
			selectPageNo_str="1";  
		}
		if( rowCntPerPage_str==null || rowCntPerPage_str.length==0 ) {
			rowCntPerPage_str="10";  
		}
		if( pageNoCntPerPage_str==null || pageNoCntPerPage_str.length==0 ) {
			pageNoCntPerPage_str="10";  
		}

		var selectPageNo = parseInt(selectPageNo_str, 10);
		var rowCntPerPage = parseInt(rowCntPerPage_str,10);
		var pageNoCntPerPage = parseInt(pageNoCntPerPage_str,10);
		if( rowCntPerPage<=0 || pageNoCntPerPage<=0 ) { return; }

		var maxPageNo=Math.ceil( totRowCnt/rowCntPerPage );
			if( maxPageNo<selectPageNo ) { selectPageNo = 1; }

		var startPageNo = Math.floor((selectPageNo-1)/pageNoCntPerPage)*pageNoCntPerPage+1;  
		var endPageNo = startPageNo+pageNoCntPerPage-1;                                    
			if( endPageNo>maxPageNo ) { endPageNo=maxPageNo; }
		
		var cursor = " style='cursor:pointer' ";
		
		if( startPageNo>pageNoCntPerPage ) {
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('1');"
							+jsCodeAfterClick+";\">[처음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
				+(startPageNo-1)+"');"+jsCodeAfterClick+";\">[이전]</span>   " );
		}
	
		for( var i=startPageNo ; i<=endPageNo; ++i ){
			if(i>maxPageNo) {break;}
			if(i==selectPageNo || maxPageNo==1 ) {
				arr.push( "<b>"+i +"</b> " );
			}else{
				arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
							+(i)+"');"+jsCodeAfterClick+";\">["+i+"]</span> " );
			}
		}
	
		if( endPageNo<maxPageNo ) {
			arr.push( "   <span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(endPageNo+1)+"');"+jsCodeAfterClick+";\">[다음]</span>" );
			arr.push( "<span "+cursor+" onclick=\"$('[name=selectPageNo]').val('"
						+(maxPageNo)+"');"+jsCodeAfterClick+";\">[마지막]</span>" );
		}
		
		return arr.join( "" );
	}catch(ex){
		alert("getPagingNumber(~) 메소드 호출 시 예외발생!");
		return "";
	}
}


// 페이징 처리 함수
function printPagingNumber(

	totRowCnt               
	, selectPageNo_str        
	, rowCntPerPage_str     
	, pageNoCntPerPage_str 
	, jsCodeAfterClick     
) {
	document.write(
		getPagingNumber(
			totRowCnt            
			, selectPageNo_str        
			, rowCntPerPage_str   
			, pageNoCntPerPage_str 
			, jsCodeAfterClick     
		)
	);
}


// 테이블 색깔 지정 함수 
function setTableTrBgColor(
		tableClassV			
		, headerColor		
		, oddBgColor		
		, evenBgColor	
		, mouseOnBgColor 
){
	try{
		var firstTrObj = $("."+tableClassV+" tr:eq(0)");
		var trObjs = firstTrObj.siblings("tr");
		firstTrObj.css("background",headerColor);
		trObjs.filter(":odd").css("background",evenBgColor);
		trObjs.filter(":even").css("background",oddBgColor);

		trObjs.hover(
				function( ){
					$(this).css("background",mouseOnBgColor);
				},
				function( ){
					if( $(this).index( )%2==0 ){
						$(this).css("background",evenBgColor);
					}else{
						$(this).css("background",oddBgColor);
					}
				}
		);
	}catch(e){
		alert("setTableTrBgColor( ~ ) 함수호출  시 에러 발생!");
	}
}

//  입력양식이 비어 있거나 미체크 시 true 리턴 함수 
function isEmpty( jqueryObj ){
	try{	
		var flag = true;
		if(  jqueryObj.is(":checkbox") || jqueryObj.is(":radio")  ){
			if(jqueryObj.filter(":checked").length>0){ flag = false; }
		}
		else{
			var value = jqueryObj.val( );
			if( value!=null && value.split(" ").join("")!="" ){
				flag=false;
			}
		}
		return flag;
	}catch(e){
		alert("isEmpty( ~ ) 함수호출  시 에러 발생! " + e.message );
		return false;
	}
}

//  입력양식이 비어 있거나 미체크 시 경고하고 true 리턴 함수 
function checkEmpty( selector, alertMsg ){
	try{	
		var jqueryObj = $(selector);
		if( isEmpty( jqueryObj )  ){
			alert(alertMsg);
			if( jqueryObj.is(":checkbox")==false && jqueryObj.is(":radio")==false ){
				jqueryObj.val("");
				jqueryObj.focus( );
			}
			return true;
		}else {
			return false;
		}
	}catch(e){
		alert("checkEmpty( ~, ~ ) 함수호출  시 에러 발생! "+ e.message );
		return false;
	}
}

//  입력양식의 value 값이 패턴에 맞지 않으면 경고하고 true 리턴 함수 
function checkPattern( selector, regExpObj , alertMsg ){
	try{	
		var jqueryObj = $(selector);
		var value = jqueryObj.val();
		if( regExpObj.test(value)==false ) {
			alert(alertMsg);
			jqueryObj.val("");
			return true
		}
		else{
			return false;
		}
	}catch(e){
		alert("checkPattern( ~, ~ ) 함수호출  시 에러 발생!");
		return false;
	}
}	


//  table 태그 내부의 각 th 또는 td 내부의 문자 앞뒤에 원하는 개수의 공백 넣어주는 함수 
function inputBlank_to_tdth( table_selector, blankCnt  ){
	try{	
		var blankStr = "";
		for(var i=1 ; i<=blankCnt ; i++){
			blankStr = blankStr + "&nbsp;"
		}
		var tableObj = $(table_selector);
		tableObj.find("td,th").each(function(){
			var thTdObj = $(this);
			thTdObj.html(
				blankStr + thTdObj.html() + blankStr
			);
		});

	}catch(e){
		alert("inputBlank_to_tdth( ~, ~ ) 함수호출  시 에러 발생!");
	}
}

// 입력양식에 value 값을 삽입하거나 체크해주는 함수 
function inputData(selector, data){
	try{
		if(data == null || data == undefined){
			return;
		}
		
		if((data + "").split(" ").join("") == ""){
			return;
		}
		
		var obj = $(selector);
		
		if(obj.length == 0){
			alert("inputData('"+selector+"','"+data+"' ) 함수 호출 시 ["+selector+"]란 선택자가 가르키는 입력양식이 없습니다.");
			return;
		}
		
		if(obj.is(":checkbox") || obj.is(":radio")){
			obj.filter("[value='"+data+"']").prop("checked", true);
		}
		
		else{
			obj.val(data);
		}
		
	}catch(e){
		alert("inputData('"+selector+"','"+data+"' ) 함수 호출 시 에러 발생!");
	}
}


// checkbox 또는 radio의 체크 개수 구하는 함수 선언 
function getCheckedCnt(selector){
	var jqueryObj = $(selector);
	if(jqueryObj.length == 0){
		alert("선택자" + selector + " 가 가르키는 입력양식이 없습니다.");
		return 0;
		
	}
	return jqueryObj.filter(":checked").length;
}

// 입력양식의 value 값을 리턴하는 함수
function getValue(selector){
	
	var jqueryObj = $(selector);
	
	if(jqueryObj.length == 0){
		alert("선택자" + selector + " 가 가르키는 입력양식이 없습니다.");
		return "";
	}
	
	var result = "";
	if(jqueryObj.is(":checkbox")){
		if(jqueryObj.filter(":checked").length > 0)
			result = [];
			jqueryObj.filter(":checked").each(function(){
				result.push($(this).val());
			});
	}
	
	else if(jqueryObj.is(":radio")){
		if(jqueryObj.is(":checked")){
			jqueryObj.val();
		}
	}
	
	else{
		if(isEmpty(jqueryObj) == false){
			result = jqueryObj.val();
		}
	}
	return result;
}








