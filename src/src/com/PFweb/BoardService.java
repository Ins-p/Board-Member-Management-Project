package src.com.PFweb;

import java.util.List;
import java.util.Map;

public interface BoardService {

	// 게시판 글 삽입 메소드
	public int insertBoard(BoardDTO boardDTO);
	
	// 게시판 리스트 구현 메소드
	public List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO);
	
	// 게시판의 내용(Content) 구현 메소드
	BoardDTO getBoard(int b_no);
	
	// 업데이트 및 수정할 때 조회수 증가 없이 게시판을 얻기 위한 메소드
	BoardDTO getBoard_without_updateReadCnt(int b_no);
	
	// 기존 작성된 게시판에 댓글이 생성이 될 경우 댓글에 출력번호를 update하는 메소드
	public int updateBoard(BoardDTO boardDTO);
	
	// 게시판 삭제 명령한 후 삭제 적용행의 개수를 얻는 메소드 
	public int deleteBoard(BoardDTO board);
	
	// 게시판의 총 갯수 얻는 선언
	int getBoardListAllCnt(BoardSearchDTO boardSearchDTO);
	
	// 댓글을 쓸 때 기존 작성된 글의 제목을 그대로 가져오는 메소드
	BoardDTO getRegInfo(int b_no);

	
}
