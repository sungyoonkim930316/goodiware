<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!doctype html>
<html class="no-js" lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>메일읽기</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/images/favicon.png">
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
			<sec:authentication property="principal" var="auth"/>
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">이메일</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">휴지통</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="email-left-box"><!-- <a href="email-compose.html" class="btn btn-primary btn-block">Compose</a> -->
                                    <div class="mail-list mt-4" data-empno="${ auth.employee.empno }" data-mno="${ message.mno }">
                                    	<a href="/message/inbox?empno=${ auth.employee.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-inbox font-18 align-middle mr-2"></i> <b>받은메일함</b> <span class="badge badge-primary badge-sm float-right m-t-5">${ unreadCount }</span> </a>
                                        <a href="/message/compose?empno=${ auth.employee.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-paper-plane font-18 align-middle mr-2"></i>메일쓰기</a>  
                                        <a href="/message/sendMessage?empno=${ auth.employee.empno }" class="list-group-item border-0 p-r-0"><i class="mdi mdi-file-document-box font-18 align-middle mr-2"></i>보낸메일함</a>
                                        <a href="#" class="list-group-item border-0 p-r-0"><i class="fa fa-star-o font-18 align-middle mr-2"></i>중요메일함 </a>
                                        <a href="/message/trashcan?empno=${ auth.employee.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-trash font-18 align-middle mr-2"></i>휴지통  <span class="badge badge-danger badge-sm float-right m-t-5">${ trashMessage }</span></a>
                                    </div>
                                </div>
                                <div class="email-right-box">
                                    <div class="read-content">
                                        <div class="media pt-5">
                                        	<c:choose>
				                                <c:when test="${ not empty message.picture }">
				                                	<img class="mr-3 rounded-circle" src="/resources/file/employee/photo/${ message.picture }" height="40" width="40" alt="">
				                                </c:when>
				                                <c:otherwise>
				                                	<img src="/resources/file/employee/photo/unnamed.jpg" height="40" width="40" alt="">
				                                </c:otherwise>
			                                </c:choose>
                                            <div class="media-body">
                                                <h5 class="m-b-3">${ message.name } [${ message.id }]</h5>
                                            </div>
                                        </div>
                                        <hr>
                                        <div class="media mb-4 mt-1">
                                            <div class="media-body"><span class="float-right"><fmt:formatDate value="${ message.senddate }" pattern="yyyy-MM-dd (E) hh:mm" /></span>
                                                <h4 class="m-0 text-primary">${ message.title }</h4>
                                            </div>
                                        </div>
                                        <div class="form-group p-t-15">
                                            <p style="width:600px; height:300px">${ message.content }<p>
                                        </div>
                                        <hr>
                                        <h6 class="p-t-15"><i class="fa fa-download mb-2"></i> 첨부파일 </h6>
                                        <div class="row m-b-30">
                                            <div class="col-auto"><a href="/message/download?mno=${ message.mno }" class="text-muted">${ message.msgfilename }</a>
                                            </div>
                                        </div>
                                        <hr>
                                    </div>
                                    <div class="text-right">
                                    	<button class="btn btn-primaryw-md m-b-30" type="button" id="restore">복구하기</button>
                                        <button  class="btn btn-danger" type="button" id="delete">삭제하기</button>
                                    </div>
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

		$("#delete").on("click", function(event){

			if (!confirm("메일을 삭제하시겠습니까?")) return;

			var empno = ${ auth.employee.empno };
			var mno = ${ message.mno };

			location.href="/message/deleteMessage?empno=" + empno +"&mno=" + mno;

		})

		$("#restore").on("click", function(event){

			if(!confirm("메일을 복구하시겠습니까?")) return;

			var empno =${ auth.employee.empno };
			var mno = ${ message.mno };

			location.href="/message/restoreMessage?empno=" + empno + "&mno=" + mno;

		})
		
	})

    </script>

</body>

</html>