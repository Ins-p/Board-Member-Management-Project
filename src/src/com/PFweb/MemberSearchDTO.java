package src.com.PFweb;

public class MemberSearchDTO {
	
	private String keyword;
	private String gender;
	private String school;
	private String religion;
	private String begin_year;
	private String begin_month;
	private String end_year;
	private String end_month;
	private int selectPageNo = 1;
	private int rowCntPerPage = 10;
	
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getSchool() {
		return school;
	}
	public void setSchool(String school) {
		this.school = school;
	}
	public String getReligion() {
		return religion;
	}
	public void setReligion(String religion) {
		this.religion = religion;
	}
	public String getBegin_year() {
		return begin_year;
	}
	public void setBegin_year(String begin_year) {
		this.begin_year = begin_year;
	}
	public String getBegin_month() {
		return begin_month;
	}
	public void setBegin_month(String begin_month) {
		this.begin_month = begin_month;
	}
	public String getEnd_year() {
		return end_year;
	}
	public void setEnd_year(String end_year) {
		this.end_year = end_year;
	}
	public String getEnd_month() {
		return end_month;
	}
	public void setEnd_month(String end_month) {
		this.end_month = end_month;
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
	
	
	

}
