<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>구디웨어</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/images/favicon.png">
    <!-- Pignose Calender -->
    <link href="/resources/plugins/pg-calendar/css/pignose.calendar.min.css" rel="stylesheet">
    <!-- Chartist -->
    <link rel="stylesheet" href="/resources/plugins/chartist/css/chartist.min.css">
    <link rel="stylesheet" href="/resources/plugins/chartist-plugin-tooltips/css/chartist-plugin-tooltip.css">
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
            <div class="container-fluid mt-3">
            	<div class="row">
	            	<div class="col-12">
		            	<div class="card">
		            		<div class="card-body">
			                	<h4 style="text-align: center; margin-bottom: 0px" class="text-black">${ auth.employee.name } 님은 
			                    <span id="joinDate"><fmt:parseDate value='${auth.employee.joinday}' var='join_day' pattern='yyyy-MM-dd'/><fmt:formatDate value="${ join_day }" pattern="yyyy-MM-dd"/></span> 일에 입사하셔서 <span id="between"></span>일 째 노동중이십니다.</h4>
			                </div>
		            	</div>
	            	</div>
            	</div>
                <div class="row">
                	
                    <div class="col-lg-6">
                        <div class="card gradient-1">
                            <div class="card-body">
                            	<div class="row">
                            		<div class="col">
                                	<h3 class="card-title text-white">나의 메일&nbsp;&nbsp;<i class="icon-envelope-open"></i></h3>
                                	</div>
                                	<div class="col">
                                	<h5 id="to-mailList" style="float: right; color: white; font-size: 14px; cursor: pointer;">더 보기</h5>
                                	</div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover" style="text-align: center">
                                        <thead>
                                            <tr>
                                               	<th>제&nbsp;&nbsp;&nbsp;&nbsp;목</th>
                                                <th>발 신 자</th>
                                                <th>수 신 일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ messages }" var="message">
									    	<tr>
									    		<td>
									    		<input type="hidden" id="mno" value="${ message.mno }">
									    			<c:choose>
										    			<c:when test="${ message.deleted eq 'N' }">
											    			<a style="color: white" href="/message/messageContent?empno=${ auth.employee.empno }&mno=${ message.mno }">
																${ message.title } 
															</a>
														</c:when>
														<c:otherwise>
															[삭제] ${ message.title }								
														</c:otherwise>
													</c:choose>
									    		</td>
									    		<td>${ message.name }</td>
									    		<td><fmt:formatDate  value="${ message.senddate }" pattern="yyyy-MM-dd"/></td>
									    	</tr>
									    </c:forEach>
									    	<c:if test="${fn:length(messages) eq 0 }">
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">받은 메일이 없습니다</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>	  	
											</c:if>
									    	<c:if test="${fn:length(messages) eq 1 }">
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(messages) eq 2 }">
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(messages) eq 3 }">
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
											</c:if>
											<c:if test="${fn:length(messages) eq 4 }">
												<tr>
													<td style="border-color: transparent;" colspan="3">&nbsp;</td>
												</tr>
											</c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card gradient-2">
                            <div class="card-body">
                                <h3 class="card-title text-white">나의 결재&nbsp;&nbsp;<i class="icon-note menu-icon"></i></h3>
                                <div class="table-responsive">
                                    <table class="table table-hover" style="text-align: center">
                                        <thead>
                                            <tr>
                                                <th>구&nbsp;&nbsp;분</th>
                                                <th>제&nbsp;&nbsp;&nbsp;&nbsp;목</th>
                                                <th>최 초 등 록 자</th>
                                                <th>진 행 현 황</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ approvals }" var="approval">
                                            	<tr>                                         	
												  <td>${ approval.divname }</td>
												  <td>
												  <input type="hidden" id="type" value="${ approval.type }">
												  	<c:choose>
											    		<c:when test="${ approval.deleted eq 'N' }">
												    		<a style="color: white" href="/appr/apprdetail?appdivno=${ approval.appdivno }&typeNo=${ approval.type }">
																${ approval.title } 
															</a>
														</c:when>
														<c:otherwise>
															[삭제] ${ approval.title }								
														</c:otherwise>
													</c:choose>
												  	
												  </td>
												  <td>${ approval.name }</td>
												  <td>
												  	<c:choose>
												  	<c:when test="${ approval.appaccpno eq 1 }">
												  		<span class="label label-pill label-secondary">${ approval.accepname }</span>
												  	</c:when>
												  	<c:when test="${ approval.appaccpno eq 2 }">
												  		<span class="label label-pill label-info">${ approval.accepname }</span>
												  	</c:when>
												  	<c:when test="${ approval.appaccpno eq 3 }">
												  		<span class="label label-pill label-success">${ approval.accepname }</span>
												  	</c:when>
												  	<c:when test="${ approval.appaccpno eq 4 }">
												  		<span class="label label-pill label-dark">${ approval.accepname }처리</span>
												  	</c:when>
												  	<c:otherwise>알 수 없음</c:otherwise>
												  	</c:choose>
												  </td>
												</tr>
											</c:forEach>
											<c:if test="${fn:length(approvals) eq 0 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">결재가 없습니다</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(approvals) eq 1 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(approvals) eq 2 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(approvals) eq 3 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
											</c:if>
											<c:if test="${fn:length(approvals) eq 4 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
											</c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card gradient-3">
                            <div class="card-body">
                                <div class="row">
                            		<div class="col">
                                	<h3 class="card-title text-white">나의 일정&nbsp;&nbsp;<i class="icon-envelope-open"></i></h3>
                                	</div>
                                	<div class="col">
                                	<h5 id="to-scheList" style="float: right; color: white; font-size: 14px; cursor: pointer;">일정페이지 이동</h5>
                                	</div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover" style="text-align: center">
                                        <thead>
                                            <tr>
                                                <th>구&nbsp;&nbsp;분</th>
                                                <th>제&nbsp;&nbsp;&nbsp;&nbsp;목</th>
                                                <th>시작날짜</th>
                                                <th>종료날짜</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ schedules }" var="schedule">
                                            	<tr>                                         	
												  <td>${ schedule.sctitle }</td>
												  <td>${ schedule.title }</td>
												  <td><fmt:formatDate value="${ schedule.startdate }" pattern="yyyy-MM-dd"/></td>
												  <td><fmt:formatDate value="${ schedule.enddate }" pattern="yyyy-MM-dd"/></td>
												</tr>
											</c:forEach>
											<c:if test="${fn:length(schedules) eq 0 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">등록된 일정이 없습니다</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(schedules) eq 1 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(schedules) eq 2 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(schedules) eq 3 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
											</c:if>
											<c:if test="${fn:length(schedules) eq 4 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
											</c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="card gradient-4">
                            <div class="card-body">
                                <div class="row">
                            		<div class="col">
                                	<h3 class="card-title text-white">공지사항&nbsp;&nbsp;<i class="icon-envelope-open"></i></h3>
                                	</div>
                                	<div class="col">
                                	<h5 id="to-notiList" style="float: right; color: white; font-size: 14px; cursor: pointer;">공지사항 이동</h5>
                                	</div>
                                </div>
                                <div class="table-responsive">
                                    <table class="table table-hover" style="text-align: center">
                                        <thead>
                                            <tr>
                                                <th>제&nbsp;&nbsp;목</th>
                                                <th>작성자</th>
                                                <th>등록일</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${ boards }" var="board">
                                            	<tr>                                         	
												  <td>
												  	<input type="hidden" id="type" value="${ board.bno }">
												  	<c:choose>
											    		<c:when test="${ board.bdel eq 'N' }">
												    		<a id="to-noti-detail" style="color: white" href="/market/detail?BNo=${ board.bno }">
																${ board.title } 
															</a>
														</c:when>
														<c:otherwise>
															[삭제] ${ board.title }								
														</c:otherwise>
													</c:choose>
												  </td>
												  <td>${ board.name }</td>
												  <td><fmt:formatDate value="${ board.regdate }" pattern="yyyy-MM-dd"/></td>
												</tr>
											</c:forEach>
											<c:if test="${fn:length(boards) eq 0 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">등록된 공지사항이 없습니다</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(boards) eq 1 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(boards) eq 2 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>	  	
											</c:if>
											<c:if test="${fn:length(boards) eq 3 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
											</c:if>
											<c:if test="${fn:length(boards) eq 4 }">
												<tr>
													<td style="border-color: transparent;" colspan="4">&nbsp;</td>
												</tr>
											</c:if>
                                        </tbody>
                                    </table>
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
	<div class="modal fade" id="messageModal" tabindex="-1" role="dialog" aria-labelledby="modalTitle" aria-hidden="true">
	    <div class="modal-dialog" role="document">
	      <div class="modal-content">
	        <div class="modal-header">
	          <h5 class="modal-title" id="modalTitle">알림</h5>
	          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
	            <span aria-hidden="true">×</span>
	          </button>
	        </div>
	        <div class="modal-body"></div>
	        <div class="modal-footer">
	          <button class="btn btn-secondary" type="button" data-dismiss="modal">확인</button>
	        </div>
	      </div>
	    </div>
	  </div>
    <!--**********************************
        Scripts
    ***********************************-->
    <jsp:include page="/WEB-INF/views/modules/common-js.jsp"></jsp:include>
    
	<script type="text/javascript">

	$(function(){
	
		$('#to-mailList').on('click', function() {

			location.href = "/message/inbox?empno=" + ${ auth.employee.empno };

		});

		$('#to-scheList').on('click', function() {

			location.href = "/schedule/myschedule?empno=" + ${ auth.employee.empno };

		});

		$('#to-notiList').on('click', function() {

			location.href = "/market/list";

		});

		// 날짜보여주기 start
				
		var today = new Date();
		var joinDate = $('#joinDate').text();

		var dateArray = joinDate.split('-');

		var dateObj = new Date(dateArray[0], Number(dateArray[1])-1, dateArray[2]);

		var betweenDay = (today.getTime() - dateObj.getTime())/1000/60/60/24;

		var resultDay = parseInt(betweenDay);

		$('#between').text(resultDay);

		var memberCountConTxt = $('#between').text();
		  
		  $({ val : 0 }).animate({ val : memberCountConTxt }, {
		   duration: 8000,
		   step: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#between").text(num);
		  },
		  complete: function() {
		    var num = numberWithCommas(Math.floor(this.val));
		    $("#between").text(num);
		  }
		});
		
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		// 날짜 보여주기 end
		
		var editEmployee = '${ editEmployee }';
		if ( editEmployee && !history.state ) {
			$('#messageModal .modal-body').text("정보가 수정되었습니다.")
			$('#messageModal').modal('show');
		}

		var NewId = '${ NewId }';
		if( NewId && !history.state ) {
			alert("사원 등록이 완료되었습니다.");
		}
		history.replaceState({}, null, null);
	});			
	</script>


</body>

</html>