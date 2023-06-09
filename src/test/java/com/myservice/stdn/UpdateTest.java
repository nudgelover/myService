package com.myservice.stdn;


import com.myservice.dto.Stdn;
import com.myservice.service.StdnService;
import lombok.extern.slf4j.Slf4j;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@Slf4j
@SpringBootTest
class UpdateTest {

    @Autowired
    StdnService service;

    @Test
    void contextLoads() {
        Stdn obj = new Stdn("id001", "kim@naver.com","2.jpg","1990/10/13", "JAVA", "C++", "C#");

        try {
            service.modify(obj);
            log.info("update OK--------------------------------");
            service.get("id001");
        } catch (Exception e) {
            log.info("update error-----------------------------");
        }
    }

}
