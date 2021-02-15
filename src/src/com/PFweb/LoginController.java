package src.com.PFweb;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller

public class LoginController {
	
	@Autowired
	private LoginService loginService;
	
	// ----- 로그인 페이지 -----
	@RequestMapping(value = "/loginForm.do")
	public ModelAndView loginForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/loginForm.jsp");
		return mav;
	}
	
	// ----- 로그인에서 입력된 ID와 PWD 값을 확인하는 페이지 -----
	@RequestMapping(value="/loginProc.do",
					method=RequestMethod.POST, 
					produces="application/json; charset=UTF-8")
	@ResponseBody
	public int getAdminIdCnt(@RequestParam(value="admin_id") String admin_id, 
							  @RequestParam(value="pwd") String pwd,
							  @RequestParam(value="is_login",
									  		required=false) String is_login,
							  HttpSession session,
							  HttpServletResponse response) {
		
		// Mybatis에서 입력된 id와 pwd를 확인 하기 위해 HashMap에 데이터 put
		Map<String, String> map = new HashMap<String, String>();
		map.put("admin_id", admin_id);
		map.put("pwd", pwd);
		
		int admin_idCnt = 0;
		
		// id와 pwd를 put한 HashMap을 확인하기 위해 service 호출
		admin_idCnt = this.loginService.getAdminIdCnt(map);
		
		if(admin_idCnt > 0) {
			
			// 로그인에 성공하면 "admin_id" 키 값에 id를 저장
			session.setAttribute("admin_id", admin_id);
			
			// 매개변수 is_login에 null이 저장되어 있으면 아이디, 암호 자동입력 의사가 없을 경우
			if(is_login == null) {
				
				// 쿠키를 생성하고 쿠키명-쿠키값을 "admin_id", null로 지정하기
				Cookie cookie1 = new Cookie("admin_id", null);
				
				// Cookie 객체 수명은 0으로 하기
				cookie1.setMaxAge(0);
				
				// 쿠키를 생성하고 쿠키명-쿠키값을 "pwd", null로 지정하기
				Cookie cookie2 = new Cookie("pwd", null);
				
				// Cookie 객체 수명은 0으로 하기
				cookie2.setMaxAge(0);
					
				// Cookie 객체를 응답메시지에 저장하기
				response.addCookie(cookie1);
				response.addCookie(cookie2);
			}
			
			// 매개변수 is_login에  "y"가 저장되어 있으면 아이디, 암호 자동입력 의사가 있을 경우
			else {
			
				// 쿠키를 생성하고 쿠키명-쿠키값을 ["admin_id" -"입력아이디"]로 하고 수명은 60*60*24로 생성
				Cookie cookie1 = new Cookie("admin_id", admin_id);
				cookie1.setMaxAge(60*60*24);
				Cookie cookie2 = new Cookie("pwd", pwd);
				cookie2.setMaxAge(60*60*24);
				
				// Cookie 객체를 응답메시지에 저장하기.
				response.addCookie(cookie1);
				response.addCookie(cookie2);
			}
		}
		
		return admin_idCnt;
	}
		
	// ----- 로그아웃을 할 수 있는 페이지 -----
	@RequestMapping(value="/logout.do")
	public ModelAndView logout(HttpSession session) {
		session.removeAttribute("admin_id");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("logout.jsp");
		return mav;
	}
}






















