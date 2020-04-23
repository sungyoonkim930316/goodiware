<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>나의일정</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="/resources/css/style.css" rel="stylesheet">
    <link href="/resources/css/fullcalendar.min.css" rel="stylesheet" />
    <link href="/resources/plugins/fullcalendar/css/fcmain.css" rel="stylesheet" />
    <link href="/resources/plugins/fullcalendar/css/dgmain.css" rel="stylesheet" />
    <link href="/resources/plugins/fullcalendar/css/tgmain.css" rel="stylesheet" />
    <link href="/resources/css/jquery.datetimepicker.css" rel="stylesheet" />
    
    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>
    <link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.4/themes/smoothness/jquery-ui.min.css" />
    
    <script src="/resources/js/fullcalendar.min.js"></script>
    <script src="/resources/plugins/fullcalendar/js/fcmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/itmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/dgmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/tgmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/ko.js"></script>
    <script src="/resources/js/jquery.datetimepicker.full.min.js"></script>

</head>

<body>

    <!-- Preloader start -->
    <div id="preloader">
        <div class="loader">
            <svg class="circular" viewBox="25 25 50 50">
                <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="3" stroke-miterlimit="10" />
            </svg>
        </div>
    </div>
    <!-- Preloader end -->

    
    <!-- Main wrapper start -->
    <div id="main-wrapper">

        <!-- Header start -->
		<jsp:include page="/WEB-INF/views/modules/topbar.jsp"></jsp:include>
        <!-- Header end ti-comment-alt -->

        <!-- Sidebar start -->
        <jsp:include page="/WEB-INF/views/modules/sidebar.jsp"></jsp:include>
        <!-- Sidebar end -->

        <!-- Content body start -->
        <div class="content-body">
            <div class="row page-titles mx-0">
                <div class="col p-md-0">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="javascript:void(0)">일정관리</a></li>
                        <li class="breadcrumb-item active"><a href="javascript:void(0)">나의일정</a></li>
                    </ol>
                </div>
            </div>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card">
                            <div class="card-body">
                                <div class="card-title">
                                    <h4>달력</h4>
                                </div>
                                <div id='calendar'></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Content body end -->
        
        
        <!-- Footer start -->
        <div class="footer">
            <div class="copyright">
                <p>Copyright &copy; Designed & Developed by <a href="https://themeforest.net/user/quixlab">Quixlab</a> 2018</p>
            </div>
        </div>
        <!-- Footer end -->
    </div>
    <!-- Main wrapper end -->
    
    <!-- 일정추가Modal -->
    <div class="modal fade none-border" role="dialog" id="scd-modal">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h4 class="modal-title"><strong>일정추가</strong></h4>
	            </div>
	            <div class="modal-body">
	            	<form id="addscd-form" action="/schedule/mainschedule" method="post">
	                    <div class="row">
	                    	<div class="col-md-6 form-group">
	                            <label class="control-label">일정이름</label>
	                            <input class="form-control form-white" placeholder="일정명을 작성하세요" required="required" type="text" id="title" name="title" />
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                            <label class="control-label">일정유형</label>
	                            <select class="form-control form-white" data-placeholder="일정유형을 선택하세요" id="schdivs" name="schedivno">
	                            	<c:forEach items="${ schdivs }" var="schdiv">
	                                <option value="${ schdiv.schedivno }">${ schdiv.sctitle }</option>
	                                </c:forEach>
	                            </select>
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                        	<label class="control-label">일정시작</label>
	                        	<input class="form-control form-white" type="text" id="startdate" name="startdate" placeholder="yyyy-MM-dd" />
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                        	<label class="control-label">일정끝</label>
	                        	<input class="form-control form-white" type="text" id="enddate" name="enddate" placeholder="yyyy-MM-dd" />
	                        </div>
	                        
	                        <br>
	                        
	                        <div class="col-md-12 form-group">
	                            <label class="control-label">내용</label>
	                            <textarea class="form-control form-white" id="content" value="" name="content"></textarea>
	                        </div>
	                        
	                        <div class="col-md-12 form-group">
	                    		<input type="hidden" id="empno" name='empno' value='${ loginuser.empno }' />
	                    	</div>
	                        
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer modalBtnContainer-addScd">
	                <button id='modalRegisterBtn' type="button" class="btn btn-success save-event waves-effect waves-light">저장</button>
	                <button id="modalCloseBtn" type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">닫기</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- Modal end -->
	
	<!-- 일정편집Modal -->
    <div class="modal fade none-border" role="dialog" id="scdedit-modal">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h4 class="modal-title"><strong>일정편집</strong></h4>
	            </div>
	            <div class="modal-body">
	            	<form id="addscd-form" action="/schedule/mainschedule" method="post">
	                    <div class="row">
	                    
	                    	<div class="col-md-12 form-group">
	                    		<input type="hidden" value="${ scheduleDetail.scheno }" name="scheno" id="scheno" />
	                    	</div>
	                    
	                    	<div class="col-md-6 form-group">
	                            <label class="control-label">일정이름</label>
	                            <input class="form-control form-white" value="${ scheduleDetail.title }" required="required" type="text" id="title" name="title" />
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                            <label class="control-label">일정유형</label>
	                            <select class="form-control form-white" data-placeholder="일정유형을 선택하세요" id="schdivs" name="schedivno">
	                            	<c:forEach items="${ schdivs }" var="schdiv">
	                                <option value="${ schdiv.schedivno }">${ schdiv.sctitle }</option>
	                                </c:forEach>
	                            </select>
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                        	<label class="control-label">일정시작</label>
	                        	<input class="form-control form-white" type="text" id="startdate" name="startdate" value="${ scheduleDetail.startdate }" />
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                        	<label class="control-label">일정끝</label>
	                        	<input class="form-control form-white" type="text" id="enddate" name="enddate" value="${ scheduleDetail.enddate }" />
	                        </div>
	                        
	                        <br>
	                        
	                        <div class="col-md-12 form-group">
	                            <label class="control-label">내용</label>
	                            <textarea class="form-control form-white" id="content" name="content">${ scheduleDetail.content }</textarea>
	                        </div>
	                        
	                        <div class="col-md-12 form-group">
	                    		<input type="hidden" id="empno" name='empno' value='${ loginuser.empno }' />
	                    	</div>
	                        
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer modalBtnContainer-editScd">
	                <button id='modalUpdateBtn' type="button" class="btn btn-success save-event waves-effect waves-light">저장</button>
	                <button id="modalCloseBtn" type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">닫기</button>
	                <button id="modalDeleteBtn" type="button" class="btn btn-danger delete-event waves-effect waves-light">삭제</button>
	            </div> 
	        </div>
	    </div>
	</div>
	<!-- Modal end -->
	
    <!-- Scripts -->
    <jsp:include page="/WEB-INF/views/modules/common-js.jsp"></jsp:include>
    
     <script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var Calendar = FullCalendar.Calendar;
			var calendarEl = document.getElementById('calendar');
			var startdate = document.getElementById('startdate');
			var enddate = document.getElementById('enddate');

			var calendar = new Calendar(calendarEl, {
				plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
				header: {
					left: 'prev, next today',
					center: 'title',
					right: 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				editable: false,
				dateClick: function() {
					$('#scd-modal').modal('show');
				},
				eventClick: function(eventClickInfo) {
					alert(eventClickInfo.event.id + "\n" + eventClickInfo.event.title);

					$('#scdedit-modal').modal('show');

					/* var values = $('#addscd-form').serialize();
					
					$.ajax({
			            method: "get",
			            url: "/schedule/detail",
			            data: values,
			            success: function (response) {
			            	$('#scdedit-modal').modal('show');
			            },
			            error: function(xhr, status, err) {
							alert('error');
					    }
			        }); */
				},
				eventLimit: true,
				views: {
					timeGrid: {
						eventLimit: 6
					}
				},
				events: [
					<c:forEach items="${ schedules }" var="schedules">
						{
							id: '${ schedules.scheno }',
							resourceId: '${ schedules.schedivno }',
							title: '${ schedules.title }',
							start: '<fmt:formatDate value="${ schedules.startdate }" pattern="yyyy-MM-dd" />',
							end: '<fmt:formatDate value="${ schedules.enddate }" pattern="yyyy-MM-dd" />',
							textColor: 'black',
							backgroundColor: 'palegreen',
							borderColor: 'white'
						},
					</c:forEach>
				],
				locale: 'ko'
			});
			calendar.render();
		})
		
		$(function() {
			$('#modalCloseBtn').on('click', function(event) {
				$('#scd-modal').modal('hide');
			});
			
			$('#modalRegisterBtn').on('click', function(event) {
				if ($('#title').val().length == 0) {
					alert("일정이름을 입력하세요")
					return;
				}

				if ($('#startdate').val().length == 0) {
					alert("일정 시작일을 입력하세요")
					return;
				}

				if ($('#enddate').val().length == 0) {
					alert("일정 종료일을 입력하세요")
					return;
				}
				$('#addscd-form').submit();
			})
			
			$('#modalDeleteBtn').on('click', function(event) {
				var scheno = $(this).attr('scheno');
				var yes = confirm("일정을 삭제하시겠습니까?");
				if (!yes) return;

				$.ajax({
					url: "/delete",
					method: "delete",
					data: { "scheno" : scheno },
					success: function(data, status, xhr) {
						$('.content-body').load("/schedule/myschedule?empno=${empno}");
					},
					error: function(xhr, status, err) {
						alert('실패')
					}
				});
			});
			
			$('#startdate, #enddate').on('click', function(event) {
				$(this).datetimepicker("show");
			})
		})
		

    </script>

</body>

</html>