package team.project.model;

import java.sql.Timestamp;

public class ReplyDTO {
	private String user_id; 
	private int c_no; 
	public int getC_no() {
		return c_no;
	}
	public void setC_no(int c_no) {
		this.c_no = c_no;
	}
	private int r_no; 
	private String r_reply; 
	private Timestamp r_reg; 
	private int r_grp;
	private int r_level;
	private int r_step;
    
    
    public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	
	public int getR_no() {
		return r_no;
	}
	public void setR_no(int r_no) {
		this.r_no = r_no;
	}
	public String getR_reply() {
		return r_reply;
	}
	public void setR_reply(String r_reply) {
		this.r_reply = r_reply;
	}
	public Timestamp getR_reg() {
		return r_reg;
	}
	public void setR_reg(Timestamp r_reg) {
		this.r_reg = r_reg;
	}
	public int getR_grp() {
		return r_grp;
	}
	public void setR_grp(int r_grp) {
		this.r_grp = r_grp;
	}
	public int getR_level() {
		return r_level;
	}
	public void setR_level(int r_level) {
		this.r_level = r_level;
	}
	public int getR_step() {
		return r_step;
	}
	public void setR_step(int r_step) {
		this.r_step = r_step;
	}
    
}
