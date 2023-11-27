package mainDB;

public class Competition {
	private String title;
    private String location;
    private String date;
    private String href;
    private int contid;
    
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getHref() {
		return href;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public int getContid() {
		return contid;
	}
	public void setContid(int contid) {
		this.contid = contid;
	}
}
