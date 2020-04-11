<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

  		        <div class="nk-sidebar">           
            <div class="nk-nav-scroll">
                <ul class="metismenu" id="menu">
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-envelope menu-icon"></i> <span class="nav-text">메일</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/message/inbox?empno=${ loginuser.empno }">받은메일함</a></li>
                            <li><a href="/message/compose?empno=${ loginuser.empno }">메일쓰기</a></li>
                        </ul>
                    </li>
                    <li class="mega-menu mega-menu-sm">
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-globe-alt menu-icon"></i><span class="nav-text">전자결재</span>
                        </a>
                        <ul aria-expanded="false">
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
                            <li><a href="/schedule/myschedule">나의일정</a></li>
                        </ul>
                    </li>
                     <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-menu menu-icon"></i><span class="nav-text">게시판</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/board/list">자유게시판</a></li>
                            <li><a href="#">중고장터</a></li>
                            <li><a href="/reference/list">자료실</a></li>
                        </ul>
                    </li>
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-notebook menu-icon"></i><span class="nav-text">마이페이지</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="#">출퇴근관리</a></li>
                            <li><a href="/employee/edit">나의정보수정</a></li>
                            <!-- <li><a href="/employee/confirmPw">패스워드변경</a></li> -->
                        </ul>
                    </li>
                    
                    <c:choose>
                    <c:when test="${ loginuser.auth.authno eq 2 or loginuser.auth.authno eq 3 }">
                    <li>
                        <a class="has-arrow" href="javascript:void()" aria-expanded="false">
                            <i class="icon-note menu-icon"></i><span class="nav-text">관리자페이지</span>
                        </a>
                        <ul aria-expanded="false">
                            <li><a href="/admin/register">사원 등록</a></li>
                            <li><a href="#">사원정보수정</a></li>
                        </ul>
                    </li>
                    </c:when>
                    </c:choose> 
                </ul>
            </div>
        </div>
        




	
        
  		