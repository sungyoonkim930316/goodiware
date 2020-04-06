<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>자유게시판</title>
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
                        <li class="breadcrumb-item"><a href="javascript:void(0)">게사판</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">자유게시판</a></li>
                    </ol>
                </div>
            </div>
            <!-- row -->

            <div class="container-fluid">

            </div>
            <!-- #/ container -->
        </div>
        <!--**********************************
            Content body end
        ***********************************-->
        
        
        <div class="container-fluid">
        	<div class="row justify-content-center">
            	<div class="col-lg-12">
                	<div class="card">
                    	<div class="card-body">
                        	<div class="form-validation">
                        		<table class="table table-hover">
                        		<thead>
								<tr>
									<th>번호</th>
									<th>문의유형</th>
									<th>제목</th>
									<th>작성자</th>
									<th>문의일시</th>
									<th>답변여부</th>
								</tr>
								</thead>
								</table>
                        	
	                       	</div>
                    	</div>
               		</div>
               	</div>
           	</div>
        </div>
                                
        
        
	<div class="container">
	<table class="table table-hover">
		<thead>
		<tr>
			<th>번호</th>
			<th>문의유형</th>
			<th>제목</th>
			<th>작성자</th>
			<th>문의일시</th>
			<th>답변여부</th>
		</tr>
		</thead>
		<tbody>
<%-- 		<c:forEach items="${ askList }" var="ask">
		<c:if test="${ loginuser.id == ask.id || loginuser.userType == true }"> --%>
		<%-- <tr>
			<td>${ ask.no }</td>
			<td>${ ask.qnaType }</td>
			<td><a href="askdetail.action?no=${ask.no}" style="color:black"> ${ ask.title }</a></td>
			<td>${ ask.id }</td>
			<td><fmt:formatDate value="${ ask.regDate }" pattern="yyyy-MM-dd"/></td>
			<td>${ ask.ans_check == true ? "답변완료" : "답변대기" }</td>
		</tr> --%>
		<tr>
			<td>글번호</td>
			<td>글종류</td>
			<td><a href="askdetail.action?no=${ask.no}" style="color:black">제목</a></td>
			<td>작성자</td>
			<td><fmt:formatDate value="작성시간" pattern="yyyy-MM-dd"/></td>
		</tr>
<%-- 		</c:if>
		</c:forEach> --%>
		</tbody>
	</table>
	<hr/>
	
	<c:choose>
	<c:when test="${ loginuser.userType == false }">
	<a href="/goodibooks/board/askwrite.action" class="btn btn-light pull-right">
		<span class="text">글쓰기</span>
	</a>
	</c:when>
	</c:choose>
	</div>
        
        
        
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
    

</body>

</html>