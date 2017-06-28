package com.appstore.dao;


import com.appstore.entity.Picture;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PictureDao {
    Picture getLogoPicByAppId(Long appId);
    int save(Picture pic);
    List<Picture> getDisplaysPicByAppId(Long appId);
    int updatePicByAppId(@Param("appId") Long appId, @Param("moduleName") String moduleName, @Param("picPath") String picPath, @Param("picName") String picName);
    Picture getDisplayPicByAppIdAndModuleIndex(@Param("appId")Long appId,@Param("moduleIndex")String  moduleIndex);
}