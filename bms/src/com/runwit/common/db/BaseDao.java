package com.runwit.common.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

public class BaseDao {
	
	protected DbConnect dbConn;
	static Logger  logger = Logger.getLogger(BaseDao.class);//Class
	
	public BaseDao() {
		dbConn = new DbConnect();
	}
	
	/**
	 * 执行增、删、改等操作，不返回结果集 
	 * @param sql ： 
	 * @return 影响记录的行数
	 */
	public int updateBySql(String sql){
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = dbConn.getConnection();
			stmt = conn.createStatement();
			logger.debug(sql);
			return stmt.executeUpdate(sql);
		} catch (SQLException e) {
			logger.debug("执行SQL异常");
			e.printStackTrace();
			return -1;
		}finally{
			dbConn.closeStatment(stmt);
			dbConn.closeConnection(conn);
		}
	}
	
	public int updateBySql(String sql, IParamBinding bind){
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			logger.debug(sql);
			bind.bindParam(pstmt); //参数绑定
			return pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return -1;
		}finally{
			dbConn.closeStatment(pstmt);
			dbConn.closeConnection(conn);
		}
	}
	
	/**
	 * 执行多条不带参数的SQL语句
	 * @param sqls
	 * @return
	 */
	public int[] executeBatch(String[] sqls){
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = dbConn.getConnection();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			for(int i=0; i<sqls.length; i++){
				logger.debug(sqls[i]);
				stmt.addBatch(sqls[i]);
			}
			return stmt.executeBatch();
		} catch (SQLException e) {
			logger.debug("执行SQL异常");
			dbConn.rollbackTrans(conn);
			e.printStackTrace();
			return null;
		}finally{
			dbConn.commitTrans(conn);
			dbConn.closeStatment(stmt);
			dbConn.closeConnection(conn);
		}
		
	}
	
	/**
	 * 仅负责创建和关闭Connection， 由IConnectionCreator做具体数据操作。
	 * @param connCreator
	 * @return
	 */
	public boolean executeInConnection(IConnectionCreator connCreator){
		Connection conn = null;
		try {
			conn = dbConn.getConnection();
			conn.setAutoCommit(false);
			boolean success = connCreator.doInConnection(conn);
			if(!success)
				dbConn.rollbackTrans(conn);
			else
				dbConn.commitTrans(conn);
			return true;
		} catch (SQLException e) {
			logger.debug("执行SQL异常");
			dbConn.rollbackTrans(conn);
			e.printStackTrace();
		}finally{
			dbConn.closeConnection(conn);
		}
		return false;
		
	}
	
	//public abstract Object mappingRow(ResultSet rs);
	
	/**
	 * 查询
	 */
	@SuppressWarnings("unchecked")
	public List queryBySql(String sql, IRowMapper mapper){
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List retList = new ArrayList();
		try {
			conn = dbConn.getConnection();
			stmt = conn.createStatement();
			logger.debug(sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				Object obj = mapper.mappingRow(rs);
				//AuthorModel model = new AuthorModel(rs.getInt("authorId"), rs.getString("firstName"), rs.getString("lastName"));
				retList.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbConn.closeResultSet(rs);
			dbConn.closeStatment(stmt);
			dbConn.closeConnection(conn);
		}
		
		return retList;
		
	}

	@SuppressWarnings("unchecked")
	public List queryBySql(String sql, IParamBinding bind, IRowMapper mapper){
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List retList = new ArrayList();
		try {
			conn = dbConn.getConnection();
			pstmt = conn.prepareStatement(sql);
			logger.debug(sql);
			bind.bindParam(pstmt); //参数绑定
			rs = pstmt.executeQuery();
			while(rs.next()){
				Object obj = mapper.mappingRow(rs);
				//AuthorModel model = new AuthorModel(rs.getInt("authorId"), rs.getString("firstName"), rs.getString("lastName"));
				retList.add(obj);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally{
			dbConn.closeResultSet(rs);
			dbConn.closeStatment(pstmt);
			dbConn.closeConnection(conn);
		}
		
		return retList;
		
	}

}
