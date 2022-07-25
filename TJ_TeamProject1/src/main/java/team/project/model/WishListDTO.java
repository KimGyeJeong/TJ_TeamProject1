package team.project.model;

import java.sql.Timestamp;

public class WishListDTO {
	
	String user_id;
    int p_no;
    Timestamp w_reg;
    
    
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public Timestamp getW_reg() {
		return w_reg;
	}
	public void setW_reg(Timestamp w_reg) {
		this.w_reg = w_reg;
	}
	
    
}
