<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>공지사항</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="/resources/plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">

</head>

<body>
	<sec:authentication var="auth" property="principal" />
    <!--*******************
        Preloader start
    ********************-->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!--*******************
        Preloader end
    ********************-->

    
    <!--**********************************
        Main wrapper start
    ***********************************-->
    <div id="main-wrapper">

        

        <!--**********************************
            Header start
        ***********************************-->
		<jsp:include page="/WEB-INF/views/modules/topbar.jsp"></jsp:include>
        <!--**********************************
            Header end ti-comment-alt
        ***********************************-->

        <!--**********************************
            Sidebar start
        ***********************************-->
		<jsp:include page="/WEB-INF/views/modules/sidebar.jsp"></jsp:include>
        <!--**********************************
            Sidebar end
        ***********************************-->

        <!--**********************************
            Content body start
        ***********************************-->
        <div class="content-body">

            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">게시판</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">공지사항</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">
	                                <h4 class="card-title">공지사항</h4>
	                                
							    </div>
                                <div class="row" style="text-align: center">
									<div class="col-sm-12 col-md-12">
										<div class="dataTables_length" id="dataTable_length"
											style="margin-bottom: 15px">
											<form action="list" method="get">
												<select name="searchType" aria-controls="dataTable"
													class="form-control-sm">
													<option value="T"
														${ param.searchType == 'T' ? 'selected' : '' }>글 제목</option>
													<option value="C"
														${ param.searchType == 'C' ? 'selected' : '' }>제목+내용</option>
												</select> 
												<input style="width:470px" type="search" name="searchKey" class="form-control-sm"
													placeholder="" aria-controls="dataTable"
													value="${ param.searchKey }"> 
												<input type="submit" class="btn btn-success btn-sm" value="검색">
											</form>
										</div>
									</div>
								</div>
								<br>
                                <div class="table-responsive">
                                    <table class="table" style="text-align: center">
									  <thead>
									    <tr>
									      <th scope="col" width="180">글 번호</th>
									      <th scope="col" width="500">글 제목</th>
									      <th scope="col" width="180">작성자</th>
									      <th scope="col" width="180">등록일</th>
									    </tr>
									  </thead>
									  <tbody>
									    <c:forEach items="${ boards }" var="board">
									    	<c:if test="${ board.bdivno eq 2 }">
									    	<tr>
									    		<td>${ board.bno }</td>
									    		<td>
									    			<c:choose>
										    			<c:when test="${ board.bdel eq 'N' }">
											    			<a href="detail?BNo=${ board.bno }&pageNo=${ pager.pageNo }&searchType=${ empty param.searchType ? '' : param.searchType }&searchKey=${ empty param.searchKey ? '' : param.searchKey }">
																${ board.title } 
															</a>
														</c:when>
														<c:otherwise>
															[삭제] ${ board.title }								
														</c:otherwise>
													</c:choose>
									    		</td>
									    		<td>${ board.name }</td>
									    		<td><fmt:formatDate value="${ board.regdate }" pattern="yyyy-MM-dd"/></td>
									    	</tr>
									    	</c:if>
									    </c:forEach>
									  </tbody>
									  <tfoot>
											<tr>
												<%-- <td colspan="5" style="text-align: center">${ pager }</td> --%>
											</tr>
									  </tfoot>
									</table>
									<div class="bootstrap-pagination">
		                                    <nav>
		                                    <c:if test="${ not empty boards }">
		                                        <ul class="pagination justify-content-center">
		                                        
		                                            <li class="page-item ${ pager.pageBlock == 0 ? 'disabled' : '' }"><a class="page-link" href="/market/list?pageNo=${ pager.start -1 }&searchType=${ param.searchType }&searchKey=${param.searchKey}" tabindex="-1">Previous</a></li>
		                                            
		                                            <c:forEach var="idx" begin="${ pager.start }" end="${ pager.end -1 }">
		                                            <li class="page-item ${ pager.pageNo == idx ? 'active' : '' }">
		                                            	<c:choose>
		                                            	<c:when test="${ pager.pageCount >= idx }">
		                                            	<a class="page-link" href="/market/list?pageNo=${ idx }&searchType=${ param.searchType }&searchKey=${param.searchKey}">${ idx }</a>
		                                            	</c:when>
		                                            	</c:choose>
		                                            </li>
		                                            </c:forEach>
		                                            
		                                            <li class="page-item ${ pager.pageCount < pager.end ? 'disabled' : '' }"><a class="page-link" href="/market/list?pageNo=${ pager.end }&searchType=${ param.searchType }&searchKey=${param.searchKey}">Next</a></li>
		                                            
		                                        </ul>
		                                     </c:if>
		                                    </nav>
		                                </div>
		                                <c:choose>
		                                <c:when test="${ auth.employee.auth.authno eq 2 or auth.employee.auth.authno eq 3 }">
								      		<button type="button" class="btn btn-primary" style="float: right;" id="writeBoard">글 쓰기</button>
								      	</c:when>
								      	</c:choose>	
								      		<!-- <button type="button" class="btn btn-primary" style="float: right;" id="writeBoard">글 쓰기</button> -->

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
			<!-- #/ container -->
        </div>
        <!--**********************************
            Content body end
        ***********************************-->
        
        
        <!--**********************************
            Footer start
        ***********************************-->
        <div class="footer">
            <div class="copyright">
                <p>Copyright &copy; Designed & Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>
            </div>
        </div>
        <!--**********************************
            Footer end
        ***********************************-->
    </div>
    <!--**********************************
        Main wrapper end
    ***********************************-->

    <!--**********************************
        Scripts
    ***********************************-->
    <jsp:include page="/WEB-INF/views/modules/common-js.jsp"></jsp:include>
    
    <script type="text/javascript">
	$(function(){

		$("#writeBoard").on("click", function(event){

			location.href="/market/write";

		})

		
	})
    
    </script>

</body>

</html>