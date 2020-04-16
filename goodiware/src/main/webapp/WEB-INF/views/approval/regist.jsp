<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>결재 등록</title>
<!-- Favicon icon -->
<link rel="icon" type="image/png" sizes="16x16" href="/resources/images/favicon.png">
<!-- Custom Stylesheet -->
<link
	href="/resources/plugins/tables/css/datatable/dataTables.bootstrap4.min.css"
	rel="stylesheet">
<link href="/resources/css/style.css" rel="stylesheet">
<link href="/resources/plugins/summernote/dist/summernote.css" rel="stylesheet">

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
						<li class="breadcrumb-item"><a href="javascript:void(0)">결재</a></li>
						<li class="breadcrumb-item active"><a
							href="javascript:void(0)">결재등록</a></li>
					</ol>
				</div>
			</div>
			<!-- row -->

			

			<div class="container-fluid">
				<h4 class="card-title">결재 등록</h4>
				
				<div class="form-group">
					
					<form id="registAppr" action="/appr/registAppr" method="post" class="user" enctype="multipart/form-data">
						
						<div class="container-fluid">
			                <div class="row">
			                    <div class="col-12">
			                        <div class="card">
			                            <div class="card-body">
			                            	
			                            	<input type="hidden" name="empno" value="${ loginuser.empno }">
			                            	<table class="table table-bordered">
											  <tbody>
											    <tr>
											      <th class="left-menu">결재구분</th>
											      <td class="right-menu">
											      	<select class="form-control form-control-sm" id="apprdivno" name="appdivno">
											      		<c:forEach items="${ apprdivs }" var="apprdiv">
														  <option value="${ apprdiv.appdivno }">${ apprdiv.divname }</option>
											      		</c:forEach>
													</select>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">제목</th>
											      <td class="right-menu">
											      	<input class="form-control form-control-sm" type="text" name="title">
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">중간승인자</th>
											      <td class="right-menu">
											      	<!-- <a href="#"><input class="form-control form-control-sm" type="text" name="maccp"></a> -->
											      	<div class="input-group mb-3">
													  <input type="hidden"id="maccp" name="maccp">
													  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="maccpname"> 
													  <div class="input-group-append">
													    <button class="btn btn-outline-secondary" type="button" id="search-maccp">검색</button>
													  </div>
													</div>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">최종승인자</th>
											      <td class="right-menu">
											      	<!-- <input class="form-control form-control-sm" type="text" name="faccp"> -->
											      	<div class="input-group mb-3">
													  <input type="hidden"  id="faccp" name=faccp>
													  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="faccpname">
													  <div class="input-group-append">
													    <button class="btn btn-outline-secondary" type="button" id="search-faccp">검색</button>
													  </div>
													</div>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">첨부파일</th>
											      <td class="right-menu">
												    <input type="file" class="form-control-file" id="exampleFormControlFile1" name="filename">
											      </td> 
											    </tr>
											    <tr>
											      <th class="left-menu">내용</th>
											      <td class="right-menu">내용 내용 에디터</td>
											    </tr>
											  </tbody>
											</table>
											<div style="float: right;">
			                            	<button type="button" class="btn btn-primary" id="registerAproval">등록</button>
			                            	</div>
			                            </div>
			                        </div>
			                    </div>
			                </div>
			            </div>
						
					</form>
					
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

		$("#maccp, #faccp").attr({"readonly" : "readonly"})

		$(".left-menu").css({ "width" : "200" , "text-align" : "center", "vertical-align" : "middle" });

		$(".right-menu").css({ "width" : "600" });

		$("#registerAproval").on("click", function(event){

			$("#registAppr").submit();

		});

		$("#search-maccp").on("click", function(event){

			window.open("/appr/maccpSearch","중간승인자검색","width=600, height=700, resizeable=no");

		});

		$("#search-faccp").on("click", function(event){

			window.open("/appr/faccpSearch","중간승인자검색","width=600, height=700, resizeable=no");

		});


		
	    
	})
	</script>


</body>



</html>