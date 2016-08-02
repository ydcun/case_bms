<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/checkLoginSession.jsp" %>
<%
	AuthorDao dao = new AuthorDao();
	int authorId=Integer.parseInt(request.getParameter("id"));
	AuthorModel model=dao.get(authorId);
%>
<%@page import="com.runwit.books.db.AuthorDao"%>
<%@page import="java.util.List"%>
<%@page import="com.runwit.books.model.AuthorModel"%>
<html>
	<head>
		<title>图书信息管理系统-作者管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
		
		<script type="text/javascript">
			function checkForm(myform){
				var fName = myform.firstName.value;
				var lName = myform.lastName.value;
				if(fName==""){
					alert('名不能为空');
					myform.firstName.focus();
					return false;
				}
				if(lName==""){
					alert('姓不能为空');
					myform.lastName.focus();
					return false;
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
					<td>名：<input type="text" name="firstName" value="<%=model.getFirstName() %>"/>
					           姓：<input type="text" name="lastName" value="<%=model.getLastName() %>"/>
					           <input type="hidden" name="authorId" value="<%=authorId %>"/>
					    <input type="submit" value="修改新作者"/>       
					</td>
				</tr>
			</table>
		
		</form>
	</body>
</html>
