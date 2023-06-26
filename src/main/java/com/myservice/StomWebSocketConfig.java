package com.myservice;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@EnableWebSocketMessageBroker
@Configuration
public class StomWebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Value("${serviceserver}")
    String serviceServer;

    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
//        registry.addEndpoint("/ws").setAllowedOrigins("http://127.0.0.1",serviceServer).withSockJS();
        registry.addEndpoint("/ws").setAllowedOrigins("http://127.0.0.1", serviceServer).withSockJS();
        //채팅하기 위한 서버
        registry.addEndpoint("/alarm").setAllowedOrigins("http://127.0.0.1", serviceServer).withSockJS();
        //블라블라알람
        registry.addEndpoint("/blahalarm").setAllowedOrigins("http://127.0.0.1", serviceServer).withSockJS();
        //마커알람
    }

    /* 어플리케이션 내부에서 사용할 path를 지정할 수 있음 */
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/send", "/alarm", "/blahalarm");
    }
}