<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>최종승인자 검색</title>
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

	<br>
	<form id="search-form" action="/appr/searchFaccp" method="post" class="user">
		<div class="input-group mb-3">
		  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="faccp"  name="name">
		  <div class="input-group-append">
		    <button class="btn btn-outline-secondary" type="button" id="searchfaccp">검색</button>
		  </div>
		</div>
	</form>
	
	<p>검색결과</p>

	<table class="table">
	  <thead>
	    <tr>
	      <th>사번</th>
	      <th>이름</th>
	      <th>부서</th>
	      <!-- <th></th> -->
	    </tr>
	  </thead>
	  <c:if test="${ empty faccps }">
      <p class="text-center">검색결과가 없읍니다</p>
      </c:if>
	<c:forEach items="${ faccps }" var="faccp">	
	  <tbody class="faccplist">
	    <tr>
	      <th id="faccpid" data-faccp="${ faccp.empno }">${ faccp.empno }</th>
	      <td><a href="#" class="selectfaccp" data-faccpname="${ faccp.name }">${ faccp.name }</a></td>
	      <td>${ faccp.depname }</td>
	      <!-- <td><button type="button" class="btn btn-primary" id="registerAproval">선택</button></td> -->
	    </tr>
	  </tbody>
	</c:forEach>
	</table>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type='text/javascript'>
	$(function(){

		$("#searchfaccp").on("click", function(event){

			if($("#faccp").val() == '' ){
				alert("승인자를 입력하세요!");
				$("#faccp").focus();
				return;
			}
			
			$("#search-form").submit();

		});

		
		$(".faccplist").on("click", '.selectfaccp', function(event){

			var faccp = $("#faccpid").attr('data-faccp');
			var faccpname = $(this).attr('data-faccpname');
			
			$("#faccp", opener.document).val(faccp);
			$("#faccpname", opener.document).val(faccpname);

			window.close();


		})
		
	    
	});
	</script>


</body>



</html>