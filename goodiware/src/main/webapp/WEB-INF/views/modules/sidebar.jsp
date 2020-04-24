<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

  		        <div class="nk-sidebar">           
            <div class="nk-nav-scroll">
            	<sec:authentication var="auth" property="principal" />
                <ul class="metismenu" id="menu">
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-envelope menu-icon"></i> <span class="nav-text">메일</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/message/inbox?empno=${ auth.employee.empno }">받은메일함</a></li>
                            <li><a href="/message/compose?empno=${ auth.employee.empno }">메일쓰기</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">전자결재</span>
                        </a>
                        <ul aria-expanded="false">
                            <!-- <li><a href="/appr/apprlist?appdivno=1">업무</a></li>
                            <li><a href="/appr/apprlist?appdivno=2">파견</a></li>
                            <li><a href="/appr/apprlist?appdivno=3">경비지출</a></li>
                            <li><a href="/appr/apprlist?appdivno=4">초과근무</a></li>
                            <li><a href="/appr/apprlist?appdivno=5">휴가</a></li> -->
                            <li><a href="#">업무</a></li>
                            <li><a href="#">파견</a></li>
                            <li><a href="#">경비지출</a></li>
                            <li><a href="#">초과근무</a></li>
                            <li><a href="#">휴가</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-screen-tablet menu-icon"></i><span class="nav-text">일정관리</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/schedule/myschedule?empno=${ auth.employee.empno }">나의일정</a></li>
                        </ul>
                    </li>
                     <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-menu menu-icon"></i><span class="nav-text">게시판</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/board/list">자유게시판</a></li>
                            <li><a href="/reference/list">자료실</a></li>
                            <li><a href="/market/list">나눔장터</a></li>
                        </ul>
                    </li>
                     <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="mdi mdi-bell-outline"></i><span class="nav-text">회의</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/chat/room">회의실 목록</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-notebook menu-icon"></i><span class="nav-text">마이페이지</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/employee/edit?empNo=${ auth.employee.empno }">나의정보수정</a></li>
                            <!-- <li><a href="/employee/confirmPw">패스워드변경</a></li> -->
                        </ul>
                    </li>
                    
                    <c:choose>
                    <c:when test="${ auth.employee.auth.authno eq 2 or auth.employee.auth.authno eq 3 }">
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-note menu-icon"></i><span class="nav-text">관리자페이지</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/admin/register">사원 등록</a></li>
                            <li><a href="/admin/empList">사원정보수정</a></li>
                        </ul>
                    </li>
                    </c:when>
                    </c:choose> 
                </ul>
            </div>
        </div>
        




	
        
  		