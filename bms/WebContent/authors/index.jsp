<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/checkLoginSession.jsp" %>
<%
	AuthorDao dao = new AuthorDao();
	List<AuthorModel> authors = dao.queryAll();
	String url=request.getContextPath();
%>
<%@page import="com.runwit.books.db.AuthorDao"%>
<%@page import="java.util.List"%>
<%@page import="com.runwit.books.model.AuthorModel"%>

<%@page import="com.runwit.common.util.PageUtil"%><html>
	<head>
		<title>图书信息管理系统-作者管理</title>
		<link rel=stylesheet href="<%=request.getContextPath() %>/inc/main.css" type="text/css">
		
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
		
		<form action="add.jsp" method="post" name="authorform" onsubmit="return checkForm (this)">
			<table align="center" width=980>
				<tr>
					<td>名：<input type="text" name="firstName"/>
					           姓：<input type="text" name="lastName"/>
					    <input type="submit" value="添加新作者"/>       
					</td>
				</tr>
			</table>
		
		</form>
		
		<table align="center" width=980 >
			<caption>作者列表</caption>
			<tr>
				<th width="50">序号</th>
				<th width=150>作者id</th>
				<th width=275>名</th>
				<th width=275>姓</th>
				<th width=230>操作</th>
			</tr>
			<%
				int recordCount=authors.size();//记录总数
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
					AuthorModel model = authors.get(i);
			%>
			
			<tr>
					<th width="50"><%=i+1 %></th>
					<td width="150"><%=model.getAuthorId()%></td>
					<td width="275"><%=model.getFirstName() %></td>
					<td width="275"><%=model.getLastName() %></td>
					<td width="230"><a href="modify.jsp?id=<%=model.getAuthorId() %>">修改</a> | <a href="delete.jsp?id=<%=model.getAuthorId() %>" onclick="return confirm('确定要删除该记录[作者ID：<%=model.getAuthorId() %>]吗？');">删除</a></td>
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
