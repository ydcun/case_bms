package com.runwit.common.db;

import java.sql.ResultSet;
import java.sql.SQLException;

public interface IRowMapper {
	public Object mappingRow(ResultSet rs) throws SQLException;
}
