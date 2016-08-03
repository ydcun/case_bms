
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	AuthorDao dao=new AuthorDao();
	request.setCharacterEncoding("UTF-8");
	String firstName= request.getParameter("firstName");
	String lastName=request.getParameter("lastName");
	final AuthorModel model=new AuthorModel(0,firstName,lastName);
	dao.save(model);
	response.sendRedirect("index.jsp");
%>


<%@page import="com.runwit.books.db.AuthorDao"%>
<%@page import="com.runwit.books.model.AuthorModel"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>