package src.com.PFweb;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional

public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDAO boardDAO;
	
	// 게시판 글 삽입 메소드
	public int insertBoard(BoardDTO boardDTO) {
		
		// 부모글의 글 번호를 얻기
		int b_no = boardDTO.getB_no();
		
		// 게시판 글이 입력되는 부분 이후 글들은 출력 순서번호를 1씩 증가해야 함
		// 기존의 글의 번호가 1이상이면 댓글쓰기 이므로 출력순서번호 증가를 위해 DAO 호출
		if(b_no > 0) {
			int updatePrintCnt = this.boardDAO.updatePrintNo(boardDTO);
		}
		
		// 새글 또는 댓글을 작성 된 값을 리턴 받기 위해 DAO 호출
		int boardRegCnt = this.boardDAO.insertBoard(boardDTO);
		return boardRegCnt;
	}
	

	// 게시판 리스트 구현 메소드
	public List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO){
		
		List<Map<String, String>> boardList = this.boardDAO.getBoardList(boardSearchDTO);
		return boardList;
		
	}
	
	// 게시판의 내용(Content) 구현 메소드
	public BoardDTO getBoard(int b_no) {
		
		// 조회수 업데이트를 위해 DAO호출
		int updateCnt = this.boardDAO.updateReadcount(b_no);
		
		// 1행의 조회수를 성공 했을 때 if문을 실행하여 content 구현
		BoardDTO board = null;
		if(updateCnt == 1) {
			board = this.boardDAO.getBoard(b_no);
		}
		
		return board;
	}
	
	// 업데이트 및 수정할 때 조회수 증가 없이 게시판을 얻기 위한 메소드
	public BoardDTO getBoard_without_updateReadCnt(int b_no) {
		
		// 게시판의 내용(Content)을 불러오기 위해 DAO호출
		BoardDTO board = this.boardDAO.getBoard(b_no);
		
		return board;
	}
	
	// 1개 게시판의 수정 적용행의 개수를 리턴하는 메소드 선언
	public int updateBoard(BoardDTO board) {
		
		// 작성된 글을 수정 전 글이 여전히 존재하는지 확인을 위해 DAO 호출
		int boardCnt = this.boardDAO.getBoardCnt(board);
		if(boardCnt == 0) {
			return -1;
		}
		
		// 작성된 글을 수정 전 입력한 글의 비밀번호를 확인하기 위해 DAO 호출
		int pwdCnt = this.boardDAO.getPwdCnt(board);
		if(pwdCnt == 0) {
			return -2;
		}
		
		// 위의 로직을 거친 후 수정을 위해 DAO 호출
		int updateCnt = this.boardDAO.updateBoard(board);				
		return updateCnt;
	}
	
	// 1개 게시판 삭제 적용행의 개수를 리턴하는 메소드 선언
	public int deleteBoard(BoardDTO board) {
		
		// 작성된 글을 삭제 전 글이 여전히 존재하는지 확인을 위해 DAO 호출
		int boardCnt = this.boardDAO.getBoardCnt(board);
		if(boardCnt == 0) {
			return -1;
		}
		
		// 작성된 글을 삭제 전 입력한 글의 비밀번호를 확인하기 위해 DAO 호출
		int pwdCnt = this.boardDAO.getPwdCnt(board);
		if(pwdCnt == 0) {
			return -2;
		}
		
		// 글을 삭제하기 전 댓글들이 달려 있는지 확인하기 위해 DAO 호출
		// 만약 댓글이 있으면 삭제 불가
		int childrenCnt = this.boardDAO.getChildrenCnt(board);
		if(childrenCnt > 0) {
			return -3;
		}
		
		// 글을 삭제 한 후 출력번호를 1씩 감소
		int downPrintNoCnt = this.boardDAO.downPrintNo(board);
		
		// 글 삭제하기 위해 DAO 호출
		int deleteCnt = this.boardDAO.deleteBoard(board);		
		return deleteCnt;
		
	}
	
	// 불러오는 게시판 글의 총 수를 구하는 메소드
	public int getBoardListAllCnt(BoardSearchDTO boardSearchDTO) {
		
		int boardListAllCnt = this.boardDAO.getBoardListAllCnt(boardSearchDTO);
		
		return boardListAllCnt;
	}
	
	// 작성된 게시판의 글에 댓글을 달 때 자동으로 제목이 생성이 되는 메소드
	public BoardDTO getRegInfo(int b_no) {
		BoardDTO regInfo = this.boardDAO.getRegInfo(b_no);		
		return regInfo;
	}
	
}
