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
	                                   		<%-- <td scope="col">
			                                   		<a href="#" class="editReply" data-rno="${ reply.rno }">수정</a>
			                                   		&nbsp;|&nbsp;
			                                   		<a href="#" class="deleteReply" data-rno="${ reply.rno }">삭제</a>
	                                   		</td> --%>
	                                   		<td>
		                                   		<div id="reply-button-${ reply.rno }">
			                                   		<a href="#" class="editReply" data-rno="${ reply.rno }">수정</a>
			                                   		&nbsp;|&nbsp;
			                                   		<a href="#" class="deleteReply" data-rno="${ reply.rno }">삭제</a>
		                                   		</div>
		                                   		<div id="reply-cancel-${ reply.rno }" style="display:none">
		                                   			<a href="#" class="cancelReply" data-rno="${ reply.rno }">수정취소</a>
		                                   		</div>
	                                   		</td>
	                                   	</tr>
	                                   	<tr>
	                                   		<td></td>
<%-- 	                                   		<td colspan="2" class="reply-content">${ reply.rcontent }</td>
	                                   		<td class="update-content">
	                                   		<form id="update-form" class="user">
												<div class="input-group mb-3">
												  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id=""  name="" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append">
												    <button class="btn btn-outline-secondary" type="button" id="replyRegist" style="height:50px;width:80px">수정</button>
												  </div>
												</div>
											</form>
	                                   		</td> --%>
											<td colspan="2" class="reply-content">
												<div id="reply-view-${ reply.rno }">${ reply.rcontent }</div>
												<div id="reply-edit-${ reply.rno }" style="display:none">
			                                   		<form id="edit-form" class="user">
														<div class="input-group mb-3">
														  <input type="hidden" value="${ reply.rno }" name="rno">
														  <input type="text" value="${ reply.rcontent }" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rcontent-${ reply.rno }" name="rcontent" style="height:50px">&nbsp;&nbsp;
														  <div class="input-group-append">
														    <button class="btn btn-outline-secondary edit-button" type="button" data-rno="${ reply.rno }" style="height:50px;width:80px">수정</button>
														  </div>
														</div>
													</form>
												</div>
	                                   		</td>
	                                   	</tr>
	                                   	</c:forEach>
	                                  	 <tr>
	                                   		<td colspan="3" style="text-align: center">pager</td>
	                                   	</tr>
	                            	</tbody>
	                           	</table>

                               	
                               	
                               	
                               	