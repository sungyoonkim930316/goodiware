<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>로그인</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/assets/images/favicon.png">
    <!-- <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous"> -->
    <link href="/resources/css/style.css" rel="stylesheet">
    
</head>

<body class="h-100">
    
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

    



    <div class="login-form-bg h-100">
        <div class="container h-100">
            <div class="row justify-content-center h-100">
                <div class="col-xl-6">
                    <div class="form-input-content">
                        <div class="card login-form mb-0">
                            <div class="card-body pt-5">
                                <a class="text-center" href="index.html"> <h4>로그인</h4></a>
        
                                <form class="mt-5 mb-5 login-input" method="post" action="/employee/login" id="login-form">
                                    <div class="form-group">
                                        <input type="id" class="form-control" placeholder="아이디" name="id" id="id">
                                    </div>
                                    <div class="form-group">
                                        <input type="pw" class="form-control" placeholder="패스워드" name="pw" id="pw">
                                    </div>
                                    <button type="button" id="login" class="btn login-form__btn submit w-100">로그인</button>
                                </form>
                                <!-- <p class="mt-5 login-form__footer">Dont have account? <a href="/admin/register" class="text-primary">회원가입</a></p> -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
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

			$("#login").on("click" , function(event) {
				// 1. 유효성 검사
				if($("#id").val() == '' ){
					alert("아이디를 입력하세요!");
					$("#id").focus();
					return;
				}
				if($("#pw").val() == '' ){
					alert("패스워드를 입력하세요!");
					$("#pw").focus();
					return;
				}
				
				// 2. 오류가 없다면 서버로 전송
				$("#login-form").submit();
			});

			
			var newId = '${ newId }'; 
			var loginFalse = '${ loginFalse }';
			
			if(newId && !history.state) {
				$('#messageModal .modal-body').text("사원 등록이 완료 되었습니다.")
				$('#messageModal').modal('show');
			} else if( loginFalse && !history.state ) {
				$('#messageModal .modal-body').text("로그인 실패 하였습니다.")
				$('#messageModal').modal('show');
			}
			history.replaceState({}, null, null);

			
			
		});
		
	</script>    
    
    
</body>
</html>





