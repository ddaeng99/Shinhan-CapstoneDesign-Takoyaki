function jobInfoClick(id, wantedAuthNo, title, sal, location, url) {
   var xhr = new XMLHttpRequest();
   var url = url;
   var params = {
      id: id,
      wantedAuthNo: wantedAuthNo,
      title: title,
      sal: sal,
      location: location
   };
   var paramsStr = JSON.stringify(params);
    xhr.open("GET", "saveJobInfo.jsp?paramsStr=" + encodeURIComponent(paramsStr), true);
    xhr.send();
   console.log(paramsStr);
   // 클라이언트를 다른 URL로 리디렉션
   window.location.href = "Detail.jsp?wantedAuthNo=" + wantedAuthNo;
}