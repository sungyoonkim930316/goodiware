<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>사원정보수정</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/images/favicon.png">
<!-- Custom Stylesheet -->
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
				<div class="row justify-content-center">
					<div class="col-lg-12">
						<div class="card">
							<div class="card-body">
								<div class="form-validation">
									<form class="form-valide" action="/admin/edit" method="post"
										enctype="multipart/form-data">
										<input type=hidden name="empNo" id="empNo"
											value=${ param.empNo }>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label" for="val-username">프로필
												사진 <span class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<div
													style="width: 150px; height: 180px; overflow: hidden; margin: 0 auto;">

													<c:choose>
														<c:when test="${ empty employee.picture }">
															<img id="myfile1"
																style="width: 100%; height: 100%; object-fit: cover;"
																src="/resources/file/employee/photo/unnamed.jpg">
														</c:when>
														<c:otherwise>
															<img id="myfile1"
																style="width: 100%; height: 100%; object-fit: cover;"
																src="/resources/file/employee/photo/${ employee.picture }">
														</c:otherwise>
													</c:choose>
												</div>

												<%-- <h1 style="color: white">&nbsp;</h1>
												프로필 사진을 선택하세요 <br> <input type="file" name="profile"
													data-idx="1" /> <input type="hidden" name="profilePicture"
													value="${ employee.picture }"> --%>

											</div>
										</div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label" for="val-username">아이디
												<span class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="id" name="id"
													value="${ employee.id }">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label" for="val-username">이름
												<span class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="name"
													name="name" value="${ employee.name }">
											</div>
										</div>
										<div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-username">직급 <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <!-- <input type="text" class="form-control" id="position" name="position"> -->
                                                <select class="form-control" id="position" name="posno">
	                                                <c:forEach items="${ positions }" var="position">
	                                                <option value="${ position.posno }">${ position.posname }</option>
	                                                </c:forEach>
	                                            </select>
                                            </div>
                                        </div>
                                        <div class="form-group row">
                                            <label class="col-lg-4 col-form-label" for="val-username">부서 <span class="text-danger">*</span>
                                            </label>
                                            <div class="col-lg-6">
                                                <!-- <input type="text" class="form-control" id="department" name="department"> -->
                                                <select class="form-control" id="department" name="depno">
	                                                <c:forEach items="${ departments }" var="department">
	                                                <option value="${ department.depno }">${ department.depname }</option>
	                                                </c:forEach>
	                                            </select>
                                            </div>
                                        </div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label" for="val-email">핸드폰번호<span
												class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="phone"
													name="phone" placeholder="-빼고 입력"
													value="${ employee.phone}">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label" for="val-password">생년월일
												<span class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="birth"
													name="birth" placeholder="6자리 입력"
													value="${ employee.birth }">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label"
												for="val-confirm-password">주소 <span
												class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="add1"
													name="add1" value="${ employee.add1 }">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label"
												for="val-confirm-password"> <span
												class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<button type="button" class="btn mb-1 btn-rounded btn-info"
													id="btn">우편번호 찾기</button>
											</div>
										</div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label"
												for="val-confirm-password"> <span
												class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="add2"
													name="add2" value="${ employee.add2 }">
											</div>
										</div>
										<div class="form-group row">
											<label class="col-lg-4 col-form-label"
												for="val-confirm-password">상세주소<span
												class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<input type="text" class="form-control" id="add3"
													name="add3" value="${ employee.add3 }">
											</div>
										</div>

										<div class="form-group row">
											<label class="col-lg-4 col-form-label" for="val-suggestions">인사말
												<span class="text-danger"></span>
											</label>
											<div class="col-lg-6">
												<textarea class="form-control" id="intro" name="intro"
													rows="5">${ employee.intro }</textarea>
											</div>
										</div>
										<div class="form-group row">
											<div class="col-lg-8 ml-auto">
												<button type="submit" class="btn btn-primary" id="edit">변경</button>
											</div>
										</div>
									</form>
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

	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script type="text/javascript">
		$(function() {

			$("#id, #name, #add1, #add2, #add3, #phone,#birth, #intro").attr({
				"readonly" : "readonly"
			});

		})
	</script>


</body>

</html>