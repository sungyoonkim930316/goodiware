<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

								 <table>
	                             	<tbody style="width:832px">
	                                   	<c:forEach items="${ replies }" var="reply">
	                                   	<tr>
	                                   		<td>${ reply.name }</td>
	                                   		<td>${ reply.rcontent }</td>
	                                   		<td>${ reply.rdate }</td>
	                                   	</tr>
	                                   	</c:forEach>
	                                  	 <tr>
	                                   		<td colspan="3" style="text-align: center">pager</td>
	                                   	</tr>
	                            	</tbody>
	                           	</table>