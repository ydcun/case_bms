package com.runwit.books.db;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;


import com.runwit.books.model.PublisherModel;
import com.runwit.common.db.BaseDao;
import com.runwit.common.db.IParamBinding;
import com.runwit.common.db.IRowMapper;

public class PublisherDao extends BaseDao{
	
	public void save(final PublisherModel model){
//		String sql="insert into authors values('"+model.getAuthorId()+"','"+model.getFirstName()+"','"+model.getLastName()+"')";
//		super.updateBySql(sql);
		String sql = "insert into publishers (publisherName) values (?)";
		super.updateBySql(sql, new IParamBinding(){
			public void bindParam(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, model.getPublisherName());
			}
		});
	}
	
	public void update(PublisherModel model){
		String sql = String
		.format(
				"update publishers set publisherName='%s' where publisherId=%d ",
				model.getPublisherName(), model.getPublisherId() );
		super.updateBySql(sql);
	}
	
	public void delete(int publisherId){	
		super.updateBySql("delete from publishers where publisherId="+publisherId);
	}
	
	@SuppressWarnings("unchecked")
	public PublisherModel get(int publisherId){
		String sql="select * from publishers where publisherId="+publisherId;
		List<PublisherModel> models=queryBySql(sql, new PublisherRowMapper());
		return models.size()==0?null : models.get(0);
	}
	
	@SuppressWarnings("unchecked")
	public List<PublisherModel> queryAll(){
			return super.queryBySql("select * from publishers", new PublisherRowMapper());	
		}
	
	class PublisherRowMapper implements IRowMapper{
		public Object mappingRow(ResultSet rs) throws SQLException {
			PublisherModel model=new PublisherModel(rs.getInt("publisherId"), rs.getString("publisherName"));
			return model;
		}
	}	
}
