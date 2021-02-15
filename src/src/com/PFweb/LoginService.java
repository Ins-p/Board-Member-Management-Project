package src.com.PFweb;

import java.util.Map;

public interface LoginService {
	
	// ID를 확인하는 메소드 호출
	public int getAdminIdCnt(Map<String, String> admin_id_pwd);
}
