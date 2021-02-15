package src.com.PFweb;

import java.util.List;
import java.util.Map;

public interface MemberService {
	
	// 회원가입을 하는 메소드
	public int getmemberRegForm(MemberDTO memberDTO);
	
	// 아이디가 중복이 되는지 확인 하는 메소드
	public List<Map<String, String>> getMemberList(MemberSearchDTO memberSearchDTO);
	
	// 회원이 정회원인지 확인하는 메소드 
	public int getmemberCheckCnt(Map<String, String> map);
	
	// select된 총 회원수 값을 받는 메소드
	int getBoardListAllCnt(MemberSearchDTO memberSearchDTO);

}
