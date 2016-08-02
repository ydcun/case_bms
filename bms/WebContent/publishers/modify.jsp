<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/checkLoginSession.jsp" %>
<%
	PublisherDao dao = new PublisherDao();
	int publisherId=Integer.parseInt(request.getParameter("id"));
	PublisherModel model=dao.get(publisherId);
%>
<%@page import="com.runwit.books.db.PublisherDao"%>
<%@page import="java.util.List"%>
<%@page import="com.runwit.books.model.PublisherModel"%>
<html>
	<head>
		<title>图书信息管理系统-作者管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
		
		<script type="text/javascript">
			function checkForm(myform){
				var pName = myform.publisherName.value;
				if(pName==""){
					alert('出版社名称不能为空');
					myform.publisherName.focus();
					return false;
				}
				return true;
			}
		
		</script>
	</head>
	<body>
		<%@include file="../inc/head.jsp" %>
		
		<form action="update.jsp" method="post" name="publisherform" onsubmit="return checkForm (this)">
			<table align="center" width=980>
				<tr>
					<td>出版社名称：<input type="text" name="publisherName" value="<%=model.getPublisherName()%>"/>
					           <input type="hidden" name="publisherId" value="<%=publisherId %>"/>
					    <input type="submit" value="修改新作者"/>       
					</td>
				</tr>
			</table>
		
		</form>
	</body>
</html>
