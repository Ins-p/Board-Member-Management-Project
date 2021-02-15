package src.com.PFweb;

import java.util.Map;

public interface LoginDAO {
	
	// adminID인지 확인 하는 메소드
	public int getAdminIdCnt(Map<String, String> admin_id_pwd);
	
	// 회원가입을한 일반 멤버인지 확인 하는 메소드
	public int getMemberIdCnt(Map<String, String> admin_id_pwd);
		
}
