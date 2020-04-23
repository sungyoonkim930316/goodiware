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
    <title>회의실</title>
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
		                <h4>&nbsp;◈&nbsp;{{roomName}}&nbsp;◈ <span class="badge badge-info badge-pill">&nbsp;&nbsp;{{userCount}}명 참가중</span></h4>
		            </div>
		            <div class="col-md-6 text-right">
		                <a class="btn btn-info btn-sm" href="/chat/room">회의방 나가기</a>
		            </div>
		        </div>
		        <hr>
		        <div class="input-group">
		            <div class="input-group-prepend">
		                <label class="input-group-text">내용</label>
		            </div>
		            <input type="text" class="form-control" v-model="message" v-on:keypress.enter="sendMessage('TALK')">
		            <div class="input-group-append">
		                <button class="btn btn-primary" type="button" @click="sendMessage('TALK')">보내기</button>
		            </div>
		        </div>
		        <ul class="list-group">
		            <li class="list-group-item" v-for="message in messages">
		                {{message.sender}} - {{message.message}}</a>
		            </li>
		        </ul>
		    </div>        
        </div>
    </div>
	<jsp:include page="/WEB-INF/views/modules/common-js.jsp"></jsp:include>

    <!-- JavaScript -->
    <script src="/webjars/vue/2.5.16/dist/vue.min.js"></script>
    <script src="/webjars/axios/0.17.1/dist/axios.min.js"></script>
    <script src="/webjars/sockjs-client/1.1.2/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/2.3.3-1/stomp.min.js"></script>
    <script>
        // websocket & stomp initialize
        var sock = new SockJS("/ws-stomp");
        var ws = Stomp.over(sock);
        // vue.js
        var vm = new Vue({
            el: '#app',
            data: {
                roomId: '',
                roomName: '',
                message: '',
                messages: [],
                token: '',
                userCount: 0
            },
            created() {
                this.roomId = localStorage.getItem('wschat.roomId');
                this.roomName = localStorage.getItem('wschat.roomName');
                var _this = this;
                axios.get('/chat/user').then(response => {
                    _this.token = response.data.token;
                    ws.connect({"token":_this.token}, function(frame) {
                        ws.subscribe("/sub/chat/room/"+_this.roomId, function(message) {
                            var recv = JSON.parse(message.body);
                            _this.recvMessage(recv);
                        });
                    }, function(error) {
                        alert("서버 연결에 실패 하였습니다. 다시 접속해 주십시요.");
                        location.href="/chat/room";
                    });
                });
            },
            methods: {
                sendMessage: function(type) {
                    ws.send("/pub/chat/message", {"token":this.token}, JSON.stringify({type:type, roomId:this.roomId, message:this.message}));
                    this.message = '';
                },
                recvMessage: function(recv) {
                    this.userCount = recv.userCount;
                    this.messages.unshift({"type":recv.type,"sender":recv.sender,"message":recv.message})
                }
            }
        });
    </script>
  </body>
</html>