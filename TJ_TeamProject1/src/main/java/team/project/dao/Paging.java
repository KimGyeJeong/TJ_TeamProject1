package team.project.dao;
public class Paging{
	
	public Paging(){
		
	}
	
	public Paging(int totalData,int pageSize , int dataLimit , String page){
		this.totalData = totalData;
		this.pageSize = pageSize;
		this.dataLimit = dataLimit;
		this.page = page;
		this.pageN = Integer.parseInt(page);
		this.totalPage = totalData/dataLimit;
		this.dataNumber[0] = (this.pageN*dataLimit)-(dataLimit-1);
		this.dataNumber[1] = this.pageN*dataLimit;
		this.isfirst = (((pageN-1)/pageSize)*pageSize)+1;
		this.islast = (this.isfirst+pageSize)-1;
	}
	private int pageSize;
	private String page;
	private int asc = +1;
	private int desc = -1;
	private int totalData;
	private int totalPage;
	private int isfirst;
	private int islast;
	private int dataLimit;
	private int[] dataNumber = new int [2];
	private int pageN;
	
	
	
	public void setPaging(int totalData,int pageSize , int dataLimit , String page) {
		this.totalData = totalData;
		this.pageSize = pageSize;
		this.dataLimit = dataLimit;
		this.page = page;
		this.pageN = Integer.parseInt(page);
		this.totalPage = totalData/dataLimit;
		this.dataNumber[0] = (this.pageN*dataLimit)-(dataLimit-1);
		this.dataNumber[1] = this.pageN*dataLimit;
		this.isfirst = (((pageN-1)/pageSize)*pageSize)+1;
		this.islast = (this.isfirst+pageSize)-1;
	}
	public void setPaging(int totalData,int pageSize , int dataLimit , int pageN) {
		this.totalData = totalData;
		this.pageSize = pageSize;
		this.dataLimit = dataLimit;
		this.page = ""+pageN;
		this.totalPage = totalData/dataLimit;
		this.dataNumber[0] = (pageN*dataLimit)-(dataLimit-1);
		this.dataNumber[1] = pageN*dataLimit;
		this.isfirst = (((pageN-1)/pageSize)*pageSize)+1;
		this.islast = (this.isfirst+pageSize)-1;
	}
	
	
	
	
	
	public int getPageSize() {
		return pageSize;
	}
	public String getPage() {
		return page;
	}
	public int getAsc() {
		return asc;
	}
	public int getDesc() {
		return desc;
	}
	public int getTotalData() {
		return totalData;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getIslast() {
		return islast;
	}
	public int getIsfirst() {
		return isfirst;
	}
	public int getDataLimit() {
		return dataLimit;
	}
	public int getDataNumberStart() {
		return dataNumber[0];
	}
	public int getDataNumberEnd() {
		return dataNumber[1];
	}
	
	
	
	
	
}