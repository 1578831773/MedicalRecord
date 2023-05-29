package com.example.medicalrecord.enums;

public enum StatusCode {
    Success(0, "成功"),
    ParamsMissing(-1, "缺少参数"),
    ParamsInvalid(-2, "非法参数")

    ;
    StatusCode() {
    }

    StatusCode(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }

    private Integer code;
    private String msg;

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
