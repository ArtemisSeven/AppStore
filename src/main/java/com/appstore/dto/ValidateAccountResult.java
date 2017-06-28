package com.appstore.dto;

public class ValidateAccountResult {
    private boolean phoneState;
    private boolean pswState;


    public ValidateAccountResult() {
    }

    public ValidateAccountResult(boolean phoneState, boolean pswState) {
        this.phoneState = phoneState;
        this.pswState = pswState;
    }

    public boolean isPhoneState() {
        return phoneState;
    }

    public void setPhoneState(boolean phoneState) {
        this.phoneState = phoneState;
    }

    public boolean isPswState() {
        return pswState;
    }

    public void setPswState(boolean pswState) {
        this.pswState = pswState;
    }
}
