<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>사원검색</title>
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
            Nav header start
        ***********************************-->
		<div class="nav-header">
			<div class="brand-logo">
				<a href="index.html"> <b class="logo-abbr"><img
						src="images/logo.png" alt=""> </b> <span class="logo-compact"><img
						src="./images/logo-compact.png" alt=""></span> <span
					class="brand-title"> <img src="images/logo-text.png" alt="">
				</span>
				</a>
			</div>
		</div>
		<!--**********************************
            Nav header end
        ***********************************-->

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
						<li class="breadcrumb-item"><a href="javascript:void(0)">홈</a></li>
						<li class="breadcrumb-item active"><a
							href="javascript:void(0)">사원검색</a></li>
					</ol>
				</div>
			</div>
			<!-- row -->

			<div class="container-fluid">
				<div class="row">
					<div class="col-12">
						<div class="card">
							<div class="card-body">
								<h4 class="card-title">검색 결과</h4>
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
												<td>
													<a style="cursor: pointer;" class="openModal" data-target="#exampleModalCenter" data-empno="${ employee.empno }">
														${ employee.name }
													</a>
												</td>
												<td>${ employee.posname }</td>
												<td>${ employee.depname }</td>
												<td>${ employee.phone }</td>
											</tr>
										</c:forEach>
									</tbody>
									<tfoot>
										<tr>
											<td colspan="5" style="text-align: center">${ pager }</td>
										</tr>
									</tfoot>
								</table>
								<!-- Modal -->
                                <div class="modal fade" id="exampleModalCenter">
                                    <div class="modal-dialog modal-dialog-centered" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 id="modal-name" class="modal-title"></h5>
                                                <button type="button" class="close" data-dismiss="modal"><span>&times;</span>
                                                </button>
                                            </div>
                                            <div class="modal-body">
                                                <div class="card">
						                            <div class="card-body">
						                                <div class="media align-items-center mb-4">
						                                    <img id="searchPic" class="mr-3" width="80" height="80" alt="">
						                                    <div class="media-body">
						                                        <h3 id="selName" style="text-align: center;" class="mb-0"></h3>
						                                    </div>
						                                </div>
						                                <ul class="card-profile__info">
						                                    <li class="mb-1"><strong class="text-dark mr-4">사&nbsp;&nbsp;&nbsp;&nbsp;번</strong> <span id="selEmpno"></span></li>
						                                    <li class="mb-1"><strong class="text-dark mr-4">계정명</strong> <span id="selId"></span></li>
						                                    <li class="mb-1"><strong class="text-dark mr-4">연락처</strong> <span id="selPhone"></span></li>
						                                    <li class="mb-1"><strong class="text-dark mr-4">부서명</strong> <span id="selDep"></span></li>
						                                    <li class="mb-1"><strong class="text-dark mr-4">직급명</strong> <span id="selPos"></span></li>
						                                </ul>
						                                <h4>소개</h4>
						                                <p id="selIntro" class="text-muted"></p>
						                            </div>
						                        </div>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
                                            </div>
                                        </div>
                                    </div>
                               	</div>
                               	<!-- Modal End -->
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

	<script type='text/javascript'>
	$(function(){

		$('.openModal').on('click', function(index) {

			var selNo = parseInt($(this).attr('data-empno'));
						
			$.ajax({
				type : "GET",
				url : "/employee/searchDetail",
				data : { "empno" : selNo },
				success : function(data, status, xhr) {
					
					$('#modal-name').text('사원검색 : ' + data.name + "님");

					if(!data.picture) {
						$('#searchPic').attr("src", "/resources/file/employee/photo/unnamed.jpg");
					} else {
						$('#searchPic').attr("src", "/resources/file/employee/photo/" + data.picture);
					}
					
					$('#selName').text(data.name);
					$('#selEmpno').text(data.empno);
					$('#selId').text(data.id);
					$('#selPhone').text(data.phone);
					$('#selDep').text(data.depname);
					$('#selPos').text(data.posname);

					if(!data.intro){
						$('#selIntro').text('등록된 자기소개가 없습니다.');
					} else {
						$('#selIntro').text(data.intro);
					}
										
					$('div.modal').modal();
					
					$('div.modal').load(); },
				error : function(xhr, status, err) {
					alert('조회 실패'); }
			});
			
		});	
			
	});
	</script>

</body>

</html>