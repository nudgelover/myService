package com.myservice.test;

import com.myservice.dto.Test;
import com.myservice.service.TestService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class UpdateTest {

    @Autowired
    TestService service;

    @org.junit.jupiter.api.Test
    void contextLoads() {
        Test obj = new com.myservice.dto.Test(2001,"www.daum.net", 100, "php");

        try {
            service.modify(obj);
            log.info("update OK--------------------------------");
            service.get(2001);
        } catch (Exception e) {
            log.info("update error-----------------------------");
        }
    }

}
