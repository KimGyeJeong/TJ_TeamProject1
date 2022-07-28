package team.project.model;

import java.sql.Timestamp;

public class ProductQuestionDTO {
	private int pq_no;
	private int p_no;
	private String pq_title;
	private String pq_content;
	private String user_id;
	private Timestamp pq_writeReg;
	private String pq_answer;
	private Timestamp pq_answerReg;
	private int pq_delete;
	private int pq_secret;
	
	public int getPq_secret() {
		return pq_secret;
	}
	public void setPq_secret(int pq_secret) {
		this.pq_secret = pq_secret;
	}
	public int getPq_no() {
		return pq_no;
	}
	public void setPq_no(int pq_no) {
		this.pq_no = pq_no;
	}
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	public String getPq_title() {
		return pq_title;
	}
	public void setPq_title(String pq_title) {
		this.pq_title = pq_title;
	}
	public String getPq_content() {
		return pq_content;
	}
	public void setPq_content(String pq_content) {
		this.pq_content = pq_content;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public Timestamp getPq_writeReg() {
		return pq_writeReg;
	}
	public void setPq_writeReg(Timestamp pq_writeReq) {
		this.pq_writeReg = pq_writeReq;
	}
	public String getPq_answer() {
		return pq_answer;
	}
	public void setPq_answer(String pq_answer) {
		this.pq_answer = pq_answer;
	}
	public Timestamp getPq_answerReg() {
		return pq_answerReg;
	}
	public void setPq_answerReg(Timestamp pq_answerReg) {
		this.pq_answerReg = pq_answerReg;
	}
	public int getPq_delete() {
		return pq_delete;
	}
	public void setPq_delete(int pq_delete) {
		this.pq_delete = pq_delete;
	}
	
	
}
