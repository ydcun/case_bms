package com.runwit.common.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;


public class DbConnect {
	
	static Logger  logger = Logger.getLogger(DbConnect.class);//Class
	
	/**
	 * 加载驱动
	 */
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	//数据库连接地址
	private static String url="jdbc:mysql://127.0.0.1:3306/books?useUnicode=true&characterEncoding=UTF-8";
	
	/**
	 * 获得数据库连接
	 * @return
	 * @throws SQLException
	 */
	public Connection getConnection() throws SQLException {
		//logger.debug("获得数据库连接");
		return DriverManager.getConnection(url, "root", "123abc");
	}
	
	/**
	 * 关闭数据库连接
	 * @param conn
	 */
	public void closeConnection(Connection conn){
		try {
			if(conn != null){
				conn.close();
				//logger.debug("数据库连接已关闭");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 关闭执行SQL语句的对象Statement
	 * @param stmt
	 */
	public void closeStatment(Statement stmt){
		try {
			if(stmt != null)
				stmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 关闭结果集
	 * @param rs
	 */
	public void closeResultSet(ResultSet rs){
		try {
			if(rs != null)
				rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void commitTrans(Connection conn){
		try {
			if(conn != null)
				conn.commit();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void rollbackTrans(Connection conn){
		try {
			if(conn != null)
			conn.rollback();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
