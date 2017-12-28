package com.appstore.service;

import com.appstore.entity.User;
import org.springframework.stereotype.Service;


public interface UserService {
    boolean checkPhone(String phone);
    User getUserByAccount(String phone,String psw);
    User registerAccount(String phone,String psw);
    User getUserById(long id);
    boolean updatePsw(long id,String newPsw);
}
