 <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("utf-8"); %>

		<div class="nav-header">
            <div class="brand-logo">
                <a href="/">
                    <b class="logo-abbr"><img src="/resources/images/logo.png" alt=""> </b>
                    
                    <span class="logo-compact"><img src="/resources/images/logo-compact.png" alt=""></span>
                    <span class="brand-title">
                        <img src="/resources/images/goodi_logo1.PNG" alt="">
                    </span>
                </a>
            </div>
        </div>
        

  		 <div class="header">    
            <div class="header-content clearfix">
                
                <div class="nav-control">
                    <div class="hamburger">
                        <span class="toggle-icon"><i class="icon-menu"></i></span>
                    </div>
                </div>
                <div class="header-left">
                    <div class="input-group icons">
                        <div class="input-group-prepend">
                            <span class="input-group-text bg-transparent border-0 pr-2 pr-sm-3" id="basic-addon1"><i class="mdi mdi-magnify"></i></span>
                        </div>
 						<form class="form-inline" action="/employee/searchEmp" id="search-form">
						  <div class="form-group mx-sm-3 mb-2">
						    <input name="name" type="text" class="form-control" id="searchName" placeholder="사원 또는 부서 검색">
						  </div>
						  <button class="btn btn-primary mb-2" id="searchEmp">검색</button>
						</form>
                    </div>
                </div>
                <div class="header-right">
                    <ul class="clearfix">
                    	
                    	<c:choose>
                    	<c:when test="${empty sessionScope.loginuser }">
                        <li class="icons dropdown d-none d-md-flex">
                            <a href="/employee/login"><span>로그인</span></a>
                        </li>
                        </c:when>
                    	<c:otherwise>
                    	<li class="icons dropdown">
                            <span>${ loginuser.name }님 환영합니다</span>
                        </li>
                        <li class="icons dropdown">
                            <div class="user-img c-pointer position-relative"   data-toggle="dropdown">
                                <span class="activity active"></span>
                                <c:choose>
	                                <c:when test="${ not empty loginuser.picture }">
	                                	<img src="/resources/file/employee/photo/${ loginuser.picture }" height="40" width="40" alt="">
	                                </c:when>
	                                <c:otherwise>
	                                	<img src="/resources/file/employee/photo/unnamed.jpg" height="40" width="40" alt="">
	                                </c:otherwise>
                                </c:choose>
                            </div>
                            <div class="drop-down dropdown-profile animated fadeIn dropdown-menu">
                                <div class="dropdown-content-body">
                                    <ul>
                                        <li>
                                            <a href="/employee/edit?empNo=${ loginuser.empno }"><i class="icon-user"></i> <span>내 정보</span></a>
                                        </li>
                                        <li>
                                            <a href="/message/inbox?empno=${ loginuser.empno }"><i class="icon-envelope-open"></i> <span>받은메일함</span></a>
                                        </li>
                                        
                                        <hr class="my-2">
                                        <li><a href="/employee/logout"><i class="icon-key"></i> <span>로그아웃</span></a></li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    	</c:otherwise>
                    	</c:choose>
                    </ul>
                </div>
            </div>
        </div>
   
<script type="text/javascript">
	$(function(){

		/* $(".icon-key").on("click", function(event){

			var result = confirm('로그아웃 하시겠습니까?');
			if (!result) {
				return false;
			} else {
				location.href = "/employee/logout";
				alert('안전하게 로그아웃 되었습니다');
			}
			
		}); */

		$("#searchEmp").on("click", function(event){

			event.preventDefault();
			
			if($("#searchName").val() == '') {
				alert("검색어를 입력하세요");
				$("#searchName").focus();
				return;
			}
			
			$("#search-form").submit();
			
		});
	});
   
</script>           