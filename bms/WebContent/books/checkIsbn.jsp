<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:directive.page import="com.runwit.books.db.TitleDao"/>
<jsp:directive.page import="com.runwit.books.model.TitleModel"/>
<html>
	<head>
		<title>朗慧图书管理信息系统-图书管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
		<style type="text/css">
			table select {
				width: 200px;
			}
			.tcolumn {
				background: #DDDDFF;
			}
		</style>
	</head>
	<body>
	
	<p align="center">
		<%
			String isbn = request.getParameter("isbn");
			TitleModel model = new TitleDao ().get(isbn);
			if(model == null) {
				out.println("isbn不存在， 您可以正常使用！");
			}
			else
			{
				out.println("isbn已经存在， 不能录入！");
			}
		 %>
	</p>
	<p align="center">
		<a href="#" onclick="javascript:window.close(); return false;">关闭窗口</a>
	</p>
	</body>
</html>
