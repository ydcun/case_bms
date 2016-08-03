<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:directive.page import="com.runwit.books.db.TitleDao"/>
<jsp:directive.page import="com.runwit.books.model.TitleModel"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.runwit.books.model.AuthorModel"/>
<%@include file="/checkLoginSession.jsp" %>
<%
	//AuthorDAO dao = new AuthorDAO();
	//List<AuthorModel> authors = dao.queryAll();	
	TitleDao titleDAO = new TitleDao();
	TitleModel model = titleDAO.get(request.getParameter("isbn"));
	List<AuthorModel> authors = titleDAO.getAuthorModelsByIsbn(request.getParameter("isbn"));
%>
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
		<%@include file="/inc/head.jsp" %>
		<table align="center" width="980">
			<caption>图书详细信息</caption>
			<tr>
				<td width="250" class="tcolumn">图书ISBN</td>
				<td width="730">
					 <%=model.getIsbn() %>
				</td>
			</tr>
			<tr>
				<td class="tcolumn">书名</td>
				<td>
					<%=model.getTitle() %>
				</td>
			</tr>
			<tr>
				<td class="tcolumn">出版社</td>
				<td>
					<%=model.getPublisherName() %>
				</td>
			</tr>
			<tr>
				<td class="tcolumn">价格</td>
				<td>
					<%=model.getPrice() %>
				</td>
			</tr>
			<tr>
				<td class="tcolumn">出版年份</td>
				<td>
					<%=model.getCopyright() %>
				</td>
			</tr>
			<tr>
				<td class="tcolumn">版本号</td>
				<td>
					<%=model.getEditionNumber() %>
				</td>
			</tr>
			<tr>
				<td class="tcolumn">作者</td>
				<td>
				<%
					for(AuthorModel m : authors) {
						out.println(m.getFirstName()+"&nbsp;" + m.getLastName()+"<br>");
					}
				 %>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center" class="tcolumn">
					<input type="button" value="关闭窗口" onclick="window.close();">
				</td>
			</tr>
		</table>
	</html>