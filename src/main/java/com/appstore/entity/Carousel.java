package com.appstore.entity;

public class Carousel {
    private Long id;

    private Long appId;

    private String picName;

    private String picPath;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getAppId() {
        return appId;
    }

    public void setAppId(Long appid) {
        this.appId = appid;
    }

    public String getPicName() {
        return picName;
    }

    public void setPicName(String picname) {
        this.picName = picname == null ? null : picname.trim();
    }

    public String getPicPath() {
        return picPath;
    }

    public void setPicPath(String picpath) {
        this.picPath = picpath == null ? null : picpath.trim();
    }
}