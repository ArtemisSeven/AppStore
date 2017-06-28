package com.appstore.entity;

import java.util.Date;

public class Comment {
    private Long id;

    private Long appId;

    private String version;

    private Long userId;

    private Byte score;

    private Date commentTime;

    private String content;

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

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version == null ? null : version.trim();
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userid) {
        this.userId = userid;
    }

    public Byte getScore() {
        return score;
    }

    public void setScore(Byte score) {
        this.score = score;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", appId=" + appId +
                ", version='" + version + '\'' +
                ", userId=" + userId +
                ", score=" + score +
                ", commentTime=" + commentTime +
                ", content='" + content + '\'' +
                '}';
    }
}