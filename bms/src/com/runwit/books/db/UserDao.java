package com.runwit.books.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import com.runwit.books.model.UserModel;
import com.runwit.common.db.BaseDao;
import com.runwit.common.db.IParamBinding;
import com.runwit.common.db.IRowMapper;
import com.runwit.common.util.ParamUtil;

public class UserDao extends BaseDao{
	public void save(final UserModel model){
		String sql = "insert into bookusers(account, password, name, createTime) values(?, ?, ?, now())";
		super.updateBySql(sql, new IParamBinding() {
			public void bindParam(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, model.getAccount());
				pstmt.setString(2, model.getPassword());
				pstmt.setString(3, model.getName());
			}
		});
	}
	
	public void update(final UserModel model){
		String sql = "update bookusers set account=?, password=?, name=? where userId=?";
		super.updateBySql(sql, new IParamBinding() {
			public void bindParam(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, model.getAccount());
				pstmt.setString(2, model.getPassword());
				pstmt.setString(3, model.getName());
				pstmt.setInt(4, model.getUserId());
			}
		});
		
	}
	
	public void delete(int id){
		String sql = "delete from bookusers where userid="+id;
		updateBySql(sql);
	}
	
	@SuppressWarnings("unchecked")
	public UserModel get(int id){
		List<UserModel> models = queryBySql("select * from bookusers where userid="+id, new UserRowMapper() ); 
		if(models == null || models.size() == 0)
			return null;
		else
			return models.get(0);
	}
	
	@SuppressWarnings("unchecked")
	public List<UserModel> queryAll(){
		return queryBySql("select * from bookusers", new UserRowMapper() );
	}
	
	class UserRowMapper implements IRowMapper {
		public Object mappingRow(ResultSet rs) throws SQLException {
			UserModel model = new UserModel();
			model.setAccount(rs.getString("account"));
			model.setName(rs.getString("name"));
			model.setPassword(rs.getString("password"));
			model.setUserId(rs.getInt("userId"));
			String createTime = ParamUtil.parseDateTime(rs.getTimestamp("createTime"), "yyyy-mm-dd hh:mm:ss");
			model.setCreateTime(createTime);
			return model;
		}
	}
	
	@SuppressWarnings("unchecked")
	public UserModel login(final String account, final String password){
		String sql = "select * from bookusers where account=? and password=?";
		List<UserModel> models = queryBySql(sql, new IParamBinding(){
			public void bindParam(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, account);
				pstmt.setString(2, password);
			}
		}, new UserRowMapper());
		
		if(models == null || models.size() == 0)
			return null;
		else
			return models.get(0);
	}
}
