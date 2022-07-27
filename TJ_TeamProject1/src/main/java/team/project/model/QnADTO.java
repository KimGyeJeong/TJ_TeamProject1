package team.project.model;

import java.sql.Timestamp;

public class QnADTO {

	private int q_no;
	private String q_title;
	private String q_questionContent;
	private String q_answerContent;
	private Timestamp q_reg;

	public int getQ_no() {
		return q_no;
	}

	public void setQ_no(int q_no) {
		this.q_no = q_no;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public String getQ_questionContent() {
		return q_questionContent;
	}

	public void setQ_questionContent(String q_questionContent) {
		this.q_questionContent = q_questionContent;
	}

	public String getQ_answerContent() {
		return q_answerContent;
	}

	public void setQ_answerContent(String q_answerContent) {
		this.q_answerContent = q_answerContent;
	}

	public Timestamp getQ_reg() {
		return q_reg;
	}

	public void setQ_reg(Timestamp q_reg) {
		this.q_reg = q_reg;

	}

}
