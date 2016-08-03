<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/checkLoginSession.jsp" %>
<%
	UserDao dao = new UserDao();
	int userId=Integer.parseInt(request.getParameter("id"));
	UserModel model=dao.get(userId);
%>
<%@page import="com.runwit.books.db.AuthorDao"%>
<%@page import="java.util.List"%>
<%@page import="com.runwit.books.model.AuthorModel"%>

<%@page import="com.runwit.books.db.UserDao"%>
<%@page import="com.runwit.books.model.UserModel"%><html>
	<head>
		<title>图书信息管理系统-用户管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
		
		<script type="text/javascript">
			function checkForm(myform){
				
				var fname = myform.name.value;
				var faccount = myform.account.value;
				var fpassword = myform.password.value;
				if(fname==""){
					alert('姓名不能为空');
					myform.name.focus();
					return false;
				}
				if(faccount==""){
					alert('账户不能为空');
					myform.account.focus();
					return false;
				}
				if(fpassword==""){
					alert('密码不能为空');
					myform.password.focus();
					return false;
				}else{
					if(fpassword.length<6 || fpassword.length>20){
					alert('密码长度不能小于6或 大于20');
					myform.password.focus();
					return false;
					}
				}
				
				return true;
			}
		
		</script>
	</head>
	<body>
		<%@include file="../inc/head.jsp" %>
		
		<form action="update.jsp" method="post" name="authorform" onsubmit="return checkForm (this)">
			<table align="center" width=980>
				<tr>
					<td>姓名：<input type="text" name="name" value="<%=model.getName() %>"/>
					           账号：<input type="text" name="account" value="<%=model.getAccount() %>"/>
					           密码：<input type="text" name="password" value="<%=model.getPassword() %>"/>
					          <input type="hidden" name="userId" value="<%=model.getUserId() %>" />
					    <input type="submit" value="修改用户信息"/>       
					</td>
				</tr>
			</table>
		
		</form>
	</body>
</html>
