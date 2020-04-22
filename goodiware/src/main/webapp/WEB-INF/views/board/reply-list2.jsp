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
														  <div class="input-group-append" data-empno="${ loginuser.empno }">
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
		                                   			<form id="rereply-form-${ reply.rno }" class="user">
														<div class="input-group mb-3">
														  <input type="hidden" value="${ reply.rno }" name="rno">
														  <input type="hidden" value="${ param.BNo }" name="bNo">
														  <input type="hidden" value="${ loginuser.empno }" name="empno">
														  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rcontent-${ reply.rno }" name="rcontent" style="height:50px">&nbsp;&nbsp;
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



<!--  ***************************************************************************************************** -->



						<ul class="list-group">
							<c:forEach items="${ replies }" var="reply">					
							<c:if test="${ reply.rno > 0 }">
							<li class='list-group-item' data-rno='${ reply.rno }'>
								<div style="margin-left:${ reply.depth * 20 }px">
									<div>
									<c:if test="${ not reply.brdel }">
										<strong style="text-align:left">${ reply.name }</strong>
										<small class='float-right'><fmt:formatDate value="${ reply.rdate }" pattern="yyyy.MM.dd. hh:mm"/></small>
									</c:if>
									</div>
									<div>
									<c:choose>
									<c:when test="${ not reply.brdel }">
									<p>
									${ reply.rcontent }
									</p>
									</c:when>
									<c:otherwise>
									[삭제된 글입니다.]									
									</c:otherwise>
									</c:choose>
									</div>
									<div>
										<c:if test="${ not reply.brdel }">
										<c:if test="${ reply.empno == loginuser.empno }">
										<button data-rno="${ reply.rno }" class="btn btn-primary btn-sm editReply">수정</button>
										<button data-rno="${ reply.rno }" class="btn btn-primary btn-sm deleteReply">삭제</button>
										
										</c:if>
										<button data-rno='${ reply.rno }' class="btn btn-primary btn-sm reReply">댓글</button>
										<button data-rno='${ reply.rno }' style="display:none" class="btn btn-primary btn-sm reReply-cancel">댓글취소</button>
										</c:if>
									</div>
									<!-- 댓글 수정 및 대댓글 입력 영역 -->
									<div>
										<!-- 대댓글 등록 -->
										<div id="rereply-regist-${ reply.rno }" style="display:none">
                                   			<form id="rereply-form-${ reply.rno }" class="user">
												<div class="input-group mb-3">
												  <input type="hidden" value="${ reply.rno }" name="rno">
												  <input type="hidden" value="${ param.BNo }" name="bNo">
												  <input type="hidden" value="${ loginuser.empno }" name="empno">
												  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rcontent-${ reply.rno }" name="rcontent" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append">
												    <button class="btn btn-outline-secondary rereply-button" type="button" data-rno="${ reply.rno }" style="height:50px;width:80px">등록</button>
												  </div>
												</div>
											</form>
										</div>
										<!-- 댓글 수정 -->
										<div id="reply-edit-${ reply.rno }" style="display:none">
	                                   		<form id="rereply-form" class="user">
												<div class="input-group mb-3">
												  <input type="hidden" value="${ reply.rno }" name="rno">
												  <input type="text" value="${ reply.rcontent }" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rcontent-${ reply.rno }" name="rcontent" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append" data-empno="${ loginuser.empno }">
												    <button class="btn btn-outline-secondary edit-button" type="button" data-rno="${ reply.rno }" style="height:50px;width:80px">수정</button>
												  </div>
												</div>
											</form>
										</div>
									
									</div>
								</div>
								
								
							</li>
							</c:if>
							</c:forEach>
														
						</ul>