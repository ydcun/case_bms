<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	String account = request.getParameter("account");
	String password = request.getParameter("password");
	UserDao dao=new UserDao();
	UserModel model =dao.login(account,password);
	if(model==null){
		request.setAttribute("errorMessage","登陆失败，账号或密码有误！");
		request.getRequestDispatcher("/").forward(request,response);
	}else{
		session.setAttribute("loginModel",model);
		response.sendRedirect(request.getContextPath()+"/authors/index.jsp");
		//request.getRequestDispatcher("authors/index.jsp").forward(request,response);
	}
%>

<%@page import="com.runwit.books.db.UserDao"%>
<%@page import="com.runwit.books.model.UserModel"%><html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>