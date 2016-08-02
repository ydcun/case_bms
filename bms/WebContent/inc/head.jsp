<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="com.runwit.books.model.UserModel"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>head.jsp</title>
<link rel=stylesheet href="../inc/main.css" type="text/css">
</head>
<body>
<table align="center" width="980" style="background:#607cac" id="headtb">
			<tr>
				<td colspan="2">
					<img src="<%=request.getContextPath() %>/images/head.jpg">
				</td>
			</tr>
			<%
				UserModel loginModel = (UserModel)session.getAttribute("loginModel");
				String loginName = "";
				if(loginModel!=null)
				{
					loginName=loginModel.getName();
				}
			%>
			<tr style="background:url(<%=request.getContextPath() %>/images/headbg.jpg) repeat-x">
				<td>
					欢迎  <%=loginName %> [<a href="<%=request.getContextPath() %>/bookusers/modify.jsp?id=<%=loginModel.getUserId() %>">更改密码</a>|<a href="<%=request.getContextPath() %>/logout.jsp">退出系统</a>]
				</td>
				<td align="right" height=25>
					<a href="<%=request.getContextPath() %>/authors/index.jsp">作者管理 </a> |
					<a href="<%=request.getContextPath() %>/publishers/index.jsp">出版社管理 </a> |
					<a href="<%=request.getContextPath() %>/books/index.jsp">图书管理 </a> |
					<a href="<%=request.getContextPath() %>/books/index.jsp">图书查询 </a> |
					<a href="<%=request.getContextPath() %>/bookusers/index.jsp">用户管理 </a> |
				</td>
			</tr>
		</table>
</body>
</html>