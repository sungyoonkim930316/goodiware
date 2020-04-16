<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <link href="/resources/plugins/fullcalendar/css/fcmain.css" rel="stylesheet" />
    <link href="/resources/plugins/fullcalendar/css/dgmain.css" rel="stylesheet" />
    <link href="/resources/plugins/fullcalendar/css/tgmain.css" rel="stylesheet" />
    <script src="/resources/plugins/fullcalendar/js/fcmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/itmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/dgmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/tgmain.js"></script>
    <script src="/resources/plugins/fullcalendar/js/ko.js"></script>

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
        
	        <!-- <div id="contextMenu" class="dropdown clearfix">
	            <ul class="dropdown-menu dropNewEvent" role="menu" aria-labelledby="dropdownMenu"
	                style="display:block; position:static; margin-bottom:5px;">
	                <li><a tabindex="-1" href="#">미팅</a></li>
	                <li><a tabindex="-1" href="#">회의</a></li>
	                <li><a tabindex="-1" href="#">휴가</a></li>
	                <li><a tabindex="-1" href="#">회식</a></li>
	                <li><a tabindex="-1" href="#">기타</a></li>
	                <li class="divider"></li>
	                <li><a tabindex="-1" href="#" data-role="close">Close</a></li>
	            </ul>
	        </div> -->

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
                                <div id="external-events">
                                	<p>
                                		<strong>일정 카테고리</strong>
                                	</p>
                                	<div class="fc-event">미팅</div>
                                	<div class="fc-event">회의</div>
                                	<div class="fc-event">휴가</div>
                                	<div class="fc-event">회식</div>
                                	<div class="fc-event">기타</div>
                                	<p>
                                		<input type="checkbox" id="drop-remove">
                                		<label for="drop-remove">드랍 후 카테고리 제거</label>
                                	</p>
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
    
    <!-- Modal -->
    <div class="modal fade none-border" role="dialog" id="scd-modal">
	    <div class="modal-dialog" role="document">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h4 class="modal-title"><strong>일정추가</strong></h4>
	            </div>
	            <div class="modal-body">
	            	<form id="addscd-form" action="/schedule/mainschedule" method="post">
	                    <div class="row">
	                    
	                    	<%-- <div class="col-md-12 form-group">
	                    		<input type="hidden" name='scheno' value='${ board.scheno }' />
	                    	</div> --%>
	                    	
	                        <div class="col-md-6 form-group">
	                            <label class="control-label">일정이름</label>
	                            <input class="form-control form-white" placeholder="일정명을 작성하세요" required="required" type="text" id="title" name="title" />
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                            <label class="control-label">일정유형</label>
	                            <select class="form-control form-white" data-placeholder="일정유형을 선택하세요" id="schdivs" name="schdivs">
	                                <option value="미팅">미팅</option>
	                                <option value="회의">회의</option>
	                                <option value="휴가">휴가</option>
	                                <option value="회식">회식</option>
	                                <option value="기타">기타</option>
	                            </select>
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                        	<label class="control-label">일정시작</label>
	                        	<input class="form-control form-white" type="text" id="startdate" name="startdate" />
	                        </div>
	                        
	                        <div class="col-md-6 form-group">
	                        	<label class="control-label">일정끝</label>
	                        	<input class="form-control form-white" type="text" id="enddate" name="enddate" />
	                        </div>
	                        
	                        <br>
	                        
	                        <div class="col-md-12 form-group">
	                            <label class="control-label">내용</label>
	                            <textarea class="form-control form-white" id="content" value="" name="content"></textarea>
	                        </div>
	                        
	                    </div>
	                </form>
	            </div>
	            <div class="modal-footer modalBtnContainer-addScd">
	                <button id='modalRegisterBtn' type="button" class="btn btn-success save-event waves-effect waves-light">저장</button>
	                <button id="modalCloseBtn" type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">닫기</button>
	            </div>
	            <!-- <div class="modal-footer modalBtnContainer-editScd">
	                <button id='modalUpdateBtn' type="button" class="btn btn-success save-event waves-effect waves-light">저장</button>
	                <button id="modalCloseBtn" type="button" class="btn btn-danger delete-event waves-effect waves-light" data-dismiss="modal">닫기</button>
	                <button id="modalDeleteBtn" type="button" class="btn btn-danger delete-event waves-effect waves-light">삭제</button>
	            </div> -->
	        </div>
	    </div>
	</div>
	<!-- Modal end -->
	<div class="panel panel-default">
		<div class="panel-heading">
			<h4 class="panel-title">필터</h4>
		</div>
		
		<div class="panel-body">
			<div class="col-lg-6">
				<label for="calendar_view">구분별</label>
                <div class="input-group">
                    <select class="filter" id="type_filter" multiple="multiple">
                        <option value="미팅">미팅</option>
                        <option value="회의">회의</option>
                        <option value="휴가">휴가</option>
                        <option value="회식">회식</option>
                        <option value="기타">기타</option>
                    </select>
                </div>
			</div>
		</div>
	
	</div>
	
    <!-- Scripts -->
    <jsp:include page="/WEB-INF/views/modules/common-js.jsp"></jsp:include>
    
     <script type="text/javascript">
		document.addEventListener('DOMContentLoaded', function() {
			var Calendar = FullCalendar.Calendar;
			var Draggable = FullCalendarInteraction.Draggable;
			var containerEl = document.getElementById('external-events');
			var calendarEl = document.getElementById('calendar');
			var checkbox = document.getElementById('drop-remove');
			/* var startdate = document.getElementById('startdate');
			var enddate = document.getElementById('enddate');
			var schdivs = document.getElementById('schdivs');
			var addBtnContainer = document.getElementById('.modalBtnContainer-addScd'); */

			new Draggable(containerEl, {
				itemSelector: '.fc-event',
				eventData: function(eventEl) {
					return {
						title: eventEl.innerText
					};
				}
			});

			var calendar = new Calendar(calendarEl, {
				plugins: [ 'interaction', 'dayGrid', 'timeGrid' ],
				header: {
					left: 'prev, next today',
					center: 'title',
					right: 'dayGridMonth,timeGridWeek,timeGridDay'
				},
				editable: true,
				droppable: true,
				drop: function(info) {
					if (checkbox.checked) {
						info.draggedEl.parentNode.removeChild(info.draggedEl);
					}
				},
				dateClick: function() {
					$('#scd-modal').modal('show');
				},
				locale: 'ko'
			});

			/* var newScd = function (start, end, scddivs) {
				$('#contextMenu').hide();

				schdivs.val(scddivs).prop('selected', true);
				startdate.val(start);
				enddate.val(end);

				addBtnContainer.show();
				$('#scd-modal').modal('show');

				$('#modalRegisterBtn').on('click', function(event) {

					var scdData = {
						start: startdate.val(),
						end: enddate.val(),
						type: schdivs.val()
					};
					
					if ($('#title').val().length == 0) {
						alert("일정이름을 입력하세요")
						return;
					}

					if (scdData.start > scdData.end) {
						alert('끝나는 날짜가 시작 날짜보다 앞설 수 없습니다.');
						return false;
					}
					
					$('#addscd-form').submit();
				})

				if
			} */

			/* var calendar = new FullCalendar.Calendar(calendarEl, {
				plugins: ['dayGrid']
			}); */

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
				$('#addscd-form').submit();

				/* var values = $('#addscd-form').serializeArray2();

				$.ajax({
					"url": "/",
					"method": "post",
					"data": values,
					"success": function(data, status, xhr) {
						$('#scd-modal').modal('hide');
						$('#')
					}
				}) */
			})
		})
		
		/* $(function() {
			var testList = new Array();

			for(var i=1, i<=2; i++){
				var data = new Object();

				data.number = i;
				data.name = "Tester #" + i;

				testList.push(data);
			}

			var jsonData = JSON.stringify(testList);
			alert(jsonData);
		}) */
    </script>

</body>

</html>