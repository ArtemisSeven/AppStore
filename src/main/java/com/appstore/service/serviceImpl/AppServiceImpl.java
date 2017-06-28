package com.appstore.service.serviceImpl;

import com.appstore.dao.AppDao;
import com.appstore.entity.App;
import com.appstore.service.AppService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AppServiceImpl implements AppService {
    @Autowired
    private AppDao appDao;

    public List<App> searchByStateAndKeywordLimit(int offset, int limit, String state, String keyword) {
        return appDao.searchByStateAndKeywordLimit(offset, limit, state, keyword);
    }

    public List<App> searchByStateAndKeyword(String state, String keyword) {
        if (state.equals("ALL")) return appDao.searchByKeyword(keyword);
        else return appDao.searchByStateAndKeyword(state, keyword);
    }

    public List<App> searchByKeywordLimit(int offset, int limit, String keyword) {
        return appDao.searchByKeywordLimit(offset, limit, keyword);
    }

    public List<App> searchByKeyword(String keyword) {
        return appDao.searchByKeyword(keyword);
    }

    public Long save(App app) {
        return appDao.save(app);
    }

    public boolean checkAppNameExist(String appName) {
        if (appDao.checkAppNameExist(appName).size()>0) return true;
        else return false;
    }

    public String getNameById(long id) {
        return appDao.getNameById(id);
    }

    public List<App> getIdAndName() {
        return appDao.getIdAndName();
    }

    public boolean deleteById(long id) {
        if (appDao.deleteById(id) > 0) return true;
        else return false;
    }

    public App getAppByName(String appName) {
        return appDao.getAppByAppName(appName);
    }

    public boolean updateFilePathById(long id, String value) {
        if (appDao.updateFilePathById(id,value)>0) return true;
        else return false;
    }
    public boolean updateFileNameById(long id, String value) {
        if (appDao.updateFileNameById(id,value)>0) return true;
        else return false;
    }
    public boolean updateAppNameById(long id, String value) {
        if (appDao.updateAppNameById(id,value)>0) return true;
        else return false;
    }
    public boolean updateVersionById(long id, String value) {
        if (appDao.updateVersionById(id,value)>0) return true;
        else return false;
    }

    public boolean updateOsById(long id, String value) {
        if (appDao.updateOsById(id,value)>0) return true;
        else return false;
    }

    public boolean updateTypeIdById(long id, long value) {
        if (appDao.updateTypeIdById(id,value)>0) return true;
        else return false;
    }
    public boolean updateCompanyById(long id, String value) {
        if (appDao.updateCompanyById(id,value)>0) return true;
        else return false;
    }
    public boolean updateDescriptionById(long id, String value) {
        if (appDao.updateDescriptionById(id,value)>0) return true;
        else return false;
    }

    public boolean updateStateById(long id, String value) {
        if (appDao.updateStateById(id,value)>0) return true;
        else return false;
    }

    public boolean updateRatingCountAndAvgScoreById(long id,Long ratingCount, byte avgScore) {
        if (appDao.updateRatingCountAndAvgScoreById(id,ratingCount,avgScore)>0) return true;
        else return false;
    }

    public boolean updateDownloadCountById(long id, Long downloadCount) {
        if (appDao.updateDownloadCountById(id,downloadCount)>0) return true;
        else return false;
    }

    public List<App> getAllAppByAvgScore() {
        return appDao.getAllAppByAvgScore();
    }

    public List<App> getAllAppByDownloadCount() {
        return appDao.getAllAppByDownloadCount();
    }

    public List<App> getAllAppByAvgScoreLimit(int offset, int limit) {
        return appDao.getAllAppByAvgScoreLimit(offset,limit);
    }

    public List<App> getAllAppByDownloadCountLimit(int offset, int limit) {
        return appDao.getAllAppByDownloadCountLimit(offset,limit);
    }

    public List<App> getAllAppByTypeId(long typeId) {
        return appDao.getAllAppByTypeId(typeId);
    }

    public List<App> getAllAppByTypeIdLimit(long typeId, int offset, int limit) {
        return appDao.getAllAppByTypeIdLimit(typeId,offset,limit);
    }

    public App getAppById(long id) {
        return appDao.getAppById(id);
    }
}
