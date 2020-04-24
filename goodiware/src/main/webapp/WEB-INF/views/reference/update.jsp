<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>자료 수정</title>
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
							href="javascript:void(0)">자료수정</a></li>
					</ol>
				</div>
			</div>
			<!-- row -->

			
			<sec:authentication property="principal" var="auth"/>
			<div class="container-fluid">
				<h4 class="card-title">업로드 자료 수정</h4>
				
				<div class="form-group">
					
					<form id="frm" action="/reference/update" method="post" class="user" enctype="multipart/form-data">
						
						<input type="hidden" name="refNo" value="${ reference.refno }">
				        <input type="hidden" name="pageNo" value="${ param.pageNo }">
				        <input type="hidden" id="searchType" name="searchType" value="${ param.searchType }">
		  				<input type="hidden" id="searchKey" name="searchKey" value="${ param.searchKey }">
						
						<input type="hidden" name="empno" value="${ auth.employee.empno }">
						
						<input type="text" name="refname" class="form-control input-default" value="${ reference.refname }"><br>
						<textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:100%; height:412px;"></textarea><br>
						<br>
						<label>업로드 파일</label>
						<br>
						기존 업로드 파일 : ${ reference.reffilename }
						<br>
						<input id="refFile" type="file" name="refFile"
							class="form-control">
						<input type="hidden" name="refName" value="${ reference.reffilename }">
						<br>
						<div style="text-align: center">
							<input type="button" class="btn btn-info btn-rounded" id="savebutton" value="수정" />
							<input type="button" class="btn btn-success btn-rounded" id="cancel" value="취소" />
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
	
<c:set var="new_line" value="
" />

	
	<script type="text/javascript" src="/resources/navereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type='text/javascript'>
	$(function(){
	    //전역변수선언
	    var editor_object = [];

	    var html = '${ fn:replace(reference.refcontent, new_line, ' ') }';

	    $('#smarteditor').val(html);
	 	     
	    nhn.husky.EZCreator.createInIFrame({
	        oAppRef: editor_object,
	        elPlaceHolder: "smarteditor", // textarea의 id
	        sSkinURI: "/resources/navereditor/SmartEditor2Skin.html", 
	        htParams : {
	            // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseToolbar : true,             
	            // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseVerticalResizer : true,     
	            // 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
	            bUseModeChanger : true, 
	        }
	    });
	
	    //전송버튼 클릭이벤트
	    $("#savebutton").click(function(){
	        //id가 smarteditor인 textarea에 에디터에서 대입
	        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
	         
	        // 이부분에 에디터 validation 검증
	
	        //폼 submit
	        $("#frm").submit();
	    })
	    cancel
	    $('#cancel').on('click', function() {

			var result = confirm("수정을 취소하시겠습니까?");

			if(!result) {
				return false;
			} else {
				alert('게시글로 돌아갑니다.');
				location.href = 'detail?refNo=${ reference.refno }&pageNo=${ param.pageNo }&searchType=${ param.searchType }&searchKey=${ param.searchKey }';
			} 
			

		});
	    
	})
	</script>


</body>



</html>