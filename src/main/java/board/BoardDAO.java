package board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	// 멤버변수 정의
	String sql=null;
	Connection con=null;
	PreparedStatement pstmt =null;
	ResultSet rs=null;
	// 디비연결 메서드 정의
	private Connection getConnection() throws Exception{
		// 메서드를 호출하는 곳에서 예외처리하는 명령
		
//		//1단계 디비연결하는 드라이버 불러오기
//		Class.forName("com.mysql.jdbc.Driver");
//		// 2단계 드라이버를 이용해서 디비에 연결
//		String dbUrl="jdbc:mysql://localhost:3306/jspdb2";
//		String dbUser="root";
//		String dbPass="1234";
//		con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
		
//		커넥션풀(Connection Pool) 
		// DBCP(DataBase Connection Pool) API 사용 : 프로그램 설치 없이 사용
		// 서버에서 미리 디비연결을 하고 필요할때 마다 자원의 이름을 불러서 사용
//		1. 수정최소화
//		2. 성능향상(속도빨라짐)
		
		// context.xml 파일 사용하기 위해서 객체생성
		Context init=new InitialContext();
		// context.xml 자원의 이름을 불러오기(찾기) (자원의 저장위치 / 자원의 이름)
		DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		// 불러온 자원 javax.sql.DataSource => Connection으로 변경
		con=ds.getConnection();
		return con;
	}
	// 기억장소 해제 메서드 정의
	public void obclose() {
		if(rs!=null) {
			try {
				rs.close();
			} catch (Exception e2) {
				
			}
		}
		if(pstmt!=null) {
			try {
				pstmt.close();
			} catch (Exception e2) {
				
			}
		}
		if(con!=null) {
			try {
				con.close();
			} catch (Exception e2) {
				
			}
		}
	}

	// insertBoard(게시판내용을 저장한 주소) 정의
	public void insertBoard(BoardDTO boardDTO) {
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			// num구하기 max(num) +1
			int num=0;
			// 3단계 sql select max(num) from board
			sql="select max(num) from board";
			pstmt=con.prepareStatement(sql);
			// 4단계 실행 => 결과 저장 
			rs=pstmt.executeQuery();
			// 5단계 결과에 다음행으로 접근 max(num) +1 
			if(rs.next()){
				num=rs.getInt("max(num)")+1;
			}
			// 3단계 sql insert
			sql="insert into board(num,name,pass,subject,content,readcount,date,file) values(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, boardDTO.getName());
			pstmt.setString(3, boardDTO.getPass());
			pstmt.setString(4, boardDTO.getSubject());
			pstmt.setString(5, boardDTO.getContent());
			pstmt.setInt(6, boardDTO.getReadcount());
			pstmt.setTimestamp(7, boardDTO.getDate());
			//첨부파일
			pstmt.setString(8, boardDTO.getFile());
			
			// 4단계 sql구문 실행 .executeUpdate() - insert, update, delete
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
	}//insertBoard()
	
	//List boardList  =  getBoardList(startRow, pageSize) 메서드 정의
	public List<BoardDTO> getBoardList(int startRow,int pageSize) {
		// 게시판 글을 여러개 저장할수 있는 배열(모든형 Object 저장)
//		List boardList=new ArrayList();
		//BoardDTO형만 저장할수 있게 객체생성 => 제네릭타입
		List<BoardDTO> boardList=new ArrayList<BoardDTO>();
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			// 3단계 sql  
			// 최근글 위로 정렬 select * from board order by num desc;
//			sql="select * from board order by num desc";
			// select * from board order by num desc limit 시작행-1, 가져올개수
			sql="select * from board order by num desc limit ?, ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			// 4단계 실행 => 결과저장 
			rs=pstmt.executeQuery();
// 5 결과 => 글하나 BoardDTO 에 저장 => boardList한칸에 글하나 저장 
			// 5단계 결과 while 출력 
			while(rs.next()){
				// 행 게시판글 하나를 BoardDTO에 저장
				BoardDTO boardDTO=new BoardDTO();
				// 디비에서 열 => 멤버변수에 저장
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 글하나를 배열 한칸에 저장 
				boardList.add(boardDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
		return boardList;
	}//getBoardList()
	
	//List boardList  =  getBoardList(startRow, pageSize, search) 메서드 정의
		public List<BoardDTO> getBoardList(int startRow,int pageSize, String search) {
			// 게시판 글을 여러개 저장할수 있는 배열(모든형 Object 저장)
//			List boardList=new ArrayList();
			//BoardDTO형만 저장할수 있게 객체생성 => 제네릭타입
			List<BoardDTO> boardList = new ArrayList<BoardDTO>();
			try {
				//1,2 단계 디비연결 메서드 호출
				con=getConnection();
				// 3단계 sql  
				// 최근글 위로 정렬 select * from board order by num desc;
//				sql="select * from board order by num desc";
				// select * from board order by num desc limit 시작행-1, 가져올개수
//				sql="select * from board order by num desc limit ?, ?";
//				sql="select * from board where subject like '%검색어%' order by num desc limit ?, ?";
				sql="select * from board where subject like ? order by num desc limit ?, ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, "%" + search + "%");
				pstmt.setInt(2, startRow-1);
				pstmt.setInt(3, pageSize);
				
				// 4단계 실행 => 결과저장 
				rs=pstmt.executeQuery();
	// 5 결과 => 글하나 BoardDTO 에 저장 => boardList한칸에 글하나 저장 
				// 5단계 결과 while 출력 
				while(rs.next()){
					// 행 게시판글 하나를 BoardDTO에 저장
					BoardDTO boardDTO=new BoardDTO();
					// 디비에서 열 => 멤버변수에 저장
					boardDTO.setNum(rs.getInt("num"));
					boardDTO.setName(rs.getString("name"));
					boardDTO.setPass(rs.getString("pass"));
					boardDTO.setSubject(rs.getString("subject"));
					boardDTO.setContent(rs.getString("content"));
					boardDTO.setReadcount(rs.getInt("readcount"));
					boardDTO.setDate(rs.getTimestamp("date"));
					// 글하나를 배열 한칸에 저장 
					boardList.add(boardDTO);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				obclose();
			}
			return boardList;
		}//getBoardList()
	
	//BoardDTO boardDTO  =  getBoard(int num) 메서드 정의
	public BoardDTO getBoard(int num) {
		BoardDTO boardDTO=new BoardDTO();
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			// 3단계 sql select * from board where num=?;
			sql="select * from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 4단계 실행 => 결과저장 
			rs=pstmt.executeQuery();
			// 5단계 결과 if 출력 
			if(rs.next()) {
		// 첫번째 행 =>true => 열접근 => boardDTO 멤버변수에 저장
				boardDTO.setNum(rs.getInt("num"));
				boardDTO.setName(rs.getString("name"));
				boardDTO.setPass(rs.getString("pass"));
				boardDTO.setSubject(rs.getString("subject"));
				boardDTO.setContent(rs.getString("content"));
				boardDTO.setReadcount(rs.getInt("readcount"));
				boardDTO.setDate(rs.getTimestamp("date"));
				// 첨부파일 추가
				boardDTO.setFile(rs.getString("file"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
		return boardDTO;
	}//getBoard()
	
	// //메서드 정의 BoardDTO numCheck(int num,String pass)
	public BoardDTO numCheck(int num,String pass) {
		// num pass 일치 객체생성, 불일치 null  초기값
		BoardDTO boardDTO=null;
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			// 3단계 sql select * from board where num=? and pass=?;
			sql="select * from board where num=? and pass=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, pass);
			// 4단계 실행 => 결과저장 
			rs=pstmt.executeQuery();
			// 5단계 결과 if 출력 결과가 있으면 rs.next() true 
			if(rs.next()) {
				//첫행 => true => 일치 => BoardDTO 객체생성 주소값 저장
				boardDTO=new BoardDTO();
				boardDTO.setNum(rs.getInt("num"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
		return boardDTO;
	}// numCheck(int num,String pass)
	
	//리턴값없음 updateBoard(boardDTO)
	public void updateBoard(BoardDTO boardDTO) {
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			//3단계 update  name subject content 수정
		sql="update board set name=?, subject=?, content=? where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1,boardDTO.getName());
			pstmt.setString(2,boardDTO.getSubject());
			pstmt.setString(3,boardDTO.getContent());
			pstmt.setInt(4, boardDTO.getNum());
			//4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
	}//updateBoard(boardDTO)
	
	//리턴값없음 fupdateBoard(boardDTO)
		public void fupdateBoard(BoardDTO boardDTO) {
			try {
				//1,2 단계 디비연결 메서드 호출
				con=getConnection();
				//3단계 update  name subject content file 수정
			sql="update board set name=?, subject=?, content=?, file=? where num=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,boardDTO.getName());
				pstmt.setString(2,boardDTO.getSubject());
				pstmt.setString(3,boardDTO.getContent());
				// file 추가
				pstmt.setString(4, boardDTO.getFile());
				pstmt.setInt(5, boardDTO.getNum());
				//4단계 실행
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				obclose();
			}
		} //fupdateBoard(boardDTO)
	
	// deleteBoard(num)
	public void deleteBoard(int num) {
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			//3단계 delete  조건num=?
			sql="delete from board where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
	}// deleteBoard(num)
	
	// boardDAO.updateReadcount(num);
	public void updateReadcount(int num) {
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			//3단계 update  
		    sql="update board set readcount=readcount+1 where num=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
	}//updateReadcount(num);
	
	
//	int count=boardDAO.getBoardCount();
	public int getBoardCount() {
		int count=0;
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			// 3단계 sql select count(*) from board;
			sql="select count(*) from board";
			pstmt=con.prepareStatement(sql);
			// 4단계 실행 => 결과저장 
			rs=pstmt.executeQuery();
			// 5단계 결과 if 출력 
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
		return count;
	}
	
//	int count=boardDAO.getBoardCount(search);
	public int getBoardCount(String search) {
		int count=0;
		try {
			//1,2 단계 디비연결 메서드 호출
			con=getConnection();
			// 3단계 sql select count(*) from board;
//			sql="select count(*) from board where subject like '%검색어%'";
			sql="select count(*) from board where subject like ?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, "%" + search + "%");
			// 4단계 실행 => 결과저장 
			rs=pstmt.executeQuery();
			// 5단계 결과 if 출력 
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
		return count;
	}
	
}//클래스
