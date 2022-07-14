package team.project.model;

import java.sql.Timestamp;

public class NoticeDTO {
	private int no_no; 
	private String no_title; 
	private String no_content; 
	private String no_cat; 
	private int no_hidden; 
	private Timestamp no_reg;
	public int getNo_no() {
		return no_no;
	}
	public void setNo_no(int no_no) {
		this.no_no = no_no;
	}
	public String getNo_title() {
		return no_title;
	}
	public void setNo_title(String no_title) {
		this.no_title = no_title;
	}
	public String getNo_content() {
		return no_content;
	}
	public void setNo_content(String no_content) {
		this.no_content = no_content;
	}
	public String getNo_cat() {
		return no_cat;
	}
	public void setNo_cat(String no_cat) {
		this.no_cat = no_cat;
	}
	public int getNo_hidden() {
		return no_hidden;
	}
	public void setNo_hidden(int no_hidden) {
		this.no_hidden = no_hidden;
	}
	public Timestamp getNo_reg() {
		return no_reg;
	}
	public void setNo_reg(Timestamp no_reg) {
		this.no_reg = no_reg;
	}
	
	
}
