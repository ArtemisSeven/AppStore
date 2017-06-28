package com.appstore.entity;

public class Type {
    private Long id;

    private String typeName;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typename) {
        this.typeName = typename == null ? null : typename.trim();
    }
}