<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:directive.page import="com.runwit.books.db.TitleDao"/>
<jsp:directive.page import="java.util.List"/>
<jsp:directive.page import="com.runwit.books.model.TitleModel"/>
<%@include file="/checkLoginSession.jsp" %>
<%	
	TitleDao titleDAO = new TitleDao();
	String isbn = ParamUtil.getString(request.getParameter("isbn"));
	String title = ParamUtil.getString(request.getParameter("title"));
	List<TitleModel> titles = titleDAO.quickSearch(isbn,title);
	String queryParam = "&isbn="+isbn+"&title="+title; 
%>

<%@page import="com.runwit.common.util.PageUtil"%>
<%@page import="com.runwit.common.util.ParamUtil"%><html>
	<head>
		<title>朗慧图书管理信息系统-图书管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
		<style type="text/css">
		</style>
	</head>
	<body>
		<%@include file="../inc/head.jsp" %>
		<form action="index.jsp" method="post" name="form1" >
		<table align="center" width="980">
			<tr>
				<td>
					ISBN <input type="text" name="isbn" size="20" value="<%=isbn %>"">
					书名 <input type="text" name="title" size="20" value="<%=title %>"">
					<input type="submit" value="快速搜索">
				</td>
			</tr>
		</table>
		</form>
		<table align="center" width="980">
				<caption>图书列表</caption>
			<tr><td colspan="7"><a href="add.jsp">+添加新图书</a></td></tr>
			<tr>
					<th width="50">序号</th>
					<th width="130">图书ISBN</th>
					<th width="300">书名</th>
					<th width="150">出版社名称</th>
					<th width="70">价格</th>
					<th width="70">版本号</th>
					<th width="80">出版年份</th>
					<th width="130">操作</th>
			</tr>
			<%
				int recordCount=titles.size();//记录总数
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
					TitleModel model=titles.get(i);
			%>
				
			<tr>
					<th width="50"><%=i+1 %></th>
					<td width="130"><%=model.getIsbn() %></td>
					<td width="300"><a href="bookdetails.jsp?isbn=<%=model.getIsbn() %>" target="_blank"><%=model.getTitle() %></a></td>
					<td width="150"><%=model.getPublisherName() %></td>
					<td width="70"><%=model.getPrice() %></td>
					<td width="70"><%=model.getEditionNumber() %></td>
					<td width="80"><%=model.getCopyright() %></td>
					<td width="130"><a href="modify.jsp?isbn=<%=model.getIsbn() %>&page=<%=pageUtil.getCurrentPage() %>&qisbn=<%=isbn %>&title=<%=title %> ">修改</a> | <a href="delete.jsp?isbn=<%=model.getIsbn() %>&page=<%=pageUtil.getCurrentPage() %>&qisbn=<%=isbn %>&title=<%=title %>" onclick="return confirm('确定要删除该记录[ISBN：<%=model.getIsbn() %>]吗？');">删除</a></td>
			</tr>
			<%
				}
			%>
			<tr>
				<td colspan="8" align="right">
					记录总数<%=recordCount %> 每页显示<%=pageSize %>条  当前页/总页数<%=pageUtil.getCurrentPage() %>/<%=pageUtil.getPageCount() %>
					<a href="index.jsp?page=1<%=queryParam %>">首页&nbsp;&nbsp;|</a>
					<a href="index.jsp?page=<%=pageUtil.getPrevPage() %><%=queryParam %>">上页&nbsp;&nbsp;|</a>
					<a href="index.jsp?page=<%=pageUtil.getNextPage() %><%=queryParam %>">下页&nbsp;&nbsp;|</a>
					<a href="index.jsp?page=<%=pageUtil.getPageCount() %><%=queryParam %>">末页</a>
					跳到<input type="text" size="3" id="newPage">页 <input type="button" value="Go" onclick="processGoPage()">
					<script type="text/javascript">
					function processGoPage() {
						var newPage = document.getElementById("newPage").value;
						if(isNaN(parseInt(newPage))){
							alert('页面格式非法！');
							document.getElementById("newPage").focus();
							document.getElementById("newPage").value="";
						}else {
							window.location.href="index.jsp?page="+newPage+"<%=queryParam %>";
						}
					}
					</script>
				</td>
			</tr>
		</table>
	</html>