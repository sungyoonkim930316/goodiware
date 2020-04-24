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
			                            	
			                            	<input type="hidden" name="empno" value="${ auth.employee.empno }">
			                            	<table class="table table-bordered">
											  <tbody>
											    <tr>
											      <th class="left-menu">결재구분</th>
											      <td class="right-menu">
											      	<input class="form-control form-control-sm" type="hidden" name=appdivno value="${ param.appdivno }">
											      	<input class="form-control form-control-sm" type="text" value="${ appdivname.divname }" readOnly>
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
													  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="maccpname" readonly> 
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
													  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="faccpname" readonly>
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
											      <th style="text-align: center" class="left-menu">내 용</th>
											      <td class="right-menu">
											    		<textarea name="smarteditor" id="smarteditor" rows="10" cols="100" style="width:100%; height:412px;"></textarea>
											      </td>
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

<c:set var="new_line" value="
" />
	
	<script type="text/javascript" src="/resources/navereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type='text/javascript'>
	$(function(){

		$("#maccp, #faccp").attr({"readOnly" : "readOnly"})

		$(".left-menu").css({ "width" : "200" , "text-align" : "center", "vertical-align" : "middle" });

		$(".right-menu").css({ "width" : "600" });

		$("#search-maccp").on("click", function(event){

			window.open("/appr/maccpSearch","중간승인자검색","width=600, height=700, resizeable=no");

		});

		$("#search-faccp").on("click", function(event){

			window.open("/appr/faccpSearch","중간승인자검색","width=600, height=700, resizeable=no");

		});

		//전역변수선언
	    var editor_object = [];

	    var html = '${ fn:replace(appdivname.divfiletype, new_line, ' ') }';

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
	    $("#registerAproval").click(function(){
	        //id가 smarteditor인 textarea에 에디터에서 대입
	        editor_object.getById["smarteditor"].exec("UPDATE_CONTENTS_FIELD", []);
	         
	        // 이부분에 에디터 validation 검증
	
	        //폼 submit
	        $("#registAppr").submit();
	    })
		
	    
	})
	</script>


</body>



</html>