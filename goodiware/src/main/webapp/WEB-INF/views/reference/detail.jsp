<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>자료 정보</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16"
	href="/resources/images/favicon.png">
<!-- Custom Stylesheet -->
<link
	href="/resources/plugins/tables/css/datatable/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<link href="/resources/plugins/summernote/dist/summernote.css"
	rel="stylesheet">

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
						src="/resources/images/logo.png" alt=""> </b> <span
					class="logo-compact"><img
						src="/resources/images/logo-compact.png" alt=""></span> <span
					class="brand-title"> <img
						src="/resources/images/logo-text.png" alt="">
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
						<li class="breadcrumb-item"><a href="javascript:void(0)">자료실</a></li>
						<li class="breadcrumb-item active"><a
							href="javascript:void(0)">자료정보</a></li>
					</ol>
				</div>
			</div>
			<!-- row -->

			

			<div class="container-fluid">
				<h4 class="card-title">업로드 자료 정보</h4>
				<br>
				<div class="form-group row">
					<div class="col-sm-6 mb-3 mb-sm-0">
						<label>자료 번호</label>
						<input type="text" name="refno"
							class="form-control form-control-user" id="refno"
							value=${ reference.refno }>
					</div>
					<div class="col-sm-6">
						<label>자료 이름</label>
						<input type="text" name="refname"
							class="form-control form-control-user" id="refname"
							value="${ reference.refname }">
					</div>
				</div>
				
				<div class="form-group row">
					<div class="col-sm-6 mb-3 mb-sm-0">
						<label>등록자</label>
						<input type="text" name="name"
							class="form-control form-control-user" id="name"
							value=${ reference.name }>
					</div>
					<div class="col-sm-6">
						<label>등록 일자</label>
						<input type="text" name="refdate"
							class="form-control form-control-user" id="refdate"
							value="${ reference.refdate }">
					</div>
				</div>
				
				<div class="form-group">					
					<label>본문 내용</label>
					<div>
						${ reference.refcontent }
					</div>
					<label>첨부 자료</label>
					<br>
					<a href="download?refNo=${ reference.refno }">
			        	${ reference.reffilename }
			        </a>
				</div>
				<br>
				<br>
				<div style="text-align: center">
					<c:if test="${ loginuser.auth.authno eq 2 or loginuser.auth.authno eq 3 }">
						<button id="edit-button" type="button" class="btn btn-success">수정</button>
			    		<button id="delete-button" type="button" class="btn btn-success">삭제</button>
            		</c:if>
	        		<button id="tolist-button" type="button" class="btn btn-success">목록</button>
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

	<jsp:include page="/WEB-INF/views/modules/common-js.jsp"></jsp:include>
	
	<script type="text/javascript" src="/resources/navereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type='text/javascript'>
	$(function(){

		$('input').attr({'readonly': 'readonly'})
		
		$('#tolist-button').on('click', function(event) {
			location.href = "list?pageNo=${ param.pageNo }&searchType=${ param.searchType }&searchKey=${ param.searchKey }";
		});
	    
	});
	</script>


</body>



</html>