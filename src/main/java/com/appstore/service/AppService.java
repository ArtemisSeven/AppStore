package com.appstore.service;

import com.appstore.entity.App;

import java.util.List;

public interface AppService {
    List<App> searchByStateAndKeywordLimit(int offset, int limit, String state, String keyword);

    List<App> searchByStateAndKeyword(String state, String keyword);

    List<App> searchByKeywordLimit(int offset, int limit, String keyword);

    List<App> searchByKeyword(String keyword);

    Long save(App app);

    boolean checkAppNameExist(String appName);

    String getNameById(long id);

    List<App> getIdAndName();

    boolean deleteById(long id);

    App getAppByName(String appName);

    boolean updateFilePathById(long id, String value);

    boolean updateFileNameById(long id, String value);

    boolean updateAppNameById(long id, String value);

    boolean updateVersionById(long id, String value);

    boolean updateOsById(long id, String value);

    boolean updateTypeIdById(long id, long value);

    boolean updateCompanyById(long id, String value);

    boolean updateDescriptionById(long id, String value);

    boolean updateStateById(long id, String value);

    boolean updateRatingCountAndAvgScoreById(long id,Long ratingCount,byte avgScore);

    boolean updateDownloadCountById(long id,Long downloadCount);

    List<App> getAllAppByAvgScore();

    List<App> getAllAppByDownloadCount();

    List<App> getAllAppByAvgScoreLimit(int offset,int limit);

    List<App> getAllAppByDownloadCountLimit(int offset,int limit);

    List<App> getAllAppByTypeId(long typeId);

    List<App> getAllAppByTypeIdLimit(long typeId,int offset,int limit);

    App getAppById(long id);
}
