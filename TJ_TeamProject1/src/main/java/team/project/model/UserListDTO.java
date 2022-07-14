package team.project.model;

import java.sql.Timestamp;

public class UserListDTO {
	private String user_id;
	private String user_pw;
	private String user_email;
	private String user_name;
	private String user_phone;
	private int user_money;
	private int user_usemoney;
	private int user_stars;
	private String user_img;
	private Timestamp user_reg;
	private int user_delete;
	private Timestamp user_deleteReg;
	private Timestamp user_activeReg;
	private int user_report;
	private int user_reportCnt;
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_phone() {
		return user_phone;
	}
	public void setUser_phone(String user_phone) {
		this.user_phone = user_phone;
	}
	public int getUser_money() {
		return user_money;
	}
	public void setUser_money(int user_money) {
		this.user_money = user_money;
	}
	public int getUser_usemoney() {
		return user_usemoney;
	}
	public void setUser_usemoney(int user_usemoney) {
		this.user_usemoney = user_usemoney;
	}
	public int getUser_stars() {
		return user_stars;
	}
	public void setUser_stars(int user_stars) {
		this.user_stars = user_stars;
	}
	public String getUser_img() {
		return user_img;
	}
	public void setUser_img(String user_img) {
		this.user_img = user_img;
	}
	public Timestamp getUser_reg() {
		return user_reg;
	}
	public void setUser_reg(Timestamp user_reg) {
		this.user_reg = user_reg;
	}
	public int getUser_delete() {
		return user_delete;
	}
	public void setUser_delete(int user_delete) {
		this.user_delete = user_delete;
	}
	public Timestamp getUser_deleteReg() {
		return user_deleteReg;
	}
	public void setUser_deleteReg(Timestamp user_deleteReg) {
		this.user_deleteReg = user_deleteReg;
	}
	public Timestamp getUser_activeReg() {
		return user_activeReg;
	}
	public void setUser_activeReg(Timestamp user_activeReg) {
		this.user_activeReg = user_activeReg;
	}
	public int getUser_report() {
		return user_report;
	}
	public void setUser_report(int user_report) {
		this.user_report = user_report;
	}
	public int getUser_reportCnt() {
		return user_reportCnt;
	}
	public void setUser_reportCnt(int user_reportCnt) {
		this.user_reportCnt = user_reportCnt;
	}
}
