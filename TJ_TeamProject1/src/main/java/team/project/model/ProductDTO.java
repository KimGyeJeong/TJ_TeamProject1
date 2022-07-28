package team.project.model;

import java.sql.Timestamp;

public class ProductDTO {
	private int p_no;
	private int p_status;
	private String p_title;
	private int p_price;
	private int p_maxPrice;
	private int p_minPrice;
	private int ca_no;
	private String p_img1;
	private String p_img2;
	private String p_img3;
	private String p_img4;
	private String p_content;
	private int p_finish;
	private Timestamp p_reg;
	private int p_readCount;
	private int p_delete;
	private String p_sellerId;
	private String p_buyerId;
	private Timestamp p_start;
	private Timestamp p_end;
	private Timestamp p_tempReg;
	
	public Timestamp getP_tempReg() {
		return p_tempReg;
	}
	public void setP_tempReg(Timestamp p_tempReg) {
		this.p_tempReg = p_tempReg;
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
	public String getP_title() {
		return p_title;
	}
	public void setP_title(String p_title) {
		this.p_title = p_title;
	}
	public int getP_price() {
		return p_price;
	}
	public void setP_price(int p_price) {
		this.p_price = p_price;
	}
	public int getP_maxPrice() {
		return p_maxPrice;
	}
	public void setP_maxPrice(int p_maxPrice) {
		this.p_maxPrice = p_maxPrice;
	}
	public int getP_minPrice() {
		return p_minPrice;
	}
	public void setP_minPrice(int p_minPrice) {
		this.p_minPrice = p_minPrice;
	}
	public int getCa_no() {
		return ca_no;
	}
	public void setCa_no(int ca_no) {
		this.ca_no = ca_no;
	}
	public String getP_img1() {
		return p_img1;
	}
	public void setP_img1(String p_img1) {
		this.p_img1 = p_img1;
	}
	public String getP_img2() {
		return p_img2;
	}
	public void setP_img2(String p_img2) {
		this.p_img2 = p_img2;
	}
	public String getP_img3() {
		return p_img3;
	}
	public void setP_img3(String p_img3) {
		this.p_img3 = p_img3;
	}
	public String getP_img4() {
		return p_img4;
	}
	public void setP_img4(String p_img4) {
		this.p_img4 = p_img4;
	}
	public String getP_content() {
		return p_content;
	}
	public void setP_content(String p_content) {
		this.p_content = p_content;
	}
	public int getP_finish() {
		return p_finish;
	}
	public void setP_finish(int p_finish) {
		this.p_finish = p_finish;
	}
	public Timestamp getP_reg() {
		return p_reg;
	}
	public void setP_reg(Timestamp p_reg) {
		this.p_reg = p_reg;
	}
	public int getP_readCount() {
		return p_readCount;
	}
	public void setP_readCount(int p_readCount) {
		this.p_readCount = p_readCount;
	}
	public int getP_delete() {
		return p_delete;
	}
	public void setP_delete(int p_delete) {
		this.p_delete = p_delete;
	}
	public String getP_sellerId() {
		return p_sellerId;
	}
	public void setP_sellerId(String p_sellerId) {
		this.p_sellerId = p_sellerId;
	}
	public String getP_buyerId() {
		return p_buyerId;
	}
	public void setP_buyerId(String p_buyerId) {
		this.p_buyerId = p_buyerId;
	}
	public Timestamp getP_start() {
		return p_start;
	}
	public void setP_start(Timestamp p_start) {
		this.p_start = p_start;
	}
	public Timestamp getP_end() {
		return p_end;
	}
	public void setP_end(Timestamp p_end) {
		this.p_end = p_end;
	}
	
}
