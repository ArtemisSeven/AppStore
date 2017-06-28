package com.appstore.entity;


import java.util.Date;

public class App {

    private Long id;

    private Long typeId;

    private String appName;

    private String company;

    private String os;

    private Long downloadCount;

    private Long ratingCount;

    private Byte avgScore;

    private Double size;

    private String version;

    private Date updateTime;

    private String fileName;

    private String filePath;

    private String description;

    private String state;

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getTypeId() {
        return typeId;
    }

    public void setTypeId(Long typeId) {
        this.typeId = typeId;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName == null ? null : appName.trim();
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company == null ? null : company.trim();
    }

    public String getOs() {
        return os;
    }

    public void setOs(String os) {
        this.os = os == null ? null : os.trim();
    }

    public Long getDownloadCount() {
        return downloadCount;
    }

    public void setDownloadCount(Long downloadCount) {
        this.downloadCount = downloadCount;
    }

    public Long getRatingCount() {
        return ratingCount;
    }

    public void setRatingCount(Long ratingCount) {
        this.ratingCount = ratingCount;
    }

    public Byte getAvgScore() {
        return avgScore;
    }

    public void setAvgScore(Byte avgScore) {
        this.avgScore = avgScore;
    }

    public Double getSize() {
        return size;
    }

    public void setSize(Double size) {
        this.size = size;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version == null ? null : version.trim();
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updatetime) {
        this.updateTime = updatetime;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName == null ? null : fileName.trim();
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath == null ? null : filePath.trim();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description == null ? null : description.trim();
    }

    @Override
    public String toString() {
        return "App{" +
                "id=" + id +
                ", typeId=" + typeId +
                ", appName='" + appName + '\'' +
                ", company='" + company + '\'' +
                ", os='" + os + '\'' +
                ", downloadCount=" + downloadCount +
                ", ratingCount=" + ratingCount +
                ", avgScore=" + avgScore +
                ", size=" + size +
                ", version='" + version + '\'' +
                ", updateTime=" + updateTime +
                ", fileName='" + fileName + '\'' +
                ", filePath='" + filePath + '\'' +
                ", description='" + description + '\'' +
                ", state='" + state + '\'' +
                '}';
    }
    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        final App other = (App) obj;
        if(this.getId()!=other.getId())
            return false;
        return true;
    }
}