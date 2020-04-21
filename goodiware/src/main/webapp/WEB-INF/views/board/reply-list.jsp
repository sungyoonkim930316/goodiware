<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

								 <table style="width:830px" class="reply-container">
	                             	<tbody>
	                                   	<c:forEach items="${ replies }" var="reply">
	                                   	<tr>
	                                   		<td></td>
	                                   		<td scope="col" id="replyContent">
	                                   		<div>
		                                   		${ reply.name }&nbsp;&nbsp;|&nbsp;&nbsp;
		                                   		<fmt:formatDate value="${ reply.rdate }" pattern="yyyy.MM.dd. hh:mm"/>&nbsp;&nbsp;|&nbsp;&nbsp;
			                                   		<div id="rereply-button-${ reply.rno }" >
			                                   			<a href="#" class="reReply" data-rno="${ reply.rno }">답글쓰기</a>
			                                   		</div>
			                                   		<div class="cancel-container" id="cancel-button-${ reply.rno }" style="display:none">
			                                   			<a href="#" class="reReply-cancel" data-rno="${ reply.rno }">답글취소</a>
			                                   		</div>
		                                   	</div>
	                                   		</td>
	                                   		<td>
		                                   		<div id="reply-button-${ reply.rno }">
		                                   		<c:if test="${ reply.empno == loginuser.empno }">
			                                   		<a href="#" class="editReply" data-rno="${ reply.rno }">수정</a>
			                                   		&nbsp;|&nbsp;
			                                   		<a href="#" class="deleteReply" data-rno="${ reply.rno }">삭제</a>
			                                   	</c:if>
		                                   		</div>
		                                   		<div id="reply-cancel-${ reply.rno }" style="display:none">
		                                   			<a href="#" class="cancelReply" data-rno="${ reply.rno }">수정취소</a>
		                                   		</div>
	                                   		</td>
	                                   	</tr>
	                                   	<!-- 댓글 수정 -->
	                                   	<tr>
	                                   		<td></td>
											<td colspan="2" class="reply-content">
												<div id="reply-view-${ reply.rno }">${ reply.rcontent }</div>
												<div id="reply-edit-${ reply.rno }" style="display:none">
			                                   		<form id="rereply-form" class="user">
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
	                                   	<!-- 대댓글 등록 -->
	                                   	<tr id="rereply-hide-${ reply.rno }">
	                                   		<td></td>
	                                   		<td>
	                                   			<div id="rereply-regist-${ reply.rno }" style="display:none">
		                                   			<form id="rereply-form" class="user">
														<div class="input-group mb-3">
														  <input type="hidden" value="${ reply.rno }" name="rno">
														  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rercontent-${ reply.rno }" name="rercontent" style="height:50px">&nbsp;&nbsp;
														  <div class="input-group-append">
														    <button class="btn btn-outline-secondary rereply-button" type="button" data-rno="${ reply.rno }" style="height:50px;width:80px">등록</button>
														  </div>
														</div>
													</form>
												</div>
	                                   		</td>
	                                   		<td></td>
	                                   	</tr>
	                                   	</c:forEach>
	                                  	 <tr>
	                                   		<td colspan="3" style="text-align: center">pager</td>
	                                   	</tr>
	                            	</tbody>
	                           	</table>

                               	
                               	
                               	
                               	