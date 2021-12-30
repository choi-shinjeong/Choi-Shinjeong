package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	// Member관련 디비작업
		// 멤버변수
		String sql=null;
		Connection con=null;
		PreparedStatement pstmt =null;
		ResultSet rs=null;
		
		// 생성자
		// 멤버함수(메서드)
		
		//데이터베이스 연결(메서드)
		private Connection getConnection() throws Exception{
			// 메서드를 호출하는 곳에서 예외처리하는 명령
			
//			//1단계 디비연결하는 드라이버 불러오기
//			Class.forName("com.mysql.jdbc.Driver");
//			// 2단계 드라이버를 이용해서 디비에 연결
//			String dbUrl="jdbc:mysql://localhost:3306/jspdb2";
//			String dbUser="root";
//			String dbPass="1234";
//			con=DriverManager.getConnection(dbUrl, dbUser, dbPass);
			
//			커넥션풀(Connection Pool) 
			// DBCP(DataBase Connection Pool) API 사용 : 프로그램 설치 없이 사용
			// 서버에서 미리 디비연결을 하고 필요할때 마다 자원의 이름을 불러서 사용
//			1. 수정최소화
//			2. 성능향상(속도빨라짐)
			
			// context.xml 파일 사용하기 위해서 객체생성
			Context init=new InitialContext();
			// context.xml 자원의 이름을 불러오기(찾기) (자원의 저장위치 / 자원의 이름)
			DataSource ds=(DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
			// 불러온 자원 javax.sql.DataSource => Connection으로 변경
			con=ds.getConnection();
			return con;
		}
		
		// 객체기억장소 해제 메서드()
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

	// insertMember(바구니주소 저장할 변수) 메서드 정의
	public void insertMember(MemberDTO memberDTO) {
		try {
			//1,2 디비연결
			con=getConnection();
			// 3단계 sql구문을 만들어서 실행할 준비 insert
			sql="insert into member(id,pass,name,date,email,postcode,address,detailAddress,phone,mobile) values(?,?,?,?,?,?,?,?,?,?)";
			pstmt =con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPass());
			pstmt.setString(3, memberDTO.getName());
			pstmt.setTimestamp(4, memberDTO.getDate());
			//추가
			pstmt.setString(5, memberDTO.getEmail());
			pstmt.setString(6, memberDTO.getPostcode());
			pstmt.setString(7, memberDTO.getAddress());
			pstmt.setString(8, memberDTO.getDetailAddress());
			pstmt.setString(9, memberDTO.getPhone());
			pstmt.setString(10, memberDTO.getMobile());
			
			// 4단계 sql구문 실행 .executeUpdate() - insert, update, delete
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
	}//insertMember()
	
	// 리턴할형 MemberDTO userCheck(id,pass)메서드 정의
	public MemberDTO userCheck(String id,String pass) {
		MemberDTO memberDTO=null;
		try {
			//1,2 디비연결
			con=getConnection();
			// 3단계 sql구문 만들고 실행할 준비 select where id=? and pass=?
			sql="select * from member where id=? and pass=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			// 4단계 sql구문 실행 => 결과저장 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 
			if(rs.next()) {
				memberDTO=new MemberDTO();
				memberDTO.setId(rs.getString("id"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
		return memberDTO;
	}//userCheck(id,pass)
	
	//MemberDTO getMember(id)
	public MemberDTO getMember(String id) {
		MemberDTO memberDTO=null;
		try {
			//1,2 디비연결
			con=getConnection();
			// 3단계 sql구문 만들고 실행할 준비 select where id=?
			sql="select * from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4단계 sql구문 실행 => 결과저장 내장객체 ResultSet
			rs=pstmt.executeQuery();
			// 5단계 
			if(rs.next()) {
				memberDTO=new MemberDTO();
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPostcode(rs.getString("postcode"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setDetailAddress(rs.getString("detailAddress"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setMobile(rs.getString("mobile"));
				memberDTO.setDate(rs.getTimestamp("date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
		return memberDTO;
	}// getMember()
	
	//  updateMember(memberDTO)
	public void updateMember(MemberDTO memberDTO) {
		try {
			//1,2 디비연결
			con=getConnection();
			//3단계 update 수정name 조건 id
			sql="update member set name=?,email=?,postcode=?,address=?,detailAddress=?,phone=?,mobile=? where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, memberDTO.getName());
			pstmt.setString(2, memberDTO.getEmail());
			pstmt.setString(3, memberDTO.getPostcode());
			pstmt.setString(4, memberDTO.getAddress());
			pstmt.setString(5, memberDTO.getDetailAddress());
			pstmt.setString(6, memberDTO.getPhone());
			pstmt.setString(7, memberDTO.getMobile());
			pstmt.setString(8, memberDTO.getId());
			//4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			obclose();
		}
	}//updateMember()
	
//	deleteMember(id) 정의 호출
	public void deleteMember(String id) {
		try {
			//1단계 디비연결하는 드라이버 불러오기
			// 2단계 드라이버를 이용해서 디비에 연결
			con=getConnection();
			//3단계 delete 조건 id
			sql="delete from member where id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			//4단계 실행
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			//마무리
			obclose();
		}
		// 리턴값 없으면 생략가능
		return;
	}//deleteMember(id)
	
}//클래스
