function jobDelete(id, wantedAuthNo) {
	var xhr = new XMLHttpRequest();
	var url = url;
	var params = {
		id: id,
		wantedAuthNo: wantedAuthNo
	};
	var paramsStr = JSON.stringify(params);
	 xhr.open("GET", "delJobBookmark.jsp?paramsStr=" + encodeURIComponent(paramsStr), true);
    xhr.send();
	console.log(paramsStr);
	// 클라이언트를 다른 URL로 리디렉션
	window.location.href = "http://localhost:8080/Takoyaki/user/myPage.jsp";
	
}