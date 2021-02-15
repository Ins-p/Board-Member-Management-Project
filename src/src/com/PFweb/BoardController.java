package src.com.PFweb;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
		
	// ----- 게시판 리스트 페이지 -----
	@RequestMapping(value="/boardList.do")
	public ModelAndView getBoardList(BoardSearchDTO boardSearchDTO,
										HttpSession session){
		int boardListAllCnt = this.boardService.getBoardListAllCnt(boardSearchDTO);
		
		// 선택된 페이지 보정하여 처리하기(페이징 처리)
		if(boardListAllCnt > 0) {
			int beginRowNo = boardSearchDTO.getSelectPageNo() * boardSearchDTO.getRowCntPerPage()
							- boardSearchDTO.getRowCntPerPage() + 1;		
			if(boardListAllCnt < beginRowNo) {
				boardSearchDTO.setSelectPageNo(1);
			}
		}
		
		// 게시판 목록을 얻기 위해 서비스 호출
		List<Map<String, String>> boardList = this.boardService.getBoardList(boardSearchDTO);	
		ModelAndView mav = new ModelAndView();
		
		// URL 지정
		mav.setViewName("boardList.jsp");
		
		// boardList.do 페이지에 보여줄 컬럼 리턴
		mav.addObject("boardList", boardList);
		
		// 보여줄 컬럼들의 총 개수 리턴
		mav.addObject("boardListAllCnt", boardListAllCnt);
		
		// 검색 되어지는 항목들 리턴
		mav.addObject("boardSearchDTO", boardSearchDTO);	
		return mav;
	}
	
	// ----- 게시판 새글/댓글 페이지 -----
	@RequestMapping(value="/boardRegForm.do")	
	public ModelAndView getBoardRegForm(@RequestParam(value="b_no",
							 						  required = false,
							 						  defaultValue ="0") int b_no,
							 						  HttpSession session) {

		ModelAndView mav = new ModelAndView();
		
		// 생성된 게시판 글에 댓글을 삽입할 때 자동으로 제목이 입력 되도록 서비스 호출
		// 생성된 게시판의 글을 확인 할 수 있도록 b_no를 파라미터로 보냄
		BoardDTO regInfo = this.boardService.getRegInfo(b_no);
		
		// URL 지정
		mav.setViewName("boardRegForm.jsp");
		
		// 게시판에 댓글 또는 새글인지 구분을 하기 위해 b_no 값 리턴
		// b_no 0 일 때는 [새글] / b_no > 0 일 때는 댓글
		mav.addObject("b_no", b_no);
		
		// 댓글일 경우 기존 제목 그대로 자동 삽입 하도록 subject 값 리턴
		mav.addObject("regInfo", regInfo);
		return mav;
	}
	
	// ----- 새글 또는 댓글을 Insert 했을 때 리턴 되는 값 확인하는 임시 페이지 -----
	@RequestMapping(value="/boardRegProc.do",
				    method=RequestMethod.POST,
				    produces="application/json;charset=UTF-8"
	)
	@ResponseBody
	public int insertBoard(BoardDTO boardDTO){ 

		
		// insert 리턴 값을 받기 위해서 서비스 호출
		int boardRegCnt = this.boardService.insertBoard(boardDTO);		
		return boardRegCnt;
	}
	
	// ----- 게시판 내용 페이지 -----
	@RequestMapping(value="/boardContentForm.do")
	public ModelAndView goBoardContentForm(@RequestParam(value="b_no") int b_no,
											HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardContentForm.jsp");
		
		// 게시판의 내용을 얻기 위해 서비스 호출
		BoardDTO board = this.boardService.getBoard(b_no);
		
		// 얻는 값을 리턴하기 위해 "board" 키값에 저장
		mav.addObject("board", board);
		return mav;
	}
	
	// ----- 게시판 수정 및 삭제 페이지 -----
	@RequestMapping(value="/boardUpDelForm.do",
					method=RequestMethod.POST)
	public ModelAndView boardUpDelForm(@RequestParam(value="b_no") int b_no, HttpSession session) {
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("boardUpDelForm.jsp");
		
		// 업데이트 및 수정할 때 조회수 증가 없이 게시판을 얻기 위해 서비스 호출
		BoardDTO boardDTO = this.boardService.getBoard_without_updateReadCnt(b_no);
		
		// 리턴 받은 값을 키 값이 "board" 인곳에 저장
		mav.addObject("board", boardDTO);
		
		return mav;
	}
	
	// ----- 게시판의 글이 update 또는 delete가 되었을 때 얻는 값 확인하는 페이지 -----
	@RequestMapping(value="/boardUpDelProc.do",
					method=RequestMethod.POST,
					produces="application/json; charset=UTF-8")
	@ResponseBody
	
	// 클라이언트가 수정(up) 인지 삭제(del)인지 구분을 하기 위해 
	// upDel을 파라미터로 받음 
	public int boardUpDelProc(BoardDTO boardDTO,
			@RequestParam(value="upDel") String upDel) {
		
		int boardUpdelCnt = 0;
		
		// upDel에 up이 있으면 update를 하는 서비스의 메소드 호출
		if(upDel.equals("up")) {
			boardUpdelCnt = this.boardService.updateBoard(boardDTO);
		}
		
		// 그 외의 값이 있으면 delete를 하는 서비스의 메소드 호출
		else {
			boardUpdelCnt = this.boardService.deleteBoard(boardDTO);
		}
		
		return boardUpdelCnt;
	}
}















