<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>중간승인자 검색</title>
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
	<form id="search-form" action="/appr/searchMaccp" method="post" class="user">
		<div class="input-group mb-3">
		  <input type="text" class="form-control" placeholder="" aria-label="Recipient's username" aria-describedby="button-addon2" id="faccp" name=faccp>
		  <div class="input-group-append">
		    <button class="btn btn-outline-secondary" type="button" id="searchmaccp" name="name">검색</button>
		  </div>
		</div>
	</form>
	
	검색결과

	<c:forEach items="${ maccp }" var="maccp">	
	<table class="table">
	  <tbody>
	    <tr>
	      <td>${ maccp.name }</td>
	    </tr>
	 </tbody>
	</table>
	</c:forEach>

	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type='text/javascript'>
	$(function(){

		$("#searchmaccp").on("click", function(event){

			if($("#maccp").val() == '' ){
				alert("승인자를 입력하세요!");
				$("#maccp").focus();
				return;
			}
			
			$("#search-form").submit();

		})
		
	    
	});
	</script>


</body>



</html>