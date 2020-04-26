<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

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
		<sec:authentication property="principal" var="auth"/>
			<div class="row page-titles mx-0">
				<div class="col p-md-0">
					<ol class="breadcrumb">
						<li class="breadcrumb-item"><a href="javascript:void(0)">자료실</a></li>
						<li class="breadcrumb-item active"><a
							href="javascript:void(0)">자료 정보</a></li>
					</ol>
				</div>
			</div>
			<!-- row -->

			

			<div class="container-fluid">
                <div class="row">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body">
                            
	                            <table class="table">
	                               <thead>
	                                   <tr>
	                                       <th scope="col">${ reference.refname } | 자료실</th>
	                                       <th scope="col">
	                                       <th scope="col" style="text-align:right"><fmt:formatDate value="${ reference.refdate }" pattern="yyyy-MM-dd"/></th>
	                                   </tr>
	                               </thead>
	                               <tbody>
	                                   <tr>
	                                       <td colspan="4">${ reference.name }</td>
	                                   </tr>
	                                   <tr>
	                                       <td colspan="4"><br><br>${ reference.refcontent }<br><br></td>
	                                   </tr>
	                                   <tr>
	                                   
										   <td colspan="4">
										   <strong>첨부 파일</strong> &nbsp; <a href="download?refNo=${ reference.refno }">
			        					${ reference.reffilename }
			        				    </a>
			        				    <tr>
	                                   <tr>
	                                   		<td colspan="4">댓글</td>
	                                   	</tr>
	                                   <tr>
	                                   		<td colspan="3">
	                                   		<form id="reply-form" class="user">
												<div class="input-group mb-3">
												  <input type="hidden" value="${ auth.employee.empno }" name="empno" id="empno">
												  <input type="hidden" value="${ reference.refno }" name="refno" id="refno">
												  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="replycontent"  name="replycontent" style="height:80px">&nbsp;&nbsp;
												  <div class="input-group-append">
												    <button class="btn btn-outline-secondary" type="button" id="replyRegist" style="height:80px;width:80px">등록</button>
												  </div>
												</div>
											</form>
	                                   		</td>
	                                   	</tr>
	                                </tbody>
	                             </table>
	                            <div id="reply-list-container">
	                            
	                            	<jsp:include page="reply-list.jsp" />
	                            
	                           	</div>
                            </div>
                        </div>
                    </div>
                </div>
				<br>
				<br>
				<div style="text-align: center">
					<c:if test="${ auth.employee.empno eq reference.empno }">
						<button id="edit-button" type="button" class="btn btn-success">수정</button>
			    		<button id="delete-button" type="button" class="btn btn-success">삭제</button>
            		</c:if>
	        		<button id="tolist-button" type="button" class="btn btn-success">목록</button>
				</div>
			</div>
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

	<script src="/resources/plugins/common/common.min.js" ></script>
    <script src="/resources/js/custom.min.js"></script>
    <script src="/resources/js/settings.js"></script>
    <script src="/resources/js/gleek.js"></script>
    <script src="/resources/js/styleSwitcher.js"></script>
	<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
	<script type="text/javascript" src="/resources/navereditor/js/HuskyEZCreator.js" charset="utf-8"></script>
	<script type='text/javascript'>
	$(function(){
		/* $('input').attr({'readonly': 'readonly'}) */
		
		$('#tolist-button').on('click', function(event) {
			location.href = "list?pageNo=${ param.pageNo }&searchType=${ param.searchType }&searchKey=${ param.searchKey }";
		});
		$('#delete-button').on('click', function(event) {
			
			var yes = confirm("${ reference.refno }번 글을 삭제할까요?");
			if (!yes) {
				return;
			}
								
			var form =
				makeForm('delete', ${ reference.refno }, ${ param.pageNo }, '${ param.searchType }', '${ param.searchKey }');
			form.submit();
			alert('정상적으로 삭제되었습니다.');
		});
		$('#edit-button').on('click', function(event) {
			var form =
				makeForm('update', ${ reference.refno }, ${ param.pageNo }, '${ param.searchType }', '${ param.searchKey }');
			form.submit();
		});
		function makeForm(action, refno, pageNo, searchType, searchKey, method="get") {
			var form = $('<form></form>');
			form.attr({
				'action': action,
				'method': method
			});
			form.append($('<input>').attr({
				"type": "hidden",
				"name": "refNo",
				"value" : refno })
			);
			form.append($('<input>').attr({
				"type": "hidden",
				"name": "pageNo",
				"value" : pageNo })
			);
			form.append($('<input>').attr({
				"type": "hidden",
				"name": "searchType",
				"value" : searchType })
			);
			form.append($('<input>').attr({
				"type": "hidden",
				"name": "searchKey",
				"value" : searchKey })
			);
			
			form.appendTo("body");
			
			return form;
		}


  	    //////////////////////////////////////
		//				댓글					//
		//////////////////////////////////////
		
		// 댓글 등록
		$('#replyRegist').on("click", function(event) {

			if ($('#replycontent').val().length == 0) {
				alert("댓글 내용을 입력하세요")
				return;
			}
			
			var values = $('#reply-form').serializeArray();

			//console.log(values);

			$.ajax({
				"url" : "/reference/replyWrite",
				"method" : "post",
				"data" : values,
				"success" : function(data, status, xhr) {
					// 비동기처리 완료 뒤, 리로딩할 영역
					$("#reply-list-container").load("/reference/list-by/${ reference.refno }/${ pager.pageNo}");
					$('#replycontent').val('');
				},
				"error" : function(xhr, status, err){
					alert("댓글 쓰기가 실패해버렸지 뭐얌?")
				}
			});

			 
		});
		
		// 댓글 삭제
		$("#reply-list-container").on("click", ".deleteReply", function(evemt){

			var rno = $(this).attr('data-rno');

			if(!confirm("댓글을 삭제할까요?")) return;

			$.ajax({
				"url": "/reference/delete/" + rno,
				"method": "delete",
				"data": { "rno" : rno },
				"success": function(data, status, xhr) {
					$("#reply-list-container").load("/reference/list-by/${ reference.refno }/${ pager.pageNo}");
				},
				"error": function(xhr, status, err) {
					alert("삭제에 실패해버렸지뭐얌?");
				}
			});
			
 
		});

		$("div[id^=reply-edit]").hide();
		$("div[id^=reply-cancel]").hide();

		// 댓글 수정 버튼 클릭
		var currentRno = null;
		$("#reply-list-container").on("click", ".editReply", function(event){

			event.preventDefault();

			var rno = $(this).attr('data-rno');
			if (currentRno != null) {
				if (rno == currentRno) {
					return;
				} else {
					$("#reply-view-" + currentRno).show();
					$("#reply-edit-" + currentRno).hide();
					$("#reply-cancel-" + currentRno).hide();
					$("#reply-button-" + currentRno).show();
					$("#rereply-regist-" + currentRno).hide();
					$("#rereply-button-" + currentRno).show();
					$("#cancel-button-" + currentRno).hide();
				}
			} 
			
			$("#reply-view-" + rno).hide();
			$("#reply-edit-" + rno).show();
			$("#reply-button-" + rno).hide();
			$("#reply-cancel-" + rno).show();
			//$("#rereply-regist-" + rno).hide();
			
			currentRno = rno;

		});

		// 댓글 취소 버튼 클릭
		$("#reply-list-container").on("click", ".cancelReply", function(event){

			event.preventDefault();

			var rno = $(this).attr('data-rno');

			$("#reply-edit-" + rno).hide();
			$("#reply-view-" + rno).show();
			$("#reply-button-" + rno).show();
			$("#reply-cancel-" + rno).hide();

			currentRno = null;
		});
		
		// 댓글 수정 처리
		$("#reply-list-container").on("click", ".edit-button", function(event){

			var rno = $(this).attr('data-rno');
			var rcontent = $("#rcontent-" + rno);

			//console.log(rno);
			//console.log($("#rcontent-"+rno));
			
			var data = {
			"rno" : rno,
			"replycontent" : rcontent.val()
			};

			//console.log(data);
			
			$.ajax({
				"url": "/reference/update/",
				"method": "put",
 				"data" : JSON.stringify(data),
				"contentType" : "application/json",
				"success": function(data, status, xhr) {
					$("#reply-list-container").load("/reference/list-by/${ reference.refno }/${ pager.pageNo}");
				},
				"error": function(xhr, status, err) {
					alert("댓글 수정을 실패했습니다");
				}
			});
			
		});

		// 대댓글 버튼 클릭
		$("#reply-list-container").on("click", ".reReply", function(event){

			event.preventDefault();

			var rno = $(this).attr('data-rno');

			//console.log(rno);
			
			/* $("#rereply-regist-" + currentRno2).show(); */
			//$("#rereply-regist-" + rno).show();
			
			if (currentRno != null) {
				if (rno == currentRno) {
					return;
				} else {
					$("#rereply-regist-" + currentRno).hide();
					$("#rereply-button-" + currentRno).show();
					$("#reply-view-" + currentRno).show();
					$("#reply-edit-" + currentRno).hide();
					$("#cancel-button-" + currentRno).hide();
					$("#reply-cancel-" + currentRno).hide();
					$("#reply-button-" + currentRno).show();
				}
			} 

			$("#rereply-regist-" + rno).show();
			$("#rereply-button-" + rno).hide();
			$("#cancel-button-" + rno).show();
			$("#reply-view-" + rno).show();
			$("#reply-edit-" + rno).hide();
			$("#reply-cancel-" + rno).hide();
			
			
			currentRno = rno;
		});


		// 대댓글 취소버튼
		$("#reply-list-container").on("click", ".reReply-cancel", function(event){

			event.preventDefault();

			var rno = $(this).attr('data-rno');
			
			$("#cancel-button-" + rno).hide();
			$("#rereply-regist-" + rno).hide();
			$("#rereply-button-" + rno).show();

			currentRno = null;
			
		});

		// 대댓글 등록
 		$("#reply-list-container").on("click", ".rereply-button", function(event){

 			event.preventDefault();
 			
			var rno = $(this).attr('data-rno');
			var values = $('#rereply-form-'+rno).serializeArray();
			//var rercontent = $("#rercontent-" + rno);
			
			if ($('#rcontent-'+rno).val().length == 0) {
				alert("댓글 내용을 입력하세요")
				return;
			}
			
			//console.log(values); return;

			$.ajax({
				"url" : "/reference/rewrite",
				"method" : "post",
				"data" : values,
				"success" : function(data, status, xhr) {
					// 비동기처리 완료 뒤, 리로딩할 영역
					$("#reply-list-container").load("/reference/list-by/${ reference.refno }/${ pager.pageNo}");
				},
				"error" : function(xhr, status, err){
					alert("댓글 쓰기가 실패해버렸지 뭐얌?")
				}
			});
 
			currentRno = null;
			 
		});

		$('#reply-list-container').on('click', '.pagination a[id^=page-no]', function(event) {

			event.preventDefault();

			var refno = $(this).attr('data-bno');
			var pageNo = $(this).attr('data-pageno');

			$("#reply-list-container").load("/reference/list-by/" + refno + "/" + pageNo);
			
		});
 
	    
	}); 
	</script>


</body>



</html>