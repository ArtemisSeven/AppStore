package com.appstore.entity;

public class Picture {
    private Long id;

    private Long appId;

    private String picName;

    private String picPath;

    private String module;

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

    public String getModule() {
        return module;
    }

    public void setModule(String module) {
        this.module = module == null ? null : module.trim();
    }
}