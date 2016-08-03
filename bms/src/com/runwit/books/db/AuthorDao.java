package com.runwit.books.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import com.runwit.books.model.AuthorModel;
import com.runwit.common.db.BaseDao;
import com.runwit.common.db.IParamBinding;
import com.runwit.common.db.IRowMapper;

public class AuthorDao extends BaseDao{
	
	public void save(final AuthorModel model){
//		String sql="insert into authors values('"+model.getAuthorId()+"','"+model.getFirstName()+"','"+model.getLastName()+"')";
//		super.updateBySql(sql);
		String sql = "insert into authors (firstName,lastName) values(?, ?)";
		super.updateBySql(sql, new IParamBinding(){
			public void bindParam(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, model.getFirstName());
				pstmt.setString(2, model.getLastName());
			}
		});
	}
	
	public void update(AuthorModel model){
		String sql = String
		.format(
				"update authors set firstName='%s', lastName='%s' where authorid=%d ",
				model.getFirstName(), model.getLastName(), model
						.getAuthorId());
		super.updateBySql(sql);
	}
	
	public void delete(int authorId){	
		super.updateBySql("delete from authors where authorId="+authorId);
	}
	
	@SuppressWarnings("unchecked")
	public AuthorModel get(int authorId){
		String sql="select * from authors where authorId="+authorId;
		List<AuthorModel> models=queryBySql(sql, new AuthorRowMapper());
		return models.size()==0?null : models.get(0);
	}
	
	@SuppressWarnings("unchecked")
	public List<AuthorModel> queryAll(){
			return super.queryBySql("select * from authors", new AuthorRowMapper());	
		}
	
	class AuthorRowMapper implements IRowMapper{
		public Object mappingRow(ResultSet rs) throws SQLException {
			AuthorModel model=new AuthorModel(rs.getInt("authorId"), rs.getString("firstName"),rs.getString("lastName"));
			return model;
		}
	}	
}
