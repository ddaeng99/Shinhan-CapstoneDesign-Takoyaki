package user;

public class UserDTO {
	private String id;
	private String pw;
	private String email;
	private String email1;
	private String email2;
	private String year;
	private String month;
	private String day;
	private String birth;
	private String mobile;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getEmail() {
	    // email1과 email2가 NULL인지 확인하여 NULL이 아닌 경우에만 합친 값을 반환
	    if (email1 != null && email2 != null) {
	    	email = email1 + "@" + email2;
	        return email;
	    } else {
	        return null; // email1 또는 email2 중 하나라도 NULL이면 NULL을 반환하거나 다른 처리를 수행할 수 있다.
	    }
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getBirth() {
		if (year != null && month != null && day != null) {
	    	birth = year + month + day;
	    	return birth;
	    } else {
	        return null; // email1 또는 email2 중 하나라도 null이면 null을 반환하거나 다른 처리를 수행할 수 있습니다.
	    }
	}
	public void setBirth(String birth) {
		this.birth = birth;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	
}