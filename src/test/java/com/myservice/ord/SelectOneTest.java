package com.myservice.ord;

import com.myservice.service.OrdService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class SelectOneTest {

    @Autowired
    OrdService service;

    @Test
    void contextLoads() {
        try {
            service.get(2801);
        } catch (Exception e) {
            log.info("select one error-----------------------------");
            e.printStackTrace();
        }
        }
    }

