package team.project.model;

import java.sql.Timestamp;

public class AdminDTO {
	private String ad_id;
	private String ad_pw;
	private String ad_name;
	private Timestamp ad_reg;
	public String getAd_id() {
		return ad_id;
	}
	public void setAd_id(String ad_id) {
		this.ad_id = ad_id;
	}
	public String getAd_pw() {
		return ad_pw;
	}
	public void setAd_pw(String ad_pw) {
		this.ad_pw = ad_pw;
	}
	public String getAd_name() {
		return ad_name;
	}
	public void setAd_name(String ad_name) {
		this.ad_name = ad_name;
	}
	public Timestamp getAd_reg() {
		return ad_reg;
	}
	public void setAd_reg(Timestamp ad_reg) {
		this.ad_reg = ad_reg;
	}
	
}
