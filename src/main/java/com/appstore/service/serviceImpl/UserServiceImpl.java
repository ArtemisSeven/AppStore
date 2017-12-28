package com.appstore.service.serviceImpl;

import com.appstore.dao.UserDao;
import com.appstore.entity.User;
import com.appstore.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private UserDao userDao;

    public boolean checkPhone(String phone) {
        if (userDao.checkPhone(phone)!=null) return true;
        else return false;
    }

    public User getUserByAccount(String phone, String psw) {
        User user=userDao.getUserByAccount(phone,psw);
        if (user!=null) return user;
        else return null;
    }

    public User registerAccount(String phone, String psw) {
        int result=userDao.saveAccount(phone,psw);
        if (result>0){
            return  userDao.getUserByAccount(phone,psw);
        }else {
            return null;
        }
    }

    public User getUserById(long id) {
        return userDao.getUserById(id);
    }

    public boolean updatePsw(long id, String newPsw) {
        if (userDao.updatePsw(id,newPsw)>0) return true;
        else return false;
    }
}
