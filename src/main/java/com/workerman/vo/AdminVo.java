package com.workerman.vo;

import java.io.Serializable;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AdminVo implements Serializable{


    private static final long serialVersionUID = 1L;

    protected String admin_no;
    protected String admin_group_no;
    protected String company_no;
    protected String admin_id;
    protected String password;
    protected String disp_ord;
    protected String admin_name;
    protected String b2c_yn;
    protected String tablet_hp;
    protected String admin_type;
    protected String profile_url;
    protected String department_cd;
    protected String position_cd;
    protected String mobile;
    protected String stat;
    protected String level_cd;
    protected String web_push_token;
    protected String team_yn;
    protected String master_w_yn;
    protected String main_type;
    protected String create_date;
    protected String update_date;
    protected String password_init_yn;
    protected String password_modify_date;
    protected String login_fail_cnt;
    protected String lock_yn;

}
