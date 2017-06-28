package com.appstore.service;

import com.appstore.entity.User;
import org.springframework.stereotype.Service;


public interface UserService {
    boolean checkPhone(Long phone);
    User getUserByAccount(Long phone,String psw);
    User registerAccount(Long phone,String psw);
    User getUserById(long id);
    boolean updatePsw(long id,String newPsw);
}
