<%@ page pageEncoding="utf-8" contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html class="no-js" lang="ko">

<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>회의실 리스트</title>
    <!-- Favicon icon -->
    <link rel="icon" type="image/png" sizes="16x16" href="/resources/images/favicon.png">
    <!-- Custom Stylesheet -->
    <link href="/resources/plugins/tables/css/datatable/dataTables.bootstrap4.min.css" rel="stylesheet">
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
			<div style="margin-top: 100px" class="container" id="app" v-cloak>
		        <div class="row">
		            <div class="col-md-6">
		                <h3>채팅방 리스트</h3>
		            </div>
		            <div class="col-md-6 text-right">
		                
		            </div>
		        </div>
		        <div class="input-group">
		            <div class="input-group-prepend">
		                <label class="input-group-text">방제목</label>
		            </div>
		            <input type="text" class="form-control" v-model="room_name" v-on:keyup.enter="createRoom">
		            <div class="input-group-append">
		                <button class="btn btn-primary" type="button" @click="createRoom">회의방 개설</button>
		            </div>
		        </div>
		        <ul class="list-group">
		            <li class="list-group-item list-group-item-action" v-for="item in chatrooms" v-bind:key="item.roomId" v-on:click="enterRoom(item.roomId, item.name)">
		                <h6>{{item.name}} <span class="badge badge-info badge-pill">{{item.userCount}}</span></h6>
		            </li>
		        </ul>
		    </div>        
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/modules/common-js.jsp"></jsp:include>

    <!-- JavaScript -->
    <script src="/webjars/vue/2.5.16/dist/vue.min.js"></script>
    <script src="/webjars/axios/0.17.1/dist/axios.min.js"></script>
    <script>
        var vm = new Vue({
            el: '#app',
            data: {
                room_name : '',
                chatrooms: [
                ]
            },
            created() {
                this.findAllRoom();
            },
            methods: {
                findAllRoom: function() {
                    axios.get('/chat/rooms').then(response => {
                        // prevent html, allow json array
                        if(Object.prototype.toString.call(response.data) === "[object Array]"
                )
                    this.chatrooms = response.data;
                })
                    ;
                },
                createRoom: function() {
                    if("" === this.room_name) {
                        alert("방 제목을 입력해 주십시요.");
                        return;
                    } else {
                        var params = new URLSearchParams();
                        params.append("name",this.room_name);
                        axios.post('/chat/room', params)
                        .then(
                            response => {
                                alert(response.data.name+"방 개설에 성공하였습니다.")
                                this.room_name = '';
                                this.findAllRoom();
                            }
                        )
                        .catch( response => { alert("채팅방 개설에 실패하였습니다."); } );
                    }
                },
                enterRoom: function(roomId, roomName) {
                    localStorage.setItem('wschat.roomId',roomId);
                    localStorage.setItem('wschat.roomName',roomName);
                    location.href="/chat/room/enter/"+roomId;
                }
            }
        });
    </script>
  </body>
</html>