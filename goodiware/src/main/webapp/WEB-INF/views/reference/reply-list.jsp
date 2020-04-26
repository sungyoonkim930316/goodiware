<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

						<sec:authentication property="principal" var="auth"/>
						<ul class="list-group">
							<c:forEach items="${ replies }" var="reply">					
							<c:if test="${ reply.refrno > 0 }">
							<li class='list-group-item' data-rno='${ reply.refrno }'>
								<div style="margin-left:${ reply.depth * 20 }px">
									<div>
									<c:if test="${ not reply.refrdel }">
										<strong style="text-align:left">${ reply.name }</strong>
										<small class='float-right'><fmt:formatDate value="${ reply.replydate }" pattern="yyyy.MM.dd. hh:mm"/></small>
									</c:if>
									</div>
									<div>
									<c:choose>
									<c:when test="${ not reply.refrdel }">
										<div>
											<p id="reply-view-${ reply.refrno }">
											${ reply.replycontent }
											</p>
										</div>
										<div id="reply-edit-${ reply.refrno }" style="display:none">
	                                   		<form id="rereply-form" class="user">
												<div class="input-group mb-3">
												  <input type="hidden" value="${ reply.refrno }" name="refrno">
												  <input type="text" value="${ reply.replycontent }" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rcontent-${ reply.refrno }" name="replycontent" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append" data-empno="${ auth.employee.empno }">
												    <button class="btn btn-outline-secondary edit-button" type="button" data-rno="${ reply.refrno }" style="height:50px;width:80px">수정</button>
												  </div>
												</div>
											</form>
										</div>
									</c:when>
									<c:otherwise>
									[삭제된 글입니다.]				
									</c:otherwise>
									</c:choose>
									</div>
									<div>
										<c:if test="${ not reply.refrdel }">
										<c:if test="${ reply.empno == auth.employee.empno }">
										<button data-rno="${ reply.refrno }" id="reply-button-${ reply.refrno }" class="btn btn-primary btn-sm editReply">수정</button>
										<button data-rno="${ reply.refrno }" id="reply-cancel-${ reply.refrno }" style="display:none" class="btn btn-primary btn-sm cancelReply">수정취소</button>
										<button data-rno="${ reply.refrno }" class="btn btn-primary btn-sm deleteReply">삭제</button>
										</c:if>
										<button data-rno='${ reply.refrno }' id="rereply-button-${ reply.refrno }" class="btn btn-primary btn-sm reReply">댓글</button>
										<button data-rno='${ reply.refrno }' id="cancel-button-${ reply.refrno }" style="display:none" class="btn btn-primary btn-sm reReply-cancel">댓글취소</button>
										</c:if>
									</div>
									<!-- 댓글 수정 및 대댓글 입력 영역 -->
									<div>
										<!-- 대댓글 등록 -->
										<div id="rereply-regist-${ reply.refrno }" style="display:none">
											<br>
                                   			<form id="rereply-form-${ reply.refrno }" class="user">
												<div class="input-group mb-3">
												  <input type="hidden" value="${ reply.refrno }" name="refrno">
												  <input type="hidden" value="${ reply.refno }" name="refno">
												  <input type="hidden" value="${ auth.employee.empno }" name="empno">
												  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rcontent-${ reply.refrno }" name="replycontent" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append">
												    <button class="btn btn-outline-secondary rereply-button" type="button" data-rno="${ reply.refrno }" style="height:50px;width:80px">등록</button>
												  </div>
												</div>
											</form>
										</div>
										<!-- 댓글 수정 -->
										<div id="rereply-regist-${ reply.refrno }" style="display:none">
	                                   		<br>
	                                   		<form id="rereply-form" class="user">
												<div class="input-group mb-3">
												  <input type="hidden" value="${ reply.refrno }" name="rno">
												  <input type="text" value="${ reply.replycontent }" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="rcontent-${ reply.refrno }" name="replycontent" style="height:50px">&nbsp;&nbsp;
												  <div class="input-group-append" data-empno="${ auth.employee.empno }">
												    <button class="btn btn-outline-secondary edit-button" type="button" data-rno="${ reply.refrno }" style="height:50px;width:80px">수정</button>
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
						
						<br>
						<div style="margin:auto; text-align:center">
						<div style="display:inline-block">
                        <c:if test="${ not empty replies }">
		            	<ul class="pagination">
							
							<li class="page-item ${ pager.pageBlock == 0 ? 'disabled' : '' }">
								<a id="page-no-${ pager.start - 1}" data-pageno="${ pager.start - 1 }" data-bno="${ replies[0].refno }" class="page-link" href="#">Previous</a>
							</li>
							
							<c:forEach var="idx" begin="${ pager.start }" end="${ pager.end - 1 }"> 
							<li class="page-item ${ pager.pageNo == idx ? 'active' : '' }">
								<c:choose>
								<c:when test="${ pager.pageCount >= idx }">
									<a id="page-no-${ idx }" data-pageno="${ idx }" data-bno="${ replies[0].refno }" class="page-link" href="javascript:">${ idx }</a>
								</c:when>
								<c:otherwise>
									<!-- <a class="page-link" href="javascript:">&nbsp;</a> -->
								</c:otherwise>
								</c:choose>
							</li>
							</c:forEach>
							
							<li class="page-item ${ pager.pageCount < pager.end ? 'disabled' : '' }">
								<a id="page-no-${ pager.end }" data-pageno="${ pager.end }" data-bno="${ replies[0].refno }" class="page-link" href="#" id="next">Next</a>
							</li>
						</ul>
						</c:if>
						</div>
						</div>
						
						
						
						