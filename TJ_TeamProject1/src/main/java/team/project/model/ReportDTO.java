package team.project.model;

import java.sql.Timestamp;

public class ReportDTO {
	private int rp_no;	
	private String rp_reason;
	private String rp_title;	
	private String rp_content;	
	private String rp_reportUid;	
	private String rp_reportedUid;	
	private int rp_pro;	
	private int p_no;	 
	private Timestamp rp_reg;
	public int getRp_no() {
		return rp_no;
	}
	public void setRp_no(int rp_no) {
		this.rp_no = rp_no;
	}
	public String getRp_reason() {
		return rp_reason;
	}
	public void setRp_reason(String rp_reason) {
		this.rp_reason = rp_reason;
	}
	public String getRp_title() {
		return rp_title;
	}
	public void setRp_title(String rp_title) {
		this.rp_title = rp_title;
	}
	public String getRp_content() {
		return rp_content;
	}
	public void setRp_content(String rp_content) {
		this.rp_content = rp_content;
	}
	public String getRp_reportUid() {
		return rp_reportUid;
	}
	public void setRp_reportUid(String rp_reportUid) {
		this.rp_reportUid = rp_reportUid;
	}
	public String getRp_reportedUid() {
		return rp_reportedUid;
	}
	public void setRp_reportedUid(String rp_reportedUid) {
		this.rp_reportedUid = rp_reportedUid;
	}
	public int getRp_pro() {
		return rp_pro;
	}
	public void setRp_pro(int rp_pro) {
		this.rp_pro = rp_pro;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public Timestamp getRp_reg() {
		return rp_reg;
	}
	public void setRp_reg(Timestamp rp_reg) {
		this.rp_reg = rp_reg;
	}
	
	
}
