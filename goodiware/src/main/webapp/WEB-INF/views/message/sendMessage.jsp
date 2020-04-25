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
    <title>보낸메일함</title>
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
                        <li class="breadcrumb-item active"><a href="#">보낸메일함</a></li>
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
                                    <div class="mail-list mt-4">
                                    	<a href="/message/inbox?empno=${ auth.employee.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-inbox font-18 align-middle mr-2"></i> <b>받은메일함</b> <span class="badge badge-primary badge-sm float-right m-t-5">${ unreadCount }</span> </a>
                                        <a href="/message/compose?empno=${ auth.employee.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-paper-plane font-18 align-middle mr-2"></i>메일쓰기</a>  
                                        <a href="/message/sendMessage?empno=${ auth.employee.empno }" class="list-group-item border-0 text-primary p-r-0"><i class="mdi mdi-file-document-box font-18 align-middle mr-2"></i>보낸메일함</a>
                                        <!-- <a href="#" class="list-group-item border-0 p-r-0"><i class="fa fa-star-o font-18 align-middle mr-2"></i>중요메일함</a> -->
                                        <a href="/message/trashcan?empno=${ auth.employee.empno }" class="list-group-item border-0 p-r-0"><i class="fa fa-trash font-18 align-middle mr-2"></i>휴지통 <span class="badge badge-danger badge-sm float-right m-t-5">${ trashMessage }</span> </a>
                                    </div>
                                    <!-- <h5 class="mt-5 m-b-10">Categories</h5>
                                    <div class="list-group mail-list"><a href="#" class="list-group-item border-0"><span class="fa fa-briefcase f-s-14 mr-2"></span>Work</a>  <a href="#" class="list-group-item border-0"><span class="fa fa-sellsy f-s-14 mr-2"></span>Private</a>  <a href="#"
                                        class="list-group-item border-0"><span class="fa fa-ticket f-s-14 mr-2"></span>Support</a>  <a href="#" class="list-group-item border-0"><span class="fa fa-tags f-s-14 mr-2"></span>Social</a>
                                    </div> -->
                                    
                                </div>
                                <div class="email-right-box">
                                    <!-- <div role="toolbar" class="toolbar">
                                        <div class="btn-group">
                                            <button aria-expanded="false" data-toggle="dropdown" class="btn btn-dark dropdown-toggle" type="button">More <span class="caret m-l-5"></span>
                                            </button>
                                            <div class="dropdown-menu"><span class="dropdown-header">More Option :</span>  <a href="javascript: void(0);" class="dropdown-item">Mark as Unread</a>  <a href="javascript: void(0);" class="dropdown-item">Add to Tasks</a>  <a href="javascript: void(0);"
                                                class="dropdown-item">Add Star</a>  <a href="javascript: void(0);" class="dropdown-item">Mute</a>
                                            </div>
                                        </div>
                                    </div> -->
                                    <form action="/message/inbox" method="get">
										<select name="searchType" aria-controls="dataTable" class="form-control-sm">
											<option value="T" ${ param.searchType == 'T' ? 'selected' : '' }>메일제목</option>
											<option value="C" ${ param.searchType == 'C' ? 'selected' : '' }>메일내용</option>
										</select> 
										<input style="width:200px" type="search" name="searchKey" class="form-control-sm" placeholder="" aria-controls="dataTable" value="${ param.searchKey }"> 
										<!-- <input type="submit" class="btn btn-success btn-sm" value="검색"> -->
										  <button type="submit" class="btn btn-primary mb-2">검색</button>
									</form>
                                    <hr>
                                    <div class="email-list m-t-15">
                                    	<%-- <c:forEach items="${ messages }" var="message">
                                    	<input type="hidden" name="mno" value="${ message.mno }">
                                        <div class="message unread">
                                            <div class="col-mail col-mail-1">
                                                <div class="email-checkbox" style="width:50px">
                                                    <!-- <input type="checkbox" id="chk2">
                                                    <label class="toggle" for="chk2"></label> -->
                                                    <span>${ message.name }</span>
                                                </div>
                                            </div>
                                            <a href="/message/messageContent?empno=${ auth.employee.empno }&mno=${ message.mno }">
                                                <div class="col-mail col-mail-2">
                                                    <div class="subject">${ message.title }</div>
                                                    <div class="date">
                                                    <fmt:formatDate value="${ message.senddate }" pattern="yyyy-MM-dd"/></div>
                                                </div>
                                            </a>
                                        </div>
                                        </c:forEach> --%>
                                        
                                        
                                         <table class="table">
	                                        <thead>
	                                            <tr>
	                                                <th style="width:200px">receiver</th>
	                                                <th style="width:700px">Subject</th>
	                                                <th style="width:200px">Date</th>
	                                            </tr>
	                                        </thead>
	                                        <tbody>
	                                        <c:forEach items="${ messages }" var="message">
	                                            <tr>
	                                                <td>${ message.name }</span></td>
	                                                
	                                                <td><a href="/message/sendContent?empno=${ auth.employee.empno }&mno=${ message.mno }">${ message.title }</a></td>
	                                                
	                                                <td><fmt:formatDate value="${ message.senddate }" pattern="yyyy-MM-dd"/></div></td>
	                                            </tr>
		                                    </c:forEach>
	                                        </tbody>
	                                    </table>
                                        
                                        
                                       <!--  <div class="message">
                                            <a href="email-read.html">
                                                <div class="col-mail col-mail-1">
                                                    <div class="email-checkbox">
                                                        <input type="checkbox" id="chk3">
                                                        <label class="toggle" for="chk3"></label>
                                                    </div><span class="star-toggle ti-star"></span>
                                                </div>
                                                <div class="col-mail col-mail-2">
                                                    <div class="subject">Almost unorthographic life One day however a small line of blind text by the name of Lorem Ipsum decided to leave for the far World of Grammar.</div>
                                                    <div class="date">11:49 am</div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="message">
                                            <a href="email-read.html">
                                                <div class="col-mail col-mail-1">
                                                    <div class="email-checkbox">
                                                        <input type="checkbox" id="chk4">
                                                        <label class="toggle" for="chk4"></label>
                                                    </div><span class="star-toggle ti-star"></span>
                                                </div>
                                                <div class="col-mail col-mail-2">
                                                    <div class="subject">Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of</div>
                                                    <div class="date">11:49 am</div>
                                                </div>
                                            </a>
                                        </div>
                                        <div class="message unread">
                                            <a href="email-read.html">
                                                <div class="col-mail col-mail-1">
                                                    <div class="email-checkbox">
                                                        <input type="checkbox" id="chk9">
                                                        <label class="toggle" for="chk9"></label>
                                                    </div><span class="star-toggle ti-star"></span>
                                                </div>
                                                <div class="col-mail col-mail-2">
                                                    <div class="subject">Even the all-powerful Pointing has no control about the blind texts it is an almost unorthographic life One day however a small line of blind text by the name of</div>
                                                    <div class="date">11:49 am</div>
                                                </div>
                                            </a>
                                        </div> -->
                                    </div><br>
                                     
                                    <!-- panel -->
                                    <!-- <div class="row">
                                        <div class="col-7">
                                            <div class="text-left">1 - 20 of 568</div>
                                        </div>
                                        <div class="col-5">
                                            <div class="btn-group float-right">
                                                <button class="btn btn-gradient" type="button"><i class="fa fa-angle-left"></i>
                                                </button>
                                                <button class="btn btn-dark" type="button"><i class="fa fa-angle-right"></i>
                                                </button>
                                            </div>
                                        </div>
                                    </div> -->
                                </div>
                            </div>
                            <div class="table-responsive">
                                 <table class="table" style="text-align: center">
                                 	<tfoot>
										<tr>
											<%-- <td colspan="4" style="text-align: center">${ pager }</td> --%>
										</tr>
						 			</tfoot>
                                 </table>
                                 <div class="bootstrap-pagination">
                                    <nav>
                                    <c:if test="${ not empty messages }">
                                        <ul class="pagination justify-content-center">
                                        
                                            <li class="page-item ${ pager.pageBlock == 0 ? 'disabled' : '' }"><a class="page-link" href="/message/sendMessage?empno=${ auth.employee.empno }&pageNo=${ pager.start -1 }&searchType=${ param.searchType }&searchKey=${param.searchKey}" tabindex="-1">Previous</a></li>
                                            
                                            <c:forEach var="idx" begin="${ pager.start }" end="${ pager.end -1 }">
                                            <li class="page-item ${ pager.pageNo == idx ? 'active' : '' }">
                                            	<c:choose>
                                            	<c:when test="${ pager.pageCount >= idx }">
                                            	<a class="page-link" href="/message/sendMessage?empno=${ auth.employee.empno }&pageNo=${ idx }&searchType=${ param.searchType }&searchKey=${param.searchKey}">${ idx }</a>
                                            	</c:when>
                                            	</c:choose>
                                            </li>
                                            </c:forEach>
                                            
                                            <li class="page-item ${ pager.pageCount < pager.end ? 'disabled' : '' }"><a class="page-link" href="/message/sendMessage?empno=${ auth.employee.empno }&pageNo=${ pager.end }&searchType=${ param.searchType }&searchKey=${param.searchKey}">Next</a></li>
                                            
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

		var success = '${ success }';
		if( success && !history.state ) {
			alert("메일이 전송되었습니다.");
		}


	})

	</script>

</body>

</html>