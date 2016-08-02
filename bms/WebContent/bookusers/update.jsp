<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="userModel" class="com.runwit.books.model.UserModel">
	<jsp:setProperty name="userModel" property="*" />
</jsp:useBean>
<%
	UserDao dao=new UserDao();
	dao.update(userModel);
	response.sendRedirect("index.jsp");
%>

<%@page import="com.runwit.books.db.AuthorDao"%>
<%@page import="com.runwit.books.model.AuthorModel"%>
<%@page import="com.runwit.books.db.UserDao"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>