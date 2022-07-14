package team.project.model;

import java.sql.Timestamp;

public class UserQuestionDTO {
	private int uq_no; 
	private int p_no ;
	private String user_id; 
	private String uq_title; 
	private String uq_content; 
	private String uq_cat; 
	private String uq_img1; 
	private String uq_img2; 
	private String uq_img3; 
	private Timestamp uq_reg;
	private String uqa_content;
	private Timestamp uqa_reg;
	
    
    public int getUq_no() {
		return uq_no;
	}
	public void setUq_no(int uq_no) {
		this.uq_no = uq_no;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUq_title() {
		return uq_title;
	}
	public void setUq_title(String uq_title) {
		this.uq_title = uq_title;
	}
	public String getUq_content() {
		return uq_content;
	}
	public void setUq_content(String uq_content) {
		this.uq_content = uq_content;
	}
	public String getUq_cat() {
		return uq_cat;
	}
	public void setUq_cat(String uq_cat) {
		this.uq_cat = uq_cat;
	}
	public String getUq_img1() {
		return uq_img1;
	}
	public void setUq_img1(String uq_img1) {
		this.uq_img1 = uq_img1;
	}
	public String getUq_img2() {
		return uq_img2;
	}
	public void setUq_img2(String uq_img2) {
		this.uq_img2 = uq_img2;
	}
	public String getUq_img3() {
		return uq_img3;
	}
	public void setUq_img3(String uq_img3) {
		this.uq_img3 = uq_img3;
	}
	public Timestamp getUq_reg() {
		return uq_reg;
	}
	public void setUq_reg(Timestamp uq_reg) {
		this.uq_reg = uq_reg;
	}
	public String getUqa_content() {
		return uqa_content;
	}
	public void setUqa_content(String uqa_content) {
		this.uqa_content = uqa_content;
	}
	public Timestamp getUqa_reg() {
		return uqa_reg;
	}
	public void setUqa_reg(Timestamp uqa_reg) {
		this.uqa_reg = uqa_reg;
	}
	
}
