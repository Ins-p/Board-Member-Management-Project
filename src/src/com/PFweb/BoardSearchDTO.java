package src.com.PFweb;

import java.util.List;

public class BoardSearchDTO {
	
	private String keyword1 = "";
	
	// 현재 선택된 페이지 번호를 저장하는 속성변수 선언
	// 속성변수 selectPageNo는 select 구문으로 DB연동시 가져올 행의 범위에 사용되는 데이터
	// 기본 값으로 1로 세팅
	private int selectPageNo = 1;
	
	// 한 화면에 보여줄 행의 개수를 저장하는 속성변수 선언
	// 속성변수 rowCntPerPage는 select 구문으로 DB연동시 가져올 행위 범위에 사용되는 데이터
	// 기본 값으로 15로 세팅
	private int rowCntPerPage = 10;
	
	// 오늘을 검색할 때 값을 저장하는 속성변수 선언
	private String[] date;
	
	// 조회수 정렬 기준을 저장하는 속성변수 선언
	private String orderby;

	public String getKeyword1() {
		return keyword1;
	}

	public void setKeyword1(String keyword1) {
		this.keyword1 = keyword1;
	}

	public int getSelectPageNo() {
		return selectPageNo;
	}

	public void setSelectPageNo(int selectPageNo) {
		this.selectPageNo = selectPageNo;
	}

	public int getRowCntPerPage() {
		return rowCntPerPage;
	}

	public void setRowCntPerPage(int rowCntPerPage) {
		this.rowCntPerPage = rowCntPerPage;
	}

	public String[] getDate() {
		return date;
	}

	public void setDate(String[] date) {
		this.date = date;
	}

	public String getOrderby() {
		return orderby;
	}

	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}


	
	
}
