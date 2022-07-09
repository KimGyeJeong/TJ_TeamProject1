<%@page import="test.package_.first.TestClass"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>test</h1>
<%
TestClass tc = new TestClass();
int result = tc.testSQL();
System.out.println("result");
%>

</body>
</html>