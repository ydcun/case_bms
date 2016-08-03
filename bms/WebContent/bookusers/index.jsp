<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/checkLoginSession.jsp" %>
<%
	UserDao useDao = new UserDao();
	List<UserModel> users = useDao.queryAll();
%>
<%@page import="com.runwit.books.db.AuthorDao"%>
<%@page import="java.util.List"%>
<%@page import="com.runwit.books.model.AuthorModel"%>

<%@page import="com.runwit.common.util.PageUtil"%>
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
					if(fpassword.length<5 || fpassword.length>20){
					alert('密码长度不能小于5或 大于20');
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
		
		<form action="add.jsp" method="post" name="authorform" onsubmit="return checkForm (this)">
			<table align="center" width=980>
				<tr>
					<td>姓名：<input type="text" name="name" />
					           账号：<input type="text" name="account"/>
					           密码：<input type="text" name="password"/>
					    <input type="submit" value="添加新用户"/>       
					</td>
				</tr>
			</table>
		
		</form>
		
		<table align="center" width=980 >
			<caption>用户列表</caption>
			<tr>
				<th width=150>用户ID</th>
				<th width=200>姓名</th>
				<th width=200>账号</th>
				<th width=230>创建时间</th>
				<th width=200>操作</th>
			</tr>
			<%
				int recordCount=users.size();//记录总数
				int pageSize=8;//每页显示条数
				String currentPageStr=request.getParameter("page");
				int pageCount=recordCount/pageSize;//总页数
				if(recordCount%pageSize>0){
					pageCount++;
				}
				int currentPage=1;
				if(currentPageStr!=null){
					currentPage=Integer.parseInt(currentPageStr);
				}
				PageUtil pageUtil = new PageUtil(pageSize,recordCount,currentPage);
			%>
			<%
				for(int i=pageUtil.getFromIndex() ;i<pageUtil.getToiIndex();i++) {
					UserModel model = users.get(i);
			%>
			
			<tr>
				<td ><%=model.getUserId() %></td>
				<td ><%=model.getName() %></td>
				<td ><%=model.getAccount() %></td>
				<td><%=model.getCreateTime() %></td>
				<td ><a href="modify.jsp?id=<%=model.getUserId() %>">修改</a> 
				| <a href="delete.jsp?id=<%=model.getUserId() %>" 
				onclick="return confirm('确定要删除该记录[用户ID：<%=model.getUserId() %>]吗？');">删除</a>
				</td>
			</tr>
			<%
				}
				
			%>
			<tr>
				<td colspan="8" align="right">
					记录总数<%=recordCount %> 每页显示<%=pageSize %>条  当前页/总页数<%=pageUtil.getCurrentPage() %>/<%=pageUtil.getPageCount() %>
					<a href="index.jsp?page=1">首页&nbsp;&nbsp;|</a>
					<a href="index.jsp?page=<%=pageUtil.getPrevPage() %>">上页&nbsp;&nbsp;|</a>
					<a href="index.jsp?page=<%=pageUtil.getNextPage() %>">下页&nbsp;&nbsp;|</a>
					<a href="index.jsp?page=<%=pageUtil.getPageCount() %>">末页</a>
					跳到<input type="text" size="3" id="newPage">页 <input type="button" value="Go" onclick="processGoPage()">
					<script type="text/javascript">
					function processGoPage() {
						var newPage = document.getElementById("newPage").value;
						if(isNaN(parseInt(newPage))){
							alert('页面格式非法！');
							document.getElementById("newPage").focus();
							document.getElementById("newPage").value="";
						}else {
							window.location.href="index.jsp?page="+newPage;
						}
					}
					</script>
				</td>
			</tr>
		</table>
	</body>
</html>
