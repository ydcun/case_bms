<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@include file="/checkLoginSession.jsp" %>
<%
	PublisherDao dao = new PublisherDao();
	List<PublisherModel> publishers = dao.queryAll();
%>
<%@page import="com.runwit.books.db.PublisherDao"%>
<%@page import="java.util.List"%>
<%@page import="com.runwit.books.model.PublisherModel"%>

<%@page import="com.runwit.common.util.PageUtil"%><html>
	<head>
		<title>图书信息管理系统-出版社管理</title>
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
		
		<form action="add.jsp" method="post" name="publisherform" onsubmit="return checkForm (this)">
			<table align="center" width=980>
				<tr>
					<td>出版社名称：<input type="text" name="publisherName"/>
					    <input type="submit" value="添加新出版社"/>       
					</td>
				</tr>
			</table>
		
		</form>
		
		<table align="center" width=980 >
			<caption>出版社列表</caption>
			<tr>
				<th width="50">序号</th>
				<th width=240>出版社id</th>
				<th width=470>出版社名称</th>
				<th width=220>操作</th>
			</tr>
			<%
				int recordCount=publishers.size();//记录总数
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
					PublisherModel model = publishers.get(i);
			%>
			
			<tr>
					<th width="50"><%=i+1 %></th>
					<td width="240"><%=model.getPublisherId()%></td>
					<td width="470"><%=model.getPublisherName() %></td>
					<td width="220"><a href="modify.jsp?id=<%=model.getPublisherId() %>">修改</a> | <a href="delete.jsp?id=<%=model.getPublisherId() %>" onclick="return confirm('确定要删除该记录[作者ID：<%=model.getPublisherId() %>]吗？');">删除</a></td>
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
