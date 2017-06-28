package com.appstore.dao;

import com.appstore.entity.User;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface UserDao {
    User checkPhone(Long phone);
    User getUserByAccount(@Param("phone") Long phone,@Param("psw") String psw);
    int saveAccount(@Param("phone") Long phone,@Param("psw") String psw);
    User getUserById(long id);
    int updatePsw(@Param("id") long id,@Param("newPsw") String newPsw);
}