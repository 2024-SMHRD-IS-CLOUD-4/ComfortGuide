document.getElementById('file-upload').addEventListener('change', function() {
	const file = this.files[0];
	const fileNameDisplay = document.getElementById('file-name');
	const contentTextarea = document.getElementById('content');

	fileNameDisplay.value = file ? file.name : "선택된 파일 없음";

	if (file) {
		Tesseract.recognize(file, 'kor', { logger: m => console.log(m) })
			.then(({ data: { text } }) => {
				const cleanedText = text
					.split('\n')
					.map(line => line.trim())
					.map(line => line.replace(/\s+/g, ' '))
					.join('\n');

				contentTextarea.value = cleanedText;
			})
			.catch(error => {
				console.error("OCR 오류:", error);
				contentTextarea.value = "텍스트를 추출할 수 없습니다.";
			});
	}
});