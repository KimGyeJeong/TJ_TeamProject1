package team.project.model;

import java.sql.Timestamp;

public class OrderListDTO {

	private int o_no;
	private int p_no;
	private int p_status; 
	private int a_no;
	private String o_sellerId;
	private String o_buyerId; 
	private int o_pro;
	private Timestamp o_reg; 
	private String o_fedexName;
	private int o_trackingNo;
	private int o_review;
	
	
	public String getO_fedexName() {
		return o_fedexName;
	}
	public void setO_fedexName(String o_fedexName) {
		this.o_fedexName = o_fedexName;
	}
	public int getO_no() {
		return o_no;
	}
	public void setO_no(int o_no) {
		this.o_no = o_no;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public int getP_status() {
		return p_status;
	}
	public void setP_status(int p_status) {
		this.p_status = p_status;
	}
	public int getA_no() {
		return a_no;
	}
	public void setA_no(int a_no) {
		this.a_no = a_no;
	}
	public String getO_sellerId() {
		return o_sellerId;
	}
	public void setO_sellerId(String o_sellerId) {
		this.o_sellerId = o_sellerId;
	}
	public String getO_buyerId() {
		return o_buyerId;
	}
	public void setO_buyerId(String o_buyerId) {
		this.o_buyerId = o_buyerId;
	}
	public int getO_pro() {
		return o_pro;
	}
	public void setO_pro(int o_pro) {
		this.o_pro = o_pro;
	}
	public Timestamp getO_reg() {
		return o_reg;
	}
	public void setO_reg(Timestamp o_reg) {
		this.o_reg = o_reg;
	}
	public int getO_trackingNo() {
		return o_trackingNo;
	}
	public void setO_trackingNo(int o_trackingNo) {
		this.o_trackingNo = o_trackingNo;
	}
	public int getO_review() {
		return o_review;
	}
	public void setO_review(int o_review) {
		this.o_review = o_review;
	}
	
}
