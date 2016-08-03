<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	PublisherDao dao=new PublisherDao();
	dao.delete(Integer.parseInt(request.getParameter("id")));
	response.sendRedirect("index.jsp");
%>


<%@page import="java.io.PrintWriter"%>
<%@page import="com.runwit.books.db.PublisherDao"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>