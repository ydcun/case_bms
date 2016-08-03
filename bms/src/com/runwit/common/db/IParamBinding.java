package com.runwit.common.db;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public interface IParamBinding {
	public void bindParam(PreparedStatement pstmt) throws SQLException;
}
