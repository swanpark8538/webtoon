<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%
	response.sendRedirect("/webtoon?tab=all");
%>

	<%@ include file="/WEB-INF/views/common/header.jsp" %>

	메인

	<%@ include file="/WEB-INF/views/common/footer.jsp" %>

</html>