package com.appstore.service;

import com.appstore.entity.Picture;

import java.util.List;


public interface PictureService {
    Picture getLogoPicByAppId(Long appId);
    boolean save(Picture pic);
    List<Picture> getDisplaysPicByAppId(Long appId);
    boolean updatePicByAppId(Long appId,String moduleName,String picPath,String picName);
    Picture getDisplayPicByAppIdAndModuleIndex(Long appId,String moduleIndex);
}
