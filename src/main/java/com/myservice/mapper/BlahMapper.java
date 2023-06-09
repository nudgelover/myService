package com.myservice.mapper;

import com.myservice.dto.Blah;
import com.myservice.frame.KBMapper;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface BlahMapper extends KBMapper<Integer, Blah> {
    public List<Blah> getMyBlah(String stdnId) throws Exception;
    public List<Blah> getBlahRank() throws Exception;
    public Blah getMyBlahRank(String stdnId) throws Exception;
    public Integer cntLike(Integer id) throws Exception;
    public Integer cntGetMyBlah(String stdnId) throws Exception;
    public Integer cntGetMyComm(String stdnId) throws Exception;

    public Integer cntGetMylikes(String stdnId) throws Exception;
    public void updateLikes(Blah blah) throws Exception;
}
