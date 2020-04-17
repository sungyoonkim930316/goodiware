<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>초과근무 결재 리스트</title>
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
            Nav header start
        ***********************************-->
        <div class="nav-header">
            <div class="brand-logo">
                <a href="index.html">
                    <b class="logo-abbr"><img src="images/logo.png" alt=""> </b>
                    <span class="logo-compact"><img src="./images/logo-compact.png" alt=""></span>
                    <span class="brand-title">
                        <img src="images/logo-text.png" alt="">
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
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">초과근무 결재 리스트</a></li>
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
	                                <h4 class="card-title">초과근무 결재</h4>
	                                
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
										<tr>
										  <td></td>
										  <td></td>
										  <td></td>
										  <td></td>
										  <td></td>
										</tr>
									  </tbody>
									  <tfoot>
											<tr>
												<%-- <td colspan="4" style="text-align: center">${ pager }</td> --%>
											</tr>
									  </tfoot>
									</table>
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