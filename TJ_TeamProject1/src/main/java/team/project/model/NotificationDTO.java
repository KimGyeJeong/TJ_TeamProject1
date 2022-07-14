package team.project.model;

import java.sql.Timestamp;

public class NotificationDTO {
	private int not_no;
	private String user_id;
	private String not_type;
	private String not_message;
	private Timestamp not_reg;
	private Timestamp not_readReg;
	public int getNot_no() {
		return not_no;
	}
	public void setNot_no(int not_no) {
		this.not_no = not_no;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getNot_type() {
		return not_type;
	}
	public void setNot_type(String not_type) {
		this.not_type = not_type;
	}
	public String getNot_message() {
		return not_message;
	}
	public void setNot_message(String not_message) {
		this.not_message = not_message;
	}
	public Timestamp getNot_reg() {
		return not_reg;
	}
	public void setNot_reg(Timestamp not_reg) {
		this.not_reg = not_reg;
	}
	public Timestamp getNot_readReg() {
		return not_readReg;
	}
	public void setNot_readReg(Timestamp not_readReg) {
		this.not_readReg = not_readReg;
	}
	
	
}
