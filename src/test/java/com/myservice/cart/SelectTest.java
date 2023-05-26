package com.myservice.cart;

import com.myservice.service.CartService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class SelectTest {

    @Autowired
    CartService service;
    @Test
    void contextLoads() {
        try {
            service.get();
        } catch (Exception e) {
            log.info("select error-----------------------------");
            e.printStackTrace();
        }
    }
}

