package src.com.PFweb;

import java.util.HashMap;
import java.util.List;
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

public class MemberController {
	
	@Autowired
	private MemberService memberService;
	
	// ----- 회원가입 페이지 -----
	@RequestMapping(value = "/memberRegForm.do")
	public ModelAndView memberRegForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("memberRegForm.jsp");
		return mav;
	}
	
	// ----- 회원가입한 정보를 insert하는 임시 페이지 -----
	@RequestMapping(value = "/memberRegProc.do",
					method = RequestMethod.POST,
					produces = "application/json; charset=UTF-8")
	@ResponseBody
	public int getmemberRegForm(MemberDTO memberDTO) {
		
		// 회원가입 insert를 한 후 리턴 값을 받기 위해 service 호출
		int memberRegCnt = this.memberService.getmemberRegForm(memberDTO);
		return memberRegCnt;
	}
	
	// ----- admin만 접근 가능한 회원관리 페이지  -----
	@RequestMapping(value="/memberList.do")
	public ModelAndView getMemberList(MemberSearchDTO memberSearchDTO){
		ModelAndView mav = new ModelAndView();
		int boardListAllCnt = this.memberService.getBoardListAllCnt(memberSearchDTO);
		
		// 선택된 페이지 보정하여 처리하기(페이징 처리)
		if(boardListAllCnt > 0) {
			int beginRowNo = memberSearchDTO.getSelectPageNo() * memberSearchDTO.getRowCntPerPage()
							- memberSearchDTO.getRowCntPerPage() + 1;		
			if(boardListAllCnt < beginRowNo) {
				memberSearchDTO.setSelectPageNo(1);
			}
		}
		
		// 회원관리 목록을 얻기 위해 서비스 호출
		List<Map<String, String>> memberList = this.memberService.getMemberList(memberSearchDTO);
		
		// URL 지정
		mav.setViewName("memberList.jsp");
		
		// memberList.do 페이지에 보여줄 컬럼 리턴
		mav.addObject("memberList", memberList);
		
		// 보여줄 컬럼들의 총 개수 리턴
		mav.addObject("boardListAllCnt", boardListAllCnt);
		
		// 검색 되어지는 항목들 리턴
		mav.addObject("memberSearchDTO", memberSearchDTO);
		return mav;
	}
	
	// ----- 멤버를 검색하는 페이지 -----
	@RequestMapping(value="/memberCheckProc.do",
					method = RequestMethod.POST,
					produces = "application/json; charset=UTF-8")
	@ResponseBody
	public int getmemberCheckCnt(@RequestParam(value="memberCheck") String memberCheck,
								@RequestParam(value="member_no") String member_no) {
		
		// Mybatis에서 입력된 회원번호와 회원이 정회원 인지를 확인 하기 위해 HashMap에 데이터 put
		Map<String, String> map = new HashMap<String, String>();
		map.put("memberCheck", memberCheck);
		map.put("member_no", member_no);
		
		// 정회원 여부와 회원번호를 확인하기 위해 service 호출
		int memberCheckCnt = this.memberService.getmemberCheckCnt(map);
		return memberCheckCnt;
	}
}






















