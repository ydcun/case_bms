<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	PublisherDao dao=new PublisherDao();
	request.setCharacterEncoding("UTF-8");
	String publisherName= request.getParameter("publisherName");
	int publisherId=Integer.parseInt(request.getParameter("publisherId"));
	PublisherModel model=new PublisherModel(publisherId,publisherName);
	dao.update(model);
	response.sendRedirect("index.jsp");
%>

<%@page import="com.runwit.books.db.PublisherDao"%>
<%@page import="com.runwit.books.model.PublisherModel"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>