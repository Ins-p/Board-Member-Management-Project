package src.com.PFweb;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO{
	
	@Autowired
	private SqlSessionTemplate sqlsession;
	
	// 아이디가 중복이 되는지 확인 하는 메소드
	public int getMemberCnt(MemberDTO memberDTO) {
		int memberRegCnt = this.sqlsession.selectOne(
				"src.com.PFweb.MemberDAO.getMemberCnt",
				memberDTO
		);
		return memberRegCnt;
	}
	
	// 회원가입을 하는 메소드
	public int getmemberRegForm(MemberDTO memberDTO) {
		int checkMemberCnt = this.sqlsession.insert(
				"src.com.PFweb.MemberDAO.getmemberRegForm",
				memberDTO
		);
		return checkMemberCnt;
	}
	
	// 회원관리 페이지의 회원 리스트 구현하는 메소드
	public List<Map<String, String>> getMemberList(MemberSearchDTO memberSearchDTO){
		List<Map<String, String>> memberList = this.sqlsession.selectList(
				"src.com.PFweb.MemberDAO.getMemberList",
				memberSearchDTO
		);
		return memberList;	
	}
	
	// 회원이 정회원인지 확인하는 메소드 
	public int getmemberCheckCnt(Map<String, String> map) {
		int memberCheckCnt = this.sqlsession.update(
				"src.com.PFweb.MemberDAO.getmemberCheckCnt",
				map
		);
		return memberCheckCnt;
	}
	
	// select된 총 회원수 값을 받는 메소드
	public int getBoardListAllCnt(MemberSearchDTO memberSearchDTO) {
		int boardListAllCnt = this.sqlsession.selectOne(
				"src.com.PFweb.MemberDAO.getBoardListAllCnt",
				memberSearchDTO
		);
		return boardListAllCnt;
	}
}
