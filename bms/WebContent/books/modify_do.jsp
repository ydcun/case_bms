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
		dao.update(titleModel);
		
		String url = "index.jsp";
		url=ParamUtil.appendParam(url,"isbn",request.getParameter("qisbn"));
		url=ParamUtil.appendParam(url,"page",request.getParameter("page"));
		url=ParamUtil.appendParam(url,"title",request.getParameter("qtitle"));
		
%>

<%@page import="com.runwit.common.util.ParamUtil"%><html>

	<head>
		<title>朗慧图书管理信息系统-图书管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
	</head>
	<table align="center" width="150">
		<caption>
			图书修改成功！
		</caption>
		<tr>
			<td>
				<a href="<%=url %>">返回图书列表页面</a>
			</td>
		</tr>
	</table>
</html>


