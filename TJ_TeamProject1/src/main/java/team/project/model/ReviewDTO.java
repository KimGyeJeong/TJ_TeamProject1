package team.project.model;

public class ReviewDTO {
	
	int re_no;
    int re_stars;
    String re_reportUid;
    String re_content;
    int re_delete;
    String re_reportedUid;
    
    
	public int getRe_no() {
		return re_no;
	}
	public void setRe_no(int re_no) {
		this.re_no = re_no;
	}
	public int getRe_stars() {
		return re_stars;
	}
	public void setRe_stars(int re_stars) {
		this.re_stars = re_stars;
	}
	public String getRe_reportUid() {
		return re_reportUid;
	}
	public void setRe_reportUid(String re_reportUid) {
		this.re_reportUid = re_reportUid;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public int getRe_delete() {
		return re_delete;
	}
	public void setRe_delete(int re_delete) {
		this.re_delete = re_delete;
	}
	public String getRe_reportedUid() {
		return re_reportedUid;
	}
	public void setRe_reportedUid(String re_reportedUid) {
		this.re_reportedUid = re_reportedUid;
	}
    
}
