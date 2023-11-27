function extClick(id, extid, sql_extitle, sql_exlocation, sql_exdate, sql_exhref) {
	var xhr = new XMLHttpRequest();
	var url = url;
	var params = {
		id: id,
		extid: extid,
		sql_extitle: sql_extitle,
		sql_exlocation: sql_exlocation,
		sql_exdate: sql_exdate,
		sql_exhref: sql_exhref
	};
	var paramsStr = JSON.stringify(params);
	 xhr.open("GET", "saveExt.jsp?paramsStr=" + encodeURIComponent(paramsStr), true);
    xhr.send();
	console.log(paramsStr);
	// 클라이언트를 다른 URL로 리디렉션
	window.location.href = "extDetail.jsp?extid=" + extid;
}