package src.com.PFweb;

import java.util.List;
import java.util.Map;

public interface BoardDAO {
	
	// 게시판 글 삽입 메소드
	public int insertBoard(BoardDTO boardDTO);
	
	// 게시판 리스트 구현 메소드
	public List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO);
	
	// 게시판의 내용(Content) 구현 메소드
	BoardDTO getBoard(int b_no);
	
	// 게시판 조회수 update 메소드
	int updateReadcount(int b_no);
	
	// 기존 작성된 게시판에 댓글이 생성이 될 경우 댓글에 출력번호를 update하는 메소드
	int updatePrintNo(BoardDTO board);
	
	// 댓글을 쓸 때 기존 작성된 글의 제목을 그대로 가져오는 메소드
	BoardDTO getRegInfo(int b_no);
	
	// 작성된 글을 수정 및 삭제하기 전 글이 여전히 존재하는지 확인하는 메소드
	int getBoardCnt(BoardDTO board);

	// 작성된 글을 수정 및 삭제하기 전 입력한 글의 비밀번호를 확인하는 메소드
	int getPwdCnt(BoardDTO board);

	// 게시판을 수정하여 값을 리턴하는 메소드
	int updateBoard(BoardDTO board);
	
	// 삭제할 게시판의 자식글 존재 개수를 얻는 메소드 
	int getChildrenCnt(BoardDTO board);
	
	// 삭제될 게시판 이후 글의 출력 순서번호를 1씩 감소 시키는 메소드 
	int downPrintNo(BoardDTO board);
	
	// 게시판 삭제 명령한 후 삭제 적용행의 개수를 얻는 메소드 
	int deleteBoard(BoardDTO board);
	
	// 검색한 게시판 목록 총개수 리턴하는 메소드 
	public int getBoardListAllCnt(BoardSearchDTO boardSearchDTO);
	
	
}
