package team.project.model;

import java.sql.Timestamp;

public class ContentDTO {
	private int c_no;  
	private String c_title; 
	private String ser_id; 
	private String c_content; 
	private Timestamp c_reg; 
	private int c_readcount;
	private String c_img;
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	public String getC_title() {
		return c_title;
	}
	public void setC_title(String c_title) {
		this.c_title = c_title;
	}
	public String getSer_id() {
		return ser_id;
	}
	public void setSer_id(String ser_id) {
		this.ser_id = ser_id;
	}
	public String getC_content() {
		return c_content;
	}
	public void setC_content(String c_content) {
		this.c_content = c_content;
	}
	public Timestamp getC_reg() {
		return c_reg;
	}
	public void setC_reg(Timestamp c_reg) {
		this.c_reg = c_reg;
	}
	public int getC_readcount() {
		return c_readcount;
	}
	public void setC_readcount(int c_readcount) {
		this.c_readcount = c_readcount;
	}
	public String getC_img() {
		return c_img;
	}
	public void setC_img(String c_img) {
		this.c_img = c_img;
	}
	
	
}
