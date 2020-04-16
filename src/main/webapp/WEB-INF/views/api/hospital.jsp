<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>진단</title>
<table><c:forEach var="list" items="${list}">
<tr>

<c:if test="${list.status==1}">
<td><img src="../resources/img/normal.png"  style="width:50%"  /></td>
</c:if>
<c:if test="${list.status==2}">
<td><img src="../resources/img/dangerous.png"  style="width:50%"  /></td>
</c:if>
<c:if test="${list.status==3}">
<td><img src="../resources/img/good.png"  style="width:50%"  /></td>
</c:if>
<c:if test="${list.status==4}">
<td><img src="../resources/img/sobad.png"  style="width:50%"  /></td>
</c:if>

<td>${list.inputdate}</td></tr>
</c:forEach></table>
</body>
</html>