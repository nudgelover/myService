package com.myservice.blah;

import com.myservice.service.BlahService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class DeleteTest {

    @Autowired
    BlahService service;

    @Test
    void contextLoads() {
        try {
            service.remove(1);
            log.info("remove OK--------------------------------");
            service.get();
        } catch (Exception e) {
            log.info("remove error-----------------------------");
        }
    }

}
