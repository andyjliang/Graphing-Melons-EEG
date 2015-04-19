<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="dynamoDBAccessor.DynamoDBAccessor"
%>
<jsp:useBean id='data' class = 'dynamoDBAccessor.DynamoDBAccessor' scope = 'session'/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
	var focusObj = []; 
<%
	Iterator<String> it = data.getSelectAttr().iterator();
	while(it.hasNext()){
%>
		focusObj.push(<%=it.next()%>)
<%
	}
%>
	var k;
	</script>
	<p>
	Words:
	</p>
</body>
</html>