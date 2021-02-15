package src.com.PFweb;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDAO memberDAO;
	
	// 회원가입을 하는 메소드
	public int getmemberRegForm(MemberDTO memberDTO) {
		
		// 아이디가 중복이 되는지 확인 하기 위해 DAO 호출
		int checkMemberCnt = this.memberDAO.getMemberCnt(memberDTO);
		if(checkMemberCnt > 0) {
			return -1;
		}
		
		// 회원가입을 하기 위해 DAO 호출
		int memberRegCnt = this.memberDAO.getmemberRegForm(memberDTO);	
		return memberRegCnt;
	}
	
	// 회원관리 페이지의 회원 리스트 구현하는 메소드
	public List<Map<String, String>> getMemberList(MemberSearchDTO memberSearchDTO){
		
		// 회원관리 페이지의 회원 리스트를 구현하기 위해 DAO호출 
		List<Map<String, String>> memberList = this.memberDAO.getMemberList(memberSearchDTO);
		return memberList;
	}
	
	// 회원이 정회원인지 확인하는 메소드 
	public int getmemberCheckCnt(Map<String, String> map) {
		
		// 해당 회원이 정회원인지 확인하기 위해 DAO 호출
		int memberCheckCnt = this.memberDAO.getmemberCheckCnt(map);
		return memberCheckCnt;
	}
	
	// select된 총 회원수 값을 받는 메소드
	public int getBoardListAllCnt(MemberSearchDTO memberSearchDTO) {
		
		// select된 총 회원수 값을 받기 위해 DAO 호출
		int boardListAllCnt = this.memberDAO.getBoardListAllCnt(memberSearchDTO);
		return boardListAllCnt;
	}

}
