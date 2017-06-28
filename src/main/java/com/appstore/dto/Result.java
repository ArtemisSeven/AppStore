package com.appstore.dto;

import com.appstore.entity.Type;

public class Result {
    boolean state;
    Type type;

    public Result() {
    }
    public Result(boolean state) {
        this.state = state;
    }
    public Result(boolean state, Type type) {
        this.state = state;
        this.type = type;
    }

    public boolean isState() {
        return state;
    }

    public void setState(boolean state) {
        this.state = state;
    }

    public Type getType() {
        return type;
    }

    public void setType(Type type) {
        this.type = type;
    }
}
