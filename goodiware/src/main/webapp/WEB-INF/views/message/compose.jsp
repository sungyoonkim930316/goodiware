<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!doctype html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>메일쓰기</title>
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

            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">이메일</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">메일쓰기</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->
			<!-- 메일 박스  -->
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                
                                <!-- 메일 박스  -->
                                <div class="email-left-box"><!-- <a href="email-compose.html" class="btn btn-primary btn-block">보내기</a> -->
                                   <div class="mail-list mt-4">
                                   		<a href="/message/inbox?empno=${ loginuser.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-inbox font-18 align-middle mr-2"></i> <b>받은메일함</b> <span class="badge badge-primary badge-sm float-right m-t-5">${ unreadCount }</span> </a>
                                        <a href="/message/compose?empno=${ loginuser.empno }" class="list-group-item border-0 text-primary p-r-0"><i class="fa fa-paper-plane font-18 align-middle mr-2"></i>메일쓰기</a>  
                                        <a href="/message/sendMessage?empno=${ loginuser.empno }" class="list-group-item border-0 p-r-0"><i class="mdi mdi-file-document-box font-18 align-middle mr-2"></i>보낸메일함</a>
                                        <a href="#" class="list-group-item border-0 p-r-0"><i class="fa fa-star-o font-18 align-middle mr-2"></i>중요메일함 </a>
                                        <a href="/message/trashcan?empno=${ loginuser.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-trash font-18 align-middle mr-2"></i>휴지통  <span class="badge badge-danger badge-sm float-right m-t-5">${ trashMessage }</span></a>
                                    </div>
                                   <!--  <h5 class="mt-5 m-b-10">Categories</h5>
                                    <div class="list-group mail-list"><a href="#" class="list-group-item border-0"><span class="fa fa-briefcase f-s-14 mr-2"></span>Work</a>  <a href="#" class="list-group-item border-0"><span class="fa fa-sellsy f-s-14 mr-2"></span>Private</a>  <a href="#"
                                        class="list-group-item border-0"><span class="fa fa-ticket f-s-14 mr-2"></span>Support</a>  <a href="#" class="list-group-item border-0"><span class="fa fa-tags f-s-14 mr-2"></span>Social</a>
                                    </div> -->
                                </div>
                                
                                <div class="email-right-box">
                                    <div class="toolbar" role="toolbar">
                                        <div class="btn-group m-b-20">
                                            <button type="button" class="btn btn-light"><i class="fa fa-archive"></i>
                                            </button>
                                            <button type="button" class="btn btn-light"><i class="fa fa-exclamation-circle"></i>
                                            </button>
                                            <button type="button" class="btn btn-light"><i class="fa fa-trash"></i>
                                            </button>
                                        </div>
                                        <div class="btn-group m-b-20">
                                            <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown"><i class="fa fa-folder"></i>  <b class="caret m-l-5"></b>
                                            </button>
                                            <div class="dropdown-menu"><span class="dropdown-header">Move to</span>  <a class="dropdown-item" href="javascript: void(0);">Social</a>  <a class="dropdown-item" href="javascript: void(0);">Promotions</a>  <a class="dropdown-item" href="javascript: void(0);">Updates</a> 
                                                <a class="dropdown-item" href="javascript: void(0);">Forums</a>
                                            </div>
                                        </div>
                                        <div class="btn-group m-b-20">
                                            <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown"><i class="fa fa-tag"></i>  <b class="caret m-l-5"></b>
                                            </button>
                                            <div class="dropdown-menu"><span class="dropdown-header">Label as:</span>  <a class="dropdown-item" href="javascript: void(0);">Updates</a>  <a class="dropdown-item" href="javascript: void(0);">Social</a>  <a class="dropdown-item" href="javascript: void(0);">Promotions</a> 
                                                <a class="dropdown-item" href="javascript: void(0);">Forums</a>
                                            </div>
                                        </div>
                                        <div class="btn-group m-b-20">
                                            <button type="button" class="btn btn-light dropdown-toggle" data-toggle="dropdown">More <span class="caret m-l-5"></span>
                                            </button>
                                            <div class="dropdown-menu"><span class="dropdown-header">More Option :</span>  <a class="dropdown-item" href="javascript: void(0);">Mark as Unread</a>  <a class="dropdown-item" href="javascript: void(0);">Add to Tasks</a>  <a class="dropdown-item"
                                                href="javascript: void(0);">Add Star</a>  <a class="dropdown-item" href="javascript: void(0);">Mute</a>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="compose-content mt-5">
                                        <form action="/message/sendMessage" method="post" id="send-form" enctype="multipart/form-data">
                                        	<input type="hidden" name="sender" value="${ loginuser.empno }">
                                            <div class="form-group">
                                                <input type="text" class="form-control bg-transparent" placeholder="받는사람" id="receiveid" name="receiveid">
                                            </div>
                                            <div class="form-group">
                                                <input type="text" class="form-control bg-transparent" placeholder="제목" id="title" name="title">                                            </div>
                                            <div class="form-group">
                                                <textarea class="textarea_editor form-control bg-light" rows="15" placeholder="내용" id="content" name="content"></textarea>
                                            </div>
                                            <br>
                                            <input type="file" name="filename"/><br><br><br>
                                        </form>
                                        <!-- <h5 class="m-b-20"><i class="fa fa-paperclip m-r-5 f-s-18"></i> Attatchment</h5> -->
                                        <!-- <form action="#" class="dropzone">
                                            <div class="form-group">
                                                <div class="fallback">
                                                    <input class="l-border-1" name="file" type="file" multiple="multiple">
                                                </div>
                                            </div>
                                        </form> -->
                                    </div>
                                    <div class="text-left m-t-15">
                                        <button class="btn btn-primary m-b-30 m-t-15 f-s-14 p-l-20 p-r-20 m-r-10" type="button" id="send"><i class="fa fa-paper-plane m-r-5"></i> 보내기</button>
                                        <button class="btn btn-dark m-b-30 m-t-15 f-s-14 p-l-20 p-r-20" type="button" id="delete"><i class="ti-close m-r-5 f-s-12"></i> 삭제하기</button>
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

			$("#send").on("click", function(event){

				if($("#receiver").val() == '' ){
					alert("받는사람을 입력하세요!");
					$("#receiver").focus();
					return;
				}
				if($("#title").val() == '' ){
					alert("제목을 입력하세요!");
					$("#title").focus();
					return;
				}
				if($("#content").val() == '' ){
					alert("내용을 입력하세요!");
					$("#content").focus();
					return;
				}
				if (!confirm("메일을 전송하시겠습니까?")) return;

				$("#send-form").submit();
				
			})


			$("#delete").on("click", function(event){
				if (!confirm("메일을 삭제하시겠습니까?")) return;
				history.back();
			})

		})
    </script>

</body>

</html>