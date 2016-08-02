<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

	<title>图书信息管理系统-登陆</title>
		<style type="text/css">
			table{
				font-size:12p;
			}
			table caption{
				font-size:16;
			}
		</style>
		<script type="text/javascript">
			function checkFrom(form){
				
				var account = form.account.value;
				var password = form.password.value;
				if(account == ""){
					alert('账户不能为空');
					form.account.focus();
					return false;
				}
				if(password == ""){
					alert('密码不能为空');
					form.password.focus();
					return false;
				}
				return true;
			}
		</script>
</head>
<body>
		<table align="center">
			<tr>
				<td>
					<img src="images/head.jpg">
				</td>
			</tr>
		</table>
		<%
			Object obj = request.getAttribute("errorMessage");
		%>
		<form action="processLogin.jsp" name="form1" method="post" onsubmit="return checkFrom(this)">
		<table align="center">
			<caption>用户登录</caption>
			<%if(obj!=null){ %>
			<tr>
				<td colspan="2">
					<span style="color : red"><%=obj %></span>
				</td>
			</tr>
			<%} %>
			<tr>
				<td>用户账号：</td>
				<td><input type="text" style="width:150px" name="account"/></td>
			</tr>
			<tr>
				<td>用户密码：</td>
				<td><input type="text" style="width:150px" name="password"/></td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="登录">
					<input type="reset" value="清空">
				</td>
			</tr>
		</table>
		</form>
	</body>
</html>