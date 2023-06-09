package com.myservice.curri;

import com.myservice.service.CurriService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class CntTest {

    @Autowired
    CurriService service;
    @Test
    void contextLoads() {
        try {
            service.cntMyCurri("id001");
        } catch (Exception e) {
            log.info("select one error-----------------------------");
            e.printStackTrace();
        }
        }
    }

