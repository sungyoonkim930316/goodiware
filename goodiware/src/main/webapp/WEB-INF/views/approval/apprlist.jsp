<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>결재 리스트</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="/resources/plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
    <link href="/resources/css/style.css" rel="stylesheet">

</head>

<body>

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
                        <li class="breadcrumb-item"><a href="javascript:void(0)">결재</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">결재 리스트</a></li>
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
	                                <c:choose>
		                                <c:when test="${ param.appdivno eq 1 }">
		                                	<h4 class="card-title">업무 결재</h4>
		                                </c:when>
	                                	<c:when test="${ param.appdivno eq 2 }">
		                                	<h4 class="card-title">파견 결재</h4>
		                                </c:when>
		                                <c:when test="${ param.appdivno eq 3 }">
		                                	<h4 class="card-title">경비지출 결재</h4>
		                                </c:when>
		                                <c:when test="${ param.appdivno eq 4 }">
		                                	<h4 class="card-title">초과근무 결재</h4>
		                                </c:when>
		                                <c:when test="${ param.appdivno eq 5 }">
		                                	<h4 class="card-title">휴가 결재</h4>
		                                </c:when>
	                                </c:choose>
							    </div>
								 <div class="row" style="text-align: center">
									<div class="col-sm-12 col-md-12">
										<div class="dataTables_length" id="dataTable_length"
											style="margin-bottom: 15px">
											<form action="apprlist" method="get">
												<input type="hidden" value="${ param.appdivno }" name="appdivno">
												<select name="searchType" aria-controls="dataTable"
													class="form-control-sm">
													<option value="W"
														${ param.searchType == 'W' ? 'selected' : '' }>작성자</option>
													<option value="T"
														${ param.searchType == 'T' ? 'selected' : '' }>제목</option>
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
									      <th scope="col">번호</th>
									      <th scope="col">제목</th>
									      <th scope="col">작성자</th>
									      <th scope="col">결재구분</th>
									      <th scope="col">진행상황</th>
									    </tr>
									  </thead>
									  <tbody>
										<c:forEach items="${ approvals }" var="approval">
											<tr>
											  <td>${ approval.type }</td>
											  <td>
											  	<c:choose>
										    		<c:when test="${ approval.deleted eq 'N' }">
											    		<a href="detail?appdivno=${ param.appdivno }&typeNo=${ approval.type }&pageNo=${ pager.pageNo }">
															${ approval.title } 
														</a>
													</c:when>
													<c:otherwise>
														[삭제] ${ approval.title }								
													</c:otherwise>
												</c:choose>
											  	
											  </td>
											  <td>${ approval.name }</td>
											  <td>${ approval.divname }</td>
											  <td>${ approval.accepname }</td>
											</tr>
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
		                                    <c:if test="${ not empty approvals }">
		                                        <ul class="pagination justify-content-center">
		                                        
		                                            <li class="page-item ${ pager.pageBlock == 0 ? 'disabled' : '' }"><a class="page-link" href="/appr/apprlist?appdivno=${ param.appdivno }&pageNo=${ pager.start -1 }&searchType=${ param.searchType }&searchKey=${param.searchKey}" tabindex="-1">Previous</a></li>
		                                            
		                                            <c:forEach var="idx" begin="${ pager.start }" end="${ pager.end -1 }">
		                                            <li class="page-item ${ pager.pageNo == idx ? 'active' : '' }">
		                                            	<c:choose>
		                                            	<c:when test="${ pager.pageCount >= idx }">
		                                            	<a class="page-link" href="/appr/apprlist?appdivno=${ param.appdivno }&pageNo=${ idx }&searchType=${ param.searchType }&searchKey=${param.searchKey}">${ idx }</a>
		                                            	</c:when>
		                                            	</c:choose>
		                                            </li>
		                                            </c:forEach>
		                                            
		                                            <li class="page-item ${ pager.pageCount < pager.end ? 'disabled' : '' }"><a class="page-link" href="/appr/apprlist?appdivno=${ param.appdivno }&pageNo=${ pager.end }&searchType=${ param.searchType }&searchKey=${param.searchKey}">Next</a></li>
		                                            
		                                        </ul>
		                                     </c:if>
		                                    </nav>
		                                </div>
								      		<button type="button" class="btn btn-primary" style="float: right;" id="taskRegist">결재등록</button>	
									<!-- <table class="table">
										<tbody>
										    <tr>
										      <td colspan="4">
												<div class="bootstrap-pagination">
				                                    <nav>
				                                        <ul class="pagination justify-content-center">
				                                            <li class="page-item disabled"><a class="page-link" href="#" tabindex="-1">◀</a>
				                                            </li>
				                                            <li class="page-item"><a class="page-link" href="#">1</a>
				                                            </li>
				                                            <li class="page-item"><a class="page-link" href="#">2</a>
				                                            </li>
				                                            <li class="page-item"><a class="page-link" href="#">3</a>
				                                            </li>
				                                            <li class="page-item"><a class="page-link" href="#">▶</a>
				                                            </li>
				                                        </ul>
				                                    </nav>
				                                </div>
										      </td>
										      </tr>
										</tbody>
									</table> -->
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

		$("#taskRegist").on("click", function(event){

			var appdivno = '${ param.appdivno}';
			
			location.href="/appr/regist?appdivno=" + appdivno;

		})

		
	})
    
    </script>

</body>

</html>