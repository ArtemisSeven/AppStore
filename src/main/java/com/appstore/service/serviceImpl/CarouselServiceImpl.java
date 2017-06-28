package com.appstore.service.serviceImpl;

import com.appstore.dao.CarouselDao;
import com.appstore.entity.Carousel;
import com.appstore.service.CarouselService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CarouselServiceImpl implements CarouselService {
    @Autowired
    CarouselDao carouselDao;
    public List<Carousel> getCarouselLimit(int offset, int limit) {
        return carouselDao.getCarouselLimit(offset,limit);
    }

    public List<Carousel> getAllCarousel() {
        return carouselDao.getAllCarousel();
    }

    public Long save(Carousel carousel) {
        return carouselDao.save(carousel);
    }

    public boolean deleteById(long id) {
        if (carouselDao.deleteById(id)>0) return true;
        else return false;
    }

    public boolean deleteByAppId(long appId) {
        if (carouselDao.deleteByAppId(appId)>0) return true;
        else return false;
    }

    public boolean update(long carouselId, String picPath, String picName) {
        if (carouselDao.update(carouselId,picPath,picName)>0) return true;
        else return false;
    }
}
