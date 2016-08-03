<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<jsp:directive.page import="com.runwit.books.db.TitleDao" />
<jsp:directive.page import="com.runwit.books.model.TitleModel" />
<jsp:useBean id="titleModel" class="com.runwit.books.model.TitleModel">
	<jsp:setProperty name="titleModel" property="*" />
</jsp:useBean>
<%
	TitleDao dao = new TitleDao();
	TitleModel myModel = dao.get(titleModel.getIsbn());
	if (myModel != null) {
		out
		.println("<script langugage='javascript'>alert('isbn已经存在！');history.go(-1);</script>");
	} else
		dao.save(titleModel);
%>
<html>

	<head>
		<title>朗慧图书管理信息系统-图书管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
	</head>
	<table align="center" width="150">
		<caption>
			图书添加成功！
		</caption>
		<tr>
			<td>
				<a href="add.jsp">返回添加页面</a>
			</td>
		</tr>
		<tr>
			<td>
				<a href="index.jsp">返回图书列表页面</a>
			</td>
		</tr>
	</table>
</html>


