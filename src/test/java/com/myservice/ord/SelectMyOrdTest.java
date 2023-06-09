package com.myservice.ord;

import com.myservice.service.OrdService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class SelectMyOrdTest {

    @Autowired
    OrdService service;

    @Test
    void contextLoads() {
        try {
            service.getMyOrd("12345");
        } catch (Exception e) {
            log.info("select stdn error-----------------------------");
            e.printStackTrace();
        }
        }
    }

