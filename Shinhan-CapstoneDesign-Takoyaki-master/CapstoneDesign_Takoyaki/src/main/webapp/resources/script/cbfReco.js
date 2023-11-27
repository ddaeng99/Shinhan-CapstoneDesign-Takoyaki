function setCategory(category) {
	// 히든 필드에 선택한 카테고리 값을 설정합니다.
	document.getElementById('categoryHiddenInput').value = category;
	console.log(category);

	var categoryLinks = document.querySelectorAll('.jobCategory a');
	categoryLinks.forEach(function(link) {
		link.style.color = '#666'; // 기본 색상으로 초기화
	});

	// 클릭한 카테고리의 링크의 색상을 변경
	var clickedLink = document.getElementById(category);
	if (clickedLink) {
		clickedLink.style.color = '#f59a12'; // 원하는 색상으로 변경
	}
}

function setRecoCategory(recoCategory) {
	document.getElementById('categoryHiddenInputReco').value = recoCategory;
	// 폼을 서버로 제출합니다.
	document.getElementById('searchForm').submit();
	console.log(recoCategory);
	
	var categoryLinks = document.querySelectorAll('.recoCategory a');
	categoryLinks.forEach(function(link) {
		link.style.color = '#666'; // 기본 색상으로 초기화
	});
	
	// 클릭한 카테고리의 링크의 색상을 변경
	var clickedLink = document.getElementById(recoCategory);
	if (clickedLink) {
		clickedLink.style.color = '#f59a12'; // 원하는 색상으로 변경
	}
}