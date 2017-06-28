package com.appstore.dao;


import com.appstore.entity.App;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AppDao {
    Long save(App app);

    List<App> searchByStateAndKeywordLimit(@Param("offset") int offset, @Param("limit") int limit, @Param("state") String state, @Param("keyword") String keyword);

    List<App> searchByStateAndKeyword(@Param("state") String state, @Param("keyword") String keyword);

    List<App> searchByKeyword(String keyword);

    List<App> searchByKeywordLimit(@Param("offset") int offset, @Param("limit") int limit, @Param("keyword") String keyword);

    App getAppByAppName(String appName);

    List<App> checkAppNameExist(String appName);

    String getNameById(long id);

    List<App> getIdAndName();

    int deleteById(long id);

    int updateFilePathById(@Param("id") long id, @Param("value") String value);

    int updateFileNameById(@Param("id") long id, @Param("value") String value);

    int updateAppNameById(@Param("id") long id, @Param("value") String value);

    int updateVersionById(@Param("id") long id, @Param("value") String value);

    int updateOsById(@Param("id") long id, @Param("value") String value);

    int updateTypeIdById(@Param("id") long id, @Param("value") long value);

    int updateCompanyById(@Param("id") long id, @Param("value") String value);

    int updateDescriptionById(@Param("id") long id, @Param("value") String value);

    int updateStateById(@Param("id") long id, @Param("value") String value);

    List<App> getAllAppByAvgScore();

    List<App> getAllAppByDownloadCount();

    List<App> getAllAppByAvgScoreLimit(@Param("offset")int offset,@Param("limit")int limit);

    List<App> getAllAppByDownloadCountLimit(@Param("offset")int offset,@Param("limit")int limit);

    List<App> getAllAppByTypeId(@Param("typeId")long typeId);

    List<App> getAllAppByTypeIdLimit(@Param("typeId")long typeId,@Param("offset")int offset,@Param("limit")int limit);

    App getAppById(long id);

    int updateRatingCountAndAvgScoreById(@Param("id")long id,@Param("ratingCount")Long ratingCount,@Param("avgScore")byte avgscore);

    int updateDownloadCountById(@Param("id")long id,@Param("downloadCount")Long downloadCount);
}


