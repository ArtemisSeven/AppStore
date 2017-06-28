package com.appstore.service;

import com.appstore.entity.Carousel;

import java.util.List;


public interface CarouselService {
    List<Carousel> getCarouselLimit(int offset,int limit);
    List<Carousel> getAllCarousel();
    Long save(Carousel carousel);
    boolean deleteById(long id);
    boolean deleteByAppId(long appId);
    boolean update(long carouselId,String picPath,String picName);
}
