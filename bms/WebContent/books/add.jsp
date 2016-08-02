<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:directive.page import="com.runwit.books.db.AuthorDao" />
<jsp:directive.page import="java.util.List" />
<jsp:directive.page import="com.runwit.books.model.AuthorModel" />
<jsp:directive.page import="com.runwit.books.db.PublisherDao" />
<jsp:directive.page import="com.runwit.books.model.PublisherModel" />
<%@include file="/checkLoginSession.jsp" %>
<%
	AuthorDao authorDAO = new AuthorDao();
	List<AuthorModel> authors = authorDAO.queryAll();	
	
	PublisherDao publisherDAO = new PublisherDao();
	List<PublisherModel> publishers = publisherDAO.queryAll();
%>
<html>
	<head>
		<title>朗慧图书管理信息系统-图书管理</title>
		<link rel=stylesheet href="../inc/main.css" type="text/css">
		<style type="text/css">
			table select {
				width: 200px;
			}
			.tcolumn {
				background: #DDDDFF;
			}
		</style>
		<script type="text/javascript">
			//fromSel: 源选择框， toSel:目标选择框
			function moveitem(fromSel, toSel) {
				var fromOpts = fromSel.options; //源选择项列表数组
				var toOpts = toSel.options;  //目标选择项列表数组
				var idx = 0; //当前索引
				var toLen = toOpts.length; // 目标选择框已有的项数
				//遍历所有的源选择项列表数组
				for(var i=fromOpts.length-1; i>=0; i--) {
					if(fromOpts[i].selected){ //如果选中
						toOpts[toLen+idx] = new Option(fromOpts[i].text, fromOpts[i].value);//添加到目标选择框中
						fromOpts[i] = null; //删除源选择框中的选中项
						idx++;
					}
				}
				
			}
			
			//表单提交
			function checkForm(myform) {
				var authorOpts = myform.authorIds.options;
				if(authorOpts != null) {
				
					for(var i=0; i<authorOpts.length; i++) {
						authorOpts[i].selected = true;
					}
				}
				
				if(myform.isbn.value == "") {
					alert('isbn必须输入！');
					myform.isbn.focus();
					return false;
				}
				if(myform.title.value == "") {
					alert('书名必须输入！');
					myform.title.focus();
					return false;
				}
				if(myform.publisherId.value == "") {
					alert('出版社必须选择！');
					myform.publisherId.focus();
					return false;
				}
				var price = parseFloat(myform.price.value);
				if(isNaN(price)){
					alert('价格必须为数字！');
					myform.price.focus();
					return false;
				}
				var copyright = myform.copyright.value;
				if(copyright.length != 4 || isNaN(parseInt(copyright))){
					alert('出版年份必须为4位数字!');
					myform.copyright.focus();
					return false;
				}
				var editionNumber = parseInt(myform.editionNumber.value);
				if(isNaN(editionNumber)) {
					alert('版本号必须为数字！');
					myform.editionNumber.focus();
					return false;
				}
				
				return true;
			}
			
			function checkIsbn(isbn) {
				if(isbn.value == "") {
					alert('请先输入ISBN');
					form1.isbn.focus();
					return false;
				}
				
				window.open('checkIsbn.jsp?isbn='+isbn.value,'checkwin', 'width=500,height=400,scrollbar=yes,resizable=no,status=yes' );
			}
		</script>
	</head>
	<body>
		<%@include file="/inc/head.jsp"%>
		<form action="add_do.jsp" method="post" name="form1"
			onsubmit="return checkForm(this);">
			<table align="center" width="980">
				<caption>
					添加新图书
				</caption>
				<tr>
					<td width="250" class="tcolumn">
						图书ISBN
					</td>
					<td width="730">
						<input type="text" name="isbn" size="40" id="isbn">
						*
						<input type="button" value="检查ISBN是否存在" onclick="checkIsbn(form1.isbn);">
					</td>
				</tr>
				<tr>
					<td class="tcolumn">
						书名
					</td>
					<td>
						<input type="text" name="title" size="40">
						*
					</td>
				</tr>
				<tr>
					<td class="tcolumn">
						出版社
					</td>
					<td>
						<select name="publisherId">
							<option value="">
								请选择...
							</option>
							<%
							for(PublisherModel model : publishers) {
							%>
							<option value="<%=model.getPublisherId()%>">
								<%=model.getPublisherName()%>
							</option>
							<%
							}
							%>
						</select>
					</td>
				</tr>
				<tr>
					<td class="tcolumn">
						价格
					</td>
					<td>
						<input type="text" name="price">
						*
					</td>
				</tr>
				<tr>
					<td class="tcolumn">
						出版年份
					</td>
					<td>
						<input type="text" name="copyright">
						*
					</td>
				</tr>
				<tr>
					<td class="tcolumn">
						版本号
					</td>
					<td>
						<input type="text" name="editionNumber">
						*
					</td>
				</tr>
				<tr>
					<td class="tcolumn">
						作者
					</td>
					<td>
						<table>
							<tr>
								<td>
									<select name="allauthors" multiple="multiple" size="8">
										<%
										for(AuthorModel model : authors) {
										%>
										<option value="<%=model.getAuthorId()%>">
											<%=model.getFirstName()%>
											&nbsp;
											<%=model.getLastName()%>
										</option>
										<%
										}
										%>
									</select>
								</td>
								<td>
									<input type="button" value="增加>>"
										onclick="javascript:moveitem(form1.allauthors, form1.authorIds);">
									<br>
									<input type="button" value="<<删除"
										onclick="javascript:moveitem( form1.authorIds, form1.allauthors);">
								</td>
								<td>
									<select name="authorIds" multiple="multiple" size="8">
									</select>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2" align="center" class="tcolumn">
						<input type="submit" value="增加">
						<input type="reset" value="清空">
					</td>
				</tr>
			</table>
		</form>
</html>
