package src.com.PFweb;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class LoginServiceImpl implements LoginService{
	
	@Autowired
	private LoginDAO loginDAO;
	
	public int getAdminIdCnt(Map<String, String> admin_id_pwd) {
		
		// adminID인지 확인 하기 위해 DAO 호출
		int adminCnt = loginDAO.getAdminIdCnt(admin_id_pwd);
		if(adminCnt == 1) {
			return 2;
		}
		
		// memberID인지 확인 하기 위해 DAO 호출
		int memberCnt = loginDAO.getMemberIdCnt(admin_id_pwd);
		return memberCnt;	
	}
}
