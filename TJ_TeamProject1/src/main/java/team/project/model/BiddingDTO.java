package team.project.model;

import java.sql.Timestamp;

public class BiddingDTO {
	private int b_no;
	private int p_no;
	private int b_bidding;
	private String user_id;
	private Timestamp b_reg;
	private int b_status;
	public int getB_no() {
		return b_no;
	}
	public void setB_no(int b_no) {
		this.b_no = b_no;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public int getB_bidding() {
		return b_bidding;
	}
	public void setB_bidding(int b_bidding) {
		this.b_bidding = b_bidding;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Timestamp getB_reg() {
		return b_reg;
	}
	public void setB_reg(Timestamp b_reg) {
		this.b_reg = b_reg;
	}
	public int getB_status() {
		return b_status;
	}
	public void setB_status(int b_status) {
		this.b_status = b_status;
	}
	
	
}
