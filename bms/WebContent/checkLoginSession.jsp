<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	Object loginObj =  session.getAttribute("loginModel");
	if(loginObj == null) 
		response.sendRedirect("../login.jsp");
	
%>

<jsp:directive.page import="com.runwit.books.model.UserModel"/>