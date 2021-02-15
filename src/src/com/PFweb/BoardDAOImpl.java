package src.com.PFweb;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAOImpl implements BoardDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	// 게시판 글 삽입하는 메소드
	public int insertBoard(BoardDTO boardDTO) {

		int boardRegCnt = sqlSession.insert(
				"src.com.PFweb.BoardDAO.insertBoard"	
				,boardDTO								
		);
		return boardRegCnt;
	}
	
	// 게시판의 리스트를 구현하는 메소드
	public List<Map<String, String>> getBoardList(BoardSearchDTO boardSearchDTO){
		List<Map<String, String>> boardList = this.sqlSession.selectList(
				"src.com.PFweb.BoardDAO.getBoardList",
				boardSearchDTO
		);
		return boardList;
	}
	
	// 게시판의 내용(Content) 구현 메소드
	public BoardDTO getBoard(int b_no) {
		BoardDTO board = this.sqlSession.selectOne(
				"src.com.PFweb.BoardDAO.getBoard",
				b_no
		);
		return board;
	}
	
	// 게시판 조회수 update 메소드
	public int updateReadcount(int b_no) {
		int updateCnt = this.sqlSession.update(
				"src.com.PFweb.BoardDAO.updateReadcount",
				b_no
		);
		return updateCnt;	
	}
	
	// 기존 작성된 게시판에 댓글이 생성이 될 경우 댓글에 출력번호를 update
	public int updatePrintNo(BoardDTO boardDTO) {
		int updatePrintCnt = this.sqlSession.update(
				"src.com.PFweb.BoardDAO.updatePrintNo",
				boardDTO
		);
		return updatePrintCnt;
	}
	

	// 작성된 글을 수정 및 삭제하기 전 글이 여전히 존재하는지 확인하는 메소드
	public int getBoardCnt(BoardDTO board) {
		int boardCnt = this.sqlSession.selectOne(
				"src.com.PFweb.BoardDAO.getBoardCnt",
				board
		);
		return boardCnt;
	}
	
	// 작성된 글을 수정 및 삭제하기 전 입력한 글의 비밀번호를 확인하는 메소드
	public int getPwdCnt(BoardDTO board) {
		int pwdCnt = this.sqlSession.selectOne(
				"src.com.PFweb.BoardDAO.getPwdCnt",
				board
		);
		return pwdCnt;
		
	}
	// 게시판 수정 후 수정행 적용 개수를 리턴하는 메소드 선언
	public int updateBoard(BoardDTO board) {
		int updateCnt = this.sqlSession.update(
				"src.com.PFweb.BoardDAO.updateBoard",
				board
		);
		return updateCnt;
		
	}
	// 삭제할 게시판의 자식글 존재 개수를 리턴하는 메소드 선언
	public int getChildrenCnt(BoardDTO board) {
		int childrenCnt = this.sqlSession.selectOne(
				"src.com.PFweb.BoardDAO.getChildrenCnt",
				board
		);
		return childrenCnt;
	}
	
	// 삭제될 게시판 이후 글의 출력 순서번호를 1씩 감소 시키는 메소드 
	public int downPrintNo(BoardDTO board) {
		int downprintCnt = this.sqlSession.update(
				"src.com.PFweb.BoardDAO.downPrintNo",
				board
		);
		return downprintCnt;
		
	}
	
	// 게시판 삭제 명령한 후 삭제 적용행의 개수를 얻는 메소드 
	public int deleteBoard(BoardDTO board) {
		int deleteCnt = this.sqlSession.delete(
				"src.com.PFweb.BoardDAO.deleteCnt",
				board
		);
		return deleteCnt;
		
	}
	
	// 검색한 게시판 목록 총개수 리턴하는 메소드 
	public int getBoardListAllCnt(BoardSearchDTO boardSearchDTO) {
		int boardListAllCnt = this.sqlSession.selectOne(
				"src.com.PFweb.BoardDAO.getBoardListAllCnt",
				boardSearchDTO
		);
		return boardListAllCnt;
		
	}
	
	// 게시판의 내용(Content) 구현 메소드
	public BoardDTO getRegInfo(int b_no) {
		BoardDTO regInfo = this.sqlSession.selectOne(
				"src.com.PFweb.BoardDAO.getRegInfo",
				b_no
		);
		
		return regInfo;
	}
	
	
	
	
	
	
	
}
