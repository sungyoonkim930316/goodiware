<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>결재 확인</title>
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
							href="javascript:void(0)">결재확인</a></li>
					</ol>
				</div>
			</div>
			<!-- row -->

			

			<div class="container-fluid">
				<h4 class="card-title">결재 확인</h4>
				
				<div class="form-group">
																
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
											      	
											      	<input class="form-control form-control-sm" type="text" value="${ approval.divname }" readOnly>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">진행상황</th>
											      <td class="right-menu">
											      	<input class="form-control form-control-sm" type="text" name="accepname" value="${ approval.accepname }" readOnly>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">제목</th>
											      <td class="right-menu">
											      	<input class="form-control form-control-sm" type="text" name="title" value="${ approval.title }" readOnly>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">중간승인자</th>
											      <td class="right-menu">
											      	<!-- <a href="#"><input class="form-control form-control-sm" type="text" name="maccp"></a> -->
											      	<div class="input-group mb-3">
													  <input class="form-control form-control-sm" type="text" id="maccp" name="maccp" value="${ approval.maccpname }">
													</div>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">최종승인자</th>
											      <td class="right-menu">
											      	<!-- <input class="form-control form-control-sm" type="text" name="faccp"> -->
											      	<div class="input-group mb-3">
													  <input class="form-control form-control-sm" type="text"  id="faccp" name=faccp value="${ approval.faccpname }">
													</div>
											      </td>
											    </tr>
											    <tr>
											      <th class="left-menu">첨부파일</th>
											      <td class="right-menu">
												    <c:if test="${ empty approval.apprfilename }">
												    	업로드된 파일이 없습니다
												    </c:if>
												    <c:if test="${ not empty approval.apprfilename }">
												    다운 받기
												    <a href="download?typeNo=${ approval.type }">
			        									[${ approval.apprfilename }]
			        								</a>&nbsp;&nbsp;&nbsp;
			        								
				        								<button class="btn btn-primary" id="openPdf">파일 미리보기(pdf 이외의 파일은 미리보기가 지원되지 않습니다)</button>&nbsp;&nbsp;
				        								<button class="btn btn-primary" id="closePdf">미리보기 닫기</button>
				        								<br><br>
				        								<iframe id="pdfView" src="/resources/file/approval/${ approval.apprfilename }" width='100%' height='500' allowfullscreen webkitallowfullscreen></iframe>
			        								</c:if>
											      </td> 
											    </tr>
											    <tr>
											      <th style="text-align: center" class="left-menu">내 용</th>
											      <td class="right-menu">
											    		${ approval.content }
											      </td>
											    </tr>
											    
											  </tbody>
											</table>

											<button style="float: right;" type="button" class="btn btn-primary" id="toList">목록</button>
											
											<div style="text-align: center; width: 30%; margin: 0 auto">
												<c:choose>
													<c:when test="${ approval.appaccpno eq 1 and loginuser.name eq approval.maccpname }">
														<select class="form-control form-control-user" name="acceptVal" id="acceptVal">
															<option value="defVal">승인여부를 선택해주세요</option>
															<option value="2">중간 승인</option>
															<option value="4">반려</option>
														</select>
														<br>
			                            				<button type="button" class="btn btn-primary" id="acceptAproval">선택완료</button>		
													</c:when>
													<c:when test="${ approval.appaccpno eq 2 and loginuser.name eq approval.faccpname }">
														<select class="form-control form-control-user" name="acceptVal" id="acceptVal">
															<option value="defVal">승인여부를 선택해주세요</option>
															<option value="3">최종 승인</option>
															<option value="4">반려</option>
														</select>
														<br>
			                            				<button type="button" class="btn btn-primary" id="acceptAproval">선택완료</button>	
													</c:when>
													<c:otherwise></c:otherwise>
												</c:choose>
												<br><br>
			                            	</div>
			                            	<div style="text-align: center; width: 50%; margin: 0 auto; float: none;" id="negative">
				                            	<textarea placeholder="반려사유를 입력하세요" style="resize: none;" name="natReason" id="natReason" class="form-control form-control-user" rows="4"></textarea><br>
				                            	<button type="button" class="btn btn-primary" id="to-negative">반려처리</button>&nbsp;
				                            	<button type="button" class="btn btn-primary" id="negativeCancel">반려취소</button>
				                            	
				                            	<!-- <input type="hidden" name="negContent" id="negContent"> -->
				                            	<input type="hidden" name="companoin" id="companoin">
				                            	
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

		$("#maccp, #faccp").attr({"readOnly" : "readOnly"})

		$(".left-menu").css({ "width" : "200" , "text-align" : "center", "vertical-align" : "middle" });

		$(".right-menu").css({ "width" : "600" });

		$('#pdfView').hide();
		$('#negative').hide();
		
		$("#openPdf").on('click', function() {

			$('#pdfView').show('3000');	
			
		});

		$("#closePdf").on('click', function() {

			$('#pdfView').hide('3000');	
			
		});

		$('#toList').on('click', function() {

			alert('목록으로 돌아갑니다');
			location.href = "apprlist?appdivno=${ param.appdivno }&pageNo=${ param.pageNo }";
			
		});

		$('#acceptAproval').on('click', function() {

			var result = $('#acceptVal').val();
			var appaccpno = $('#acceptVal').val();

			if(result == "defVal"){
				alert('승인 여부를 선택해주세요');
				$('#acceptVal').focus();
			} else if(result == "4") {
				$('#negative').show('3000');
			} else if(result == "2") {
				if(!confirm("승인하시겠습니까?"))return;
				location.href = "approvalAccp?appdivno=${ param.appdivno }&typeNo=${ approval.type }&pageNo=${ param.pageNo }&appaccpno=" + result;
			} else if(result == "3") {
				if(!confirm("승인하시겠습니까?"))return;
				location.href = "approvalAccp?appdivno=${ param.appdivno }&typeNo=${ approval.type }&pageNo=${ param.pageNo }&appaccpno=" + result;
			}

		});

		$('#negativeCancel').on('click', function() {

			var cancel = confirm("취소하고 다시 선택하시겠습니까?");

			if (cancel) {

				alert('다시 선택합니다.');
				$('#natReason').val('');
				$('#negative').hide('3000');
				$("#acceptVal").val('defVal');
				return;
			}
			
		});

		$('#to-negative').on('click', function() {

			var result = confirm("반려처리 하시겠습니까?");

			if (result) {

				var reason = $('#natReason').val();
				var appaccpno = $('#acceptVal').val();
				var companion = $('#negContent').val(reason); // 반려사유 hidden input에 저장 

				var form = makeform('companion', ${ param.appdivno }, ${ param.typeNo }, ${ param.pageNo }, appaccpno, companion );
				
				
				alert('반려처리 ㄱㄱ')
				
			}

		});

		var mApproval = '${ mApproval }';
		if( mApproval && !history.state ) {
			alert("승인이 완료되었습니다");
		}


		/* function makeForm(action, appdivno, typeNo, pageNo, appaccpno, companoin, method="get"){

			var form= $('<form></form>');
			form.attr({
				'action' : action,
				'method' : method
			});
			form.append($('<input>').attr({
				"type" : 'hidden',
				"name" : 'appdivno',
				"value" : appdivno
			});
			form.append($('<input>').attr({
				"type" : "hidden",
				"name" : "typeNo",
				"value" : typeNo
			});
			form.append($('<input>').attr({
				"type" : "hidden",
				"name" : "pageNo",
				"value" : pageNo
			});
			form.append($('<input>').attr({
				"type" : "hidden",
				"name", "appaccpno",
				"value", appaccpno
			});
			form.append($('<input>').attr({
				"type" : "hidden",
				"name", "companoin",
				"value", companoin
			});
			form.appendTo("body");
			return form;

		};  */
		
		
	});
	</script>


</body>



</html>