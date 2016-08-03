package com.runwit.common.db;

import java.sql.Connection;
import java.sql.SQLException;

public interface IConnectionCreator {
	public boolean doInConnection(Connection conn) throws SQLException;
}
