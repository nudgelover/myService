<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<style>
    #oneonone_box {
        width: 400px;
        height: 500px;
        position: fixed;
        bottom: 13%;
        right: 9%;
        display: none;
        z-index: 9999;
    }

    #to {
        height: 320px;
        overflow: auto;
        overflow-y: scroll;
    }
</style>

<script>
    let oneonone = {
        id            : null,
        stompClient   : null,
        init          : function () {
            this.id = $('#adm_id_oneonone').text();//adm_id에서 적힌 글씨를 id로 뿌려줄 예정이다.
            const oneononebox = $('#oneonone_box');
            $("#connect_oneonone").click(function () {
                oneonone.connect();
            });
            $("#disconnect_oneonone").click(function () {
                oneononebox.hide();
                oneonone.disconnect();
            });
            $("#sendto").click(function () {
                oneonone.sendTo();
            });
        },
        scrollToBottom: function () {
            const messengerBody = document.getElementById('to');
            messengerBody.scrollTop = messengerBody.scrollHeight;
        },
        connect       : function () {
            var sid = this.id;
            var socket = new SockJS('${adminserver}/ws');
            // SockJS는 웹소켓을 지원하지 않는 브라우저에서도 웹소켓과 유사한 방식으로 통신할 수 있게 해주는 js라이브러리
            this.stompClient = Stomp.over(socket);
            // Stomp는 웹소켓 프로토콜을 사용하는 메시징 서비스를 제공.(Simple Text Oriented Messaging Protocol)

            this.stompClient.connect({}, function (frame) {
                //첫 번째 매개변수는 연결 설정 객체, STOMP 메시지 브로커와의 인증을 위한 정보를 제공합니다.
                //두 번째 매개변수는 연결이 성공했을 때 실행될 콜백 함수입니다. 서버에서 전송한 메시지를 수신하기 위해 콜백 함수를 등록합니다.
                oneonone.setConnected(true);//단순히 connected, disconnected 적히게 하는 함수.
                console.log('Connected: ' + frame);

                this.subscribe('/send/to/' + sid, function (msg) {
                    $("#to").append(
                        // "<h4>" + JSON.parse(msg.body).sendid +":"+
                        // JSON.parse(msg.body).content1
                        // + "</h4>"

                        '<div class="d-flex justify-content-start mb-10"><div class="d-flex flex-column align-items-start"> <div class="d-flex align-items-center mb-2"> <div class="symbol symbol-35px symbol-circle"> <img alt="Pic" src="/img/logo.png"/> </div> <div class="ms-3"> <a href="#" class="fs-5 fw-bold text-gray-900 text-hover-primary me-1">' + "챗봇" + '</a></div> </div> <div class="p-5 rounded bg-light-info text-dark fw-semibold mw-lg-400px text-start">' + JSON.parse(msg.body).content1 + '</div></div></div>'
                    );
                });
            });
        },
        disconnect    : function () {
            if (this.stompClient !== null) {
                this.stompClient.disconnect();
            }
            oneonone.setConnected(false);
            console.log("Disconnected");
        },
        setConnected  : function (connected) {
            if (connected) {
                $("#status_oneonone").text("연결됨");
            } else {
                $("#status_oneonone").text("연결종료");
            }
        },
        sendTo        : function () {
            var msg = JSON.stringify({
                'sendid'   : this.id,
                'receiveid': $('#target').val(),
                'content1' : $('#totext').val()
            });
            this.stompClient.send('/receiveto', {}, msg);

            this.stompClient.send("/receiveme", {}, msg);
            $('#to').append(
                // '<h4>'+this.id+':'+ $('#totext').val()+'</h4>'
                '<div class="d-flex justify-content-end mb-10"><div class="d-flex flex-column align-items-end"> <div class="d-flex align-items-center mb-2"> <div class="me-3"> <a href="#"class="fs-5 fw-bold text-gray-900 text-hover-primary ms-1">나</a> </div> <div class="symbol symbol-35px symbol-circle"> <img alt="Pic" src="/uimg/${loginStdn.img}"/> </div> </div> <div class="p-5 rounded bg-light-primary text-dark fw-semibold mw-lg-400px text-end"data-kt-element="message-text">' + $('#totext').val() + '</div></div></div>'
            );
            oneonone.scrollToBottom();
            $('#totext').val('');
        }
    };
    $(function () {
        oneonone.init();
    })

</script>


<!-- DataTales Example -->
<div class="card shadow mb-4" id="oneonone_box">
    <div class="card-header py-3">
        <!--begin::Title-->
        <div class="card-title">
            <!--begin::User-->
            <div class="d-flex justify-content-center flex-column me-3">
                <h3>1:1 고객센터 <i class="bi-chat-square-dots text-gray-600"></i></h3>
                <p style="display: none" id="adm_id_oneonone">${loginStdn.id}</p>
                <!--begin::Info-->
                <div class="mb-0 lh-1">
                    <span class="badge badge-success badge-circle w-10px h-10px me-1"></span>
                    <span id="status_oneonone" class="fs-7 fw-semibold text-muted">연결대기</span>
                </div>
                <!--end::Info-->
            </div>
            <!--end::User-->
        </div>
        <!--end::Title-->
        <!--begin::Card toolbar-->
        <div class="card-toolbar">
            <!--begin::Menu-->
            <div class="me-2">
                <button class="btn btn-sm btn-icon btn-active-light-primary" id="connect_oneonone">
                    연결
                </button>
            </div>
            <!--end::Menu-->
            <!--begin::Close-->
            <div id="disconnect_oneonone" class="btn btn-sm btn-icon btn-active-light-primary">
                <!--begin::Svg Icon | path: icons/duotune/arrows/arr061.svg-->
                <span class="svg-icon svg-icon-2">
								<svg width="24" height="24" viewBox="0 0 24 24" fill="none"
                                     xmlns="http://www.w3.org/2000/svg">
									<rect opacity="0.5" x="6" y="17.3137" width="16" height="2" rx="1"
                                          transform="rotate(-45 6 17.3137)" fill="currentColor"/>
									<rect x="7.41422" y="6" width="16" height="2" rx="1"
                                          transform="rotate(45 7.41422 6)" fill="currentColor"/>
								</svg>
							</span>
                <!--end::Svg Icon-->
            </div>
            <!--end::Close-->
        </div>
        <!--end::Card toolbar-->
    </div>
    <div class="card-body">
        <div id="container"></div>
        <div class="col-sm-12">
            <%--                <h3 id="adm_id_oneonone">${loginStdn.id}</h3>--%>
            <%--                <H3 id="status_oneonone">Status</H3>--%>
            <%--                <button id="connect_oneonone" class="btn btn-info">Connect</button>--%>
            <%--                <button id="disconnect_oneonone" class="btn btn-info">Disconnect</button>--%>

            <div id="to">
                <div class="d-flex justify-content-start mb-10">
                    <div class="d-flex flex-column align-items-start">
                        <div class="d-flex align-items-center mb-2">
                            <div class="symbol symbol-35px symbol-circle"><img alt="Pic" src="/img/logo.png"/></div>
                            <div class="ms-3"><a href="#"
                                                 class="fs-5 fw-bold text-gray-900 text-hover-primary me-1">당케 관리자</a></div>
                        </div>
                        <div class="p-5 rounded bg-light-info text-dark fw-semibold mw-lg-400px text-start"> 안녕하세요, 1:1 고객센터입니다. 무엇을 도와드릴까요?</div>
                    </div>
                </div>
            </div>
            <input type="hidden" id="target" value="qwer">

            <div class="d-flex">
                <input type="text" class="form-control form-control-flush mb-3" id="totext"
                       placeholder="문의하실 내용을 입력해주세요.">
                <button id="sendto" class="btn btn-sm btn-success">Send</button>
            </div>
        </div>
    </div>
</div>
