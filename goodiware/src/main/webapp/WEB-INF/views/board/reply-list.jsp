<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

								 <table style="width:830px" class="reply-container">
	                             	<tbody>
	                                   	<c:forEach items="${ replies }" var="reply">
	                                   	<tr>
	                                   		<td></td>
	                                   		<td scope="col" id="replyContent">
	                                   		${ reply.name }&nbsp;&nbsp;|&nbsp;&nbsp;
	                                   		<fmt:formatDate value="${ reply.rdate }" pattern="yyyy.MM.dd. hh:mm"/>
	                                   		</td>
	                                   		<td scope="col">
	                                   		<%-- <p class="button-container" data-rno="${ reply.rno }"> --%>
	                                   		<a href="#" class="updateReply" data-rno="${ reply.rno }">수정</a>
	                                   		&nbsp;|&nbsp;
	                                   		<a href="#" class="deleteReply" data-rno="${ reply.rno }">삭제</a>
	                                   		<!-- </p> -->
	                                   		</td>
	                                   	</tr>
	                                   	<tr>
	                                   		<td></td>
	                                   		<td colspan="2" class="reply-content">${ reply.rcontent }</td>
	                                   		<td colspan="2" class="update-content">
	                                   		<form id="update-form" class="user">
												<div class="input-group mb-3">
												  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id=""  name="" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append">
												    <button class="btn btn-outline-secondary" type="button" id="replyRegist" style="height:50px;width:80px">수정</button>
												  </div>
												</div>
											</form>
	                                   		</td>
	                                   	</tr>
	                                   <!-- 	<tr class="updateContent">
	                                   		<td>
	                                   		<form id="update-form" class="user">
												<div class="input-group mb-3">
												  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id=""  name="" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append">
												    <button class="btn btn-outline-secondary" type="button" id="replyRegist" style="height:50px;width:80px">수정</button>
												  </div>
												</div>
											</form>
	                                   		</td>
	                                   	</tr> -->
	                                   	</c:forEach>
	                                  	 <tr>
	                                   		<td colspan="3" style="text-align: center">pager</td>
	                                   	</tr>
	                            	</tbody>
	                           	</table>