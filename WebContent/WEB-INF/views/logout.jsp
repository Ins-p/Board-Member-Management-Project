<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="common.jsp" %>


<%
	session.removeAttribute("admin_id");
%>

<script>
	location.replace("${requestScope.croot}/loginForm.do")
</script>