package src.com.PFweb;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class SessionInterceptor extends HandlerInterceptorAdapter{
	
	// URL 접속 시 컨트롤러 클래스의 메소드 호출 전 또는 후에
	// 실행 될 메소드를 소유한 SssionInterceptor 클래스 선언
	@Override
	public boolean preHandle(HttpServletRequest request,
							HttpServletResponse response,
							Object handler) throws Exception {

		HttpSession session = request.getSession();
		
		// Session 객체에서 loginController에서 저장한 키 값 admin_id으로 저장된 데이터 꺼내기
		String admin_id = (String) session.getAttribute("admin_id");
		
		if(admin_id == null) {
			
			// 현재 이 웹서비스의 컨택스트 루트명 구하기 
			String ctRoot = request.getContextPath();
			
			// 클라이언트가 /loginForm.do로 재 접속하라고 설정하기
			response.sendRedirect(ctRoot+"/loginForm.do");
			
			// false 값을 리턴하면 컨트롤러 클래스의 메소드는 호출되지 않음
			System.out.println("로그인 한적 없음");
			return false;
		}
		
		// 꺼낸 admin_id가 null이 아니면 즉 로그인 한 적이 있으면 true 리턴
		else {
			System.out.println("<접속성공>");
			return true;
		}
	}
}
