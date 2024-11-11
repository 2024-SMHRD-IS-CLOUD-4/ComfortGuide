document.getElementById('file-upload').addEventListener('change', function() {
	const file = this.files[0];
	const fileNameDisplay = document.getElementById('file-name');
	const contentTextarea = document.getElementById('content');

	fileNameDisplay.value = file ? file.name : "선택된 파일 없음";

	if (file) {
		Tesseract.recognize(file, 'kor', { logger: m => console.log(m) })
			.then(({ data: { text } }) => {
				let cleanedText = text
					.split('\n')
					.map(line => line.trim())  // 줄 양쪽의 공백 제거
					.filter(line => line.length > 0)  // 빈 줄 제거
					.map(line => 
						line
							.replace(/([가-힣])\s(?=[가-힣])/g, '$1')  // 한글 사이의 불필요한 공백 제거
							.replace(/([.,!?])(?=\S)/g, '$1 ')        // 특정 문자 뒤 공백 추가
							.replace(/([은는이가을를와과에도만으로부터까지에서께데면것])(?=[가-힣])(?!\s?[은는이가을를와과에도만으로부터까지에서께데면])/g, '$1 ')  // 연속 조사가 없을 때 공백 추가
					)
					.join('\n');

				// 추가 후처리: 중복 공백 제거 및 문장부호가 연속된 경우 정리
				cleanedText = cleanedText
					.replace(/\s+/g, ' ')               // 여러 개의 공백을 하나로 축소
					.replace(/([.!?])\s*\1+/g, '$1')    // 중복된 문장 부호 제거
					.replace(/ \./g, '.').replace(/ ,/g, ','); // 마침표와 쉼표 앞 공백 제거

				contentTextarea.value = cleanedText;
			})
			.catch(error => {
				console.error("OCR 오류:", error);
				contentTextarea.value = "텍스트를 추출할 수 없습니다.";
			});
	}
});
