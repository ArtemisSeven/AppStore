package com.appstore.service.serviceImpl;

import com.appstore.dao.PictureDao;
import com.appstore.entity.Picture;
import com.appstore.service.PictureService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class PictureServiceImpl implements PictureService {
    @Autowired
    PictureDao pictureDao;
    public Picture getLogoPicByAppId(Long appId) {
        return pictureDao.getLogoPicByAppId(appId);
    }

    public boolean save(Picture pic) {
        if (pictureDao.save(pic)>0) return true;
        else return false;
    }

    public List<Picture> getDisplaysPicByAppId(Long appId) {
        return pictureDao.getDisplaysPicByAppId(appId);
    }

    public boolean updatePicByAppId(Long appId, String moduleName, String picPath, String picName) {
        if (pictureDao.updatePicByAppId(appId,moduleName,picPath,picName)>0) return true;
        else return false;
    }

    public Picture getDisplayPicByAppIdAndModuleIndex(Long appId, String moduleIndex) {
        return pictureDao.getDisplayPicByAppIdAndModuleIndex(appId,moduleIndex);
    }
}
