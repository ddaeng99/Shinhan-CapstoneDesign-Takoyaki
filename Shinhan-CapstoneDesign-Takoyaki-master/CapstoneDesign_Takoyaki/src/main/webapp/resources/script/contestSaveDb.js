function contestClick(id, contid, sql_comtitle, sql_comlocation, sql_comdate, sql_comhref) {
	var xhr = new XMLHttpRequest();
	var url = url;
	var params = {
		id: id,
		contid: contid,
		sql_comtitle: sql_comtitle,
		sql_comlocation: sql_comlocation,
		sql_comdate: sql_comdate,
		sql_comhref: sql_comhref
	};
	var paramsStr = JSON.stringify(params);
	 xhr.open("GET", "saveContest.jsp?paramsStr=" + encodeURIComponent(paramsStr), true);
    xhr.send();
	console.log(paramsStr);
	// 클라이언트를 다른 URL로 리디렉션
	window.location.href = "contDetail.jsp?contid=" + contid;
}