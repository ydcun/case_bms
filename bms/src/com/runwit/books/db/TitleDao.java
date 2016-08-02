package com.runwit.books.db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.apache.log4j.Logger;

import com.runwit.books.model.AuthorModel;
import com.runwit.books.model.TitleModel;
import com.runwit.common.db.BaseDao;
import com.runwit.common.db.IConnectionCreator;
import com.runwit.common.db.IRowMapper;

public class TitleDao extends BaseDao {
	static Logger  logger = Logger.getLogger(BaseDao.class);//Class
/* 不采用事务的做法
	public void save(final TitleModel model) {
		
		// todo: 需要改进， 放到事务中来做。
		String sql = "insert into titles(isbn, title, editionNumber, copyright, publisherId, imageFile, price) "
				+ "values(?, ?, ?, ?, ?, ?, ?)";
		super.updateBySql(sql, new IParamBinding() {
			public void bindParam(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, model.getIsbn());
				pstmt.setString(2, model.getTitle());
				pstmt.setInt(3, model.getEditionNumber());
				pstmt.setString(4, model.getCopyright());
				pstmt.setInt(5, model.getPublisherId());
				pstmt.setString(6, model.getImageFile());
				pstmt.setDouble(7, model.getPrice());
			}
		});

		String sql2 = "insert into authorIsbn(isbn, authorid) values(?, ?)";
		int[] aids = model.getAuthorIds(); // 作者ID列表
		if (aids != null) {
			for (int i = 0; i < aids.length; i++) {
				final int aid = aids[i];
				super.updateBySql(sql, new IParamBinding() {
					public void bindParam(PreparedStatement pstmt)
							throws SQLException {
						pstmt.setString(1, model.getIsbn());
						pstmt.setInt(2, aid);
					}
				});
			}
		}
	}

	public void update(final TitleModel model) {
		String sql = "update titles set title=?, editionNumber=?, copyright=?, publisherId=?, imageFile=?, price=? " +
				"where isbn=? ";
		super.updateBySql(sql, new IParamBinding() {
			public void bindParam(PreparedStatement pstmt) throws SQLException {
				pstmt.setString(1, model.getTitle());
				pstmt.setInt(2, model.getEditionNumber());
				pstmt.setString(3, model.getCopyright());
				pstmt.setInt(4, model.getPublisherId());
				pstmt.setString(5, model.getImageFile());
				pstmt.setDouble(6, model.getPrice());
				pstmt.setString(7, model.getIsbn());
			}
		});
		super.updateBySql("delete from authorisbn where isbn='"+model.getIsbn()+"'");
		String sql2 = "insert into authorIsbn(isbn, authorid) values(?, ?)";
		int[] aids = model.getAuthorIds(); // 作者ID列表
		if (aids != null) {
			for (int i = 0; i < aids.length; i++) {
				final int aid = aids[i];
				super.updateBySql(sql, new IParamBinding() {
					public void bindParam(PreparedStatement pstmt)
							throws SQLException {
						pstmt.setString(1, model.getIsbn());
						pstmt.setInt(2, aid);
					}
				});
			}
		}

	}
*/	
	public void save(final TitleModel model) {
		
		final String sql = "insert into titles(isbn, title, editionNumber, copyright, publisherId, imageFile, price) "
				+ "values(?, ?, ?, ?, ?, ?, ?)";
		super.executeInConnection(new IConnectionCreator(){
			public boolean doInConnection(Connection conn) throws SQLException {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, model.getIsbn());
				pstmt.setString(2, model.getTitle());
				pstmt.setInt(3, model.getEditionNumber());
				pstmt.setString(4, model.getCopyright());
				pstmt.setInt(5, model.getPublisherId());
				pstmt.setString(6, model.getImageFile());
				pstmt.setDouble(7, model.getPrice());
				pstmt.executeUpdate();
				pstmt.close();
				logger.debug(sql);
				String sql2 = "insert into authorIsbn(isbn, authorid) values(?, ?)";
				pstmt = conn.prepareStatement(sql2);
				int[] aids = model.getAuthorIds(); // 作者ID列表
				if (aids != null) {
					for (int i = 0; i < aids.length; i++) {
						final int aid = aids[i];
						pstmt.setString(1, model.getIsbn());
						pstmt.setInt(2, aid);
						pstmt.addBatch();
						logger.debug(sql2);
					}
					pstmt.executeBatch();
				}
				
				return true;
			}
		});
	}

	public void update(final TitleModel model) {
		
		final String sql = "update titles set title=?, editionNumber=?, copyright=?, publisherId=?, imageFile=?, price=? " +
		"where isbn=? ";
		super.executeInConnection(new IConnectionCreator(){
			public boolean doInConnection(Connection conn) throws SQLException {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, model.getTitle());
				pstmt.setInt(2, model.getEditionNumber());
				pstmt.setString(3, model.getCopyright());
				pstmt.setInt(4, model.getPublisherId());
				pstmt.setString(5, model.getImageFile());
				pstmt.setDouble(6, model.getPrice());
				pstmt.setString(7, model.getIsbn());
				pstmt.executeUpdate();
				pstmt.close();
				logger.debug(sql);
				//删除该图书的作者出版信息
				pstmt = conn.prepareStatement("delete from authorisbn where isbn='"+model.getIsbn()+"'");
				pstmt.executeUpdate();
				pstmt.close();
				
				String sql2 = "insert into authorIsbn(isbn, authorid) values(?, ?)";
				pstmt = conn.prepareStatement(sql2);
				int[] aids = model.getAuthorIds(); // 作者ID列表
				if (aids != null) {
					for (int i = 0; i < aids.length; i++) {
						final int aid = aids[i];
						pstmt.setString(1, model.getIsbn());
						pstmt.setInt(2, aid);
						pstmt.addBatch();
						logger.debug(sql2);
					}
					pstmt.executeBatch();
				}
				
				return true;
			}
		});
	}

	@SuppressWarnings("unchecked")
	public List<TitleModel> queryAll(){
		String sql = "select t.*, publisherName from titles t left outer join publishers p on t.publisherid=p.publisherid ";
		return super.queryBySql(sql, new TitleRowMapper());
	}
	
	@SuppressWarnings("unchecked")
	public List<TitleModel> quickSearch(String isbn, String title){
		String sql = "select t.*, publisherName from titles t left outer join publishers p on t.publisherid=p.publisherid ";
		if(isbn==null)isbn="";
		if(title==null)title="";
		sql += " where isbn like '%"+isbn+"%' and title like '%"+title+"%'"; 
		return super.queryBySql(sql, new TitleRowMapper());
		
	}
	
	@SuppressWarnings("unchecked")
	public TitleModel get(String isbn){
		String sql = "select t.*, publisherName from titles t left outer join publishers p on t.publisherid=p.publisherid where isbn='"+isbn+"'";
		List<TitleModel> models = super.queryBySql(sql, new TitleRowMapper());
		return models.size() == 0 ? null : models.get(0);
	}
	
	public void delete(String isbn){
		String sql = "delete from authorisbn where isbn='"+isbn+"'";
		String sql2 = "delete from titles where isbn='"+isbn+"'";
//		updateBySql(sql);
//		updateBySql(sql2);
		super.executeBatch(new String[] { sql, sql2 });
	} 
	
	@SuppressWarnings("unchecked")
	public Integer[] getAuthorIdsByIsbn(String isbn){
		String sql = "select authorid from authorisbn where isbn='"+isbn+"'";
		List<Integer> myList =  queryBySql(sql, new IRowMapper(){
			public Object mappingRow(ResultSet rs) throws SQLException {
				return rs.getInt(1);
			}
		});
		return (Integer[])myList.toArray(new Integer[0]);
	}
	
	@SuppressWarnings("unchecked")
	public List<AuthorModel> getAuthorModelsByIsbn(String isbn){
		String sql = "select authors.* from authors, authorisbn where authors.authorid=authorisbn.authorid and authorisbn.isbn='"
				+ isbn + "'";
		List<AuthorModel> myList =  queryBySql(sql, new IRowMapper(){
			public Object mappingRow(ResultSet rs) throws SQLException {
				AuthorModel model = new AuthorModel(rs.getInt("authorid"), rs
						.getString("firstName"), rs.getString("lastName"));
				return model;
			}
		});
		return myList;
	}
	
	
	class TitleRowMapper implements IRowMapper {
		public Object mappingRow(ResultSet rs) throws SQLException {
			TitleModel model = new TitleModel();
			model.setCopyright(rs.getString("copyright"));
			model.setEditionNumber(rs.getInt("editionNumber"));
			model.setImageFile(rs.getString("imageFile"));
			model.setIsbn(rs.getString("isbn"));
			model.setPrice(rs.getDouble("price"));
			model.setPublisherId(rs.getInt("publisherId"));
			model.setPublisherName(rs.getString("publisherName"));
			model.setTitle(rs.getString("title"));
			return model;
		}
	}

}
