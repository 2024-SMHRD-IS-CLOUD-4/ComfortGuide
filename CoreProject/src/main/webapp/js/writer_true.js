
function validateForm() {
	const title = document.getElementById('title').value.trim();
	const region = document.getElementById('region').value;
	const restStop = document.getElementById('restStop').value;
	const content = document.getElementById('content').value.trim();
	const author = document.getElementById('author').value.trim();

	// 필드 검증
	if (title === "" || region === "" || restStop === "" || content === "" || author === "") {
		alert("모든 필드를 입력해주세요.");
		return false; // 제출하지 않음
	}
	return true; // 제출 허용
}
