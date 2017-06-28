package com.appstore.dao;


import com.appstore.entity.Carousel;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CarouselDao {
    List<Carousel> getCarouselLimit(@Param("offset") int offset, @Param("limit") int limit);
    List<Carousel> getAllCarousel();
    Long save(Carousel carousel);
    int deleteById(long id);
    int deleteByAppId(long appId);
    int update(@Param("carouselId") long carouselId,@Param("picPath")String picPath,@Param("picName")String picName);

}