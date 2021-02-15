package src.com.PFweb;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

// DAO클래스인 LoginDAOImpl 클래스 선언
	// @Repository를 붙임으로써 DAO클래스 임을 지정하게 되고,
	// bean 태그로 자동 등록된다.

@Repository
public class LoginDAOImpl implements LoginDAO{

	@Autowired
	private SqlSessionTemplate sqlSession; 
	
	// adminID인지 확인 하는 메소드
	public int getAdminIdCnt(Map<String, String> admin_id_pwd) {
		int adminCnt = this.sqlSession.selectOne(
				"src.com.PFweb.LoginDAO.getAdminIdCnt",   
				admin_id_pwd
		);		
		return adminCnt;
	}
	
	// 회원가입을한 일반 멤버인지 확인 하는 메소드
	public int getMemberIdCnt(Map<String, String> admin_id_pwd) {
		int memberCnt = this.sqlSession.selectOne(
				"src.com.PFweb.LoginDAO.getMemberIdCnt",   
				admin_id_pwd
		);
		return memberCnt;
	}
}
