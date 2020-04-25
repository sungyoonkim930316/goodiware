<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>사원 리스트</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/images/favicon.png">
<!-- Custom Stylesheet -->
<link
	href="/resources/plugins/tables/css/datatable/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">

</head>

<body>

	<!--*******************
        Preloader start
    ********************-->
	<div id="preloader">
		<div class="loader">
			<svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none"
					stroke-width="3" stroke-miterlimit="10" />
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
						<li class="breadcrumb-item"><a href="javascript:void(0)">관리자페이지</a></li>
						<li class="breadcrumb-item active"><a
							href="javascript:void(0)">사원정보수정</a></li>
					</ol>
				</div>
			</div>
			<!-- row -->

			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">사원정보 수정</h4>
 								<form class="form-inline" action="/admin/empList"
									id="search-form">
									<div class="form-group mx-sm-3 mb-2">
										<input name="name" type="text" class="form-control" id="searchName" placeholder="사원 또는 부서 검색">
									</div>
									<button class="btn btn-primary mb-2" id="searchEmp">검색</button>
								</form>
								<table class="table">
									<thead>
										<tr>
											<th>사원번호</th>
											<th>이름</th>
											<th>직책</th>
											<th>부서</th>
											<th>연락처</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${ employees }" var="employee">
											<tr>
												<td>${ employee.empno }</td>
												<td><a
													href="/admin/edit?empNo=${ employee.empno }&pageNo=${ pager.pageNo }&searchType=${ empty param.searchType ? '' : param.searchType }&searchKey=${ empty param.searchKey ? '' : param.searchKey }">
														${ employee.name } </a></td>
												<td>${ employee.posname }</td>
												<td>${ employee.depname }</td>
												<td>${ employee.phone }</td>
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
                                    <c:if test="${ not empty employees }">
                                        <ul class="pagination justify-content-center">
                                        
                                            <li class="page-item ${ pager.pageBlock == 0 ? 'disabled' : '' }"><a class="page-link" href="/admin/empList?name=${ param.name }&pageNo=${ pager.start -1 }" tabindex="-1">Previous</a></li>
                                            
                                            <c:forEach var="idx" begin="${ pager.start }" end="${ pager.end -1 }">
                                            <li class="page-item ${ pager.pageNo == idx ? 'active' : '' }">
                                            	<c:choose>
                                            	<c:when test="${ pager.pageCount >= idx }">
                                            	<a class="page-link" href="/admin/empList?name=${ param.name }&pageNo=${ idx }">${ idx }</a>
                                            	</c:when>
                                            	</c:choose>
                                            </li>
                                            </c:forEach>
                                            
                                            <li class="page-item ${ pager.pageCount < pager.end ? 'disabled' : '' }"><a class="page-link" href="/admnin/empList?name=${ param.name }&pageNo=${ pager.start -1 }">Next</a></li>
                                            
                                        </ul>
                                     </c:if>
                                    </nav>
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
				<p>
					Copyright &copy; Designed & Developed by <a
						href="https://themeforest.net/user/quixlab">Quixlab</a> 2018
				</p>
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

</body>

</html>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script type="text/javascript">
	$(function(){

		$("#empSearchResult").on("click", function(event){

			event.preventDefault();

			$("#searchForm").submit();
			
		});
	});
   
</script>       