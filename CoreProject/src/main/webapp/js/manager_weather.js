$(document).ready(function() {
	const apiKey = 'jCDTuMMv%2F5m%2B%2FeN3UltXzWg%2FJV9nTtpP5JR%2F8tAqJ8KASXfEevwJGb3iAiEgNrYh6FOIf%2Fnrygm5jBe%2BkpR0fg%3D%3D';

	// 로그인된 사용자의 휴게소 이름(saName)을 사용하여 `lat`과 `lon`을 가져옴
	$.ajax({
		url: 'getWeather',
		type: 'GET',
		success: function(data) {
			const lat = Math.floor(data.lat);
			const lon = Math.floor(data.lon);
			fetchWeatherData(lat, lon); // 날씨 API 호출
		},
		error: function(error) {
			console.error("Service Area 데이터 로드 실패:", error);
		}
	});

	// 날씨 및 감기 가능 지수를 가져오는 함수
	function fetchWeatherData(lat, lon) {
		const today = new Date();
		const formatDate = (date) => date.toISOString().slice(0, 10).replace(/-/g, '');
		const dates = [new Date(), new Date(today.setDate(today.getDate() + 1)), new Date(today.setDate(today.getDate() + 1))].map(formatDate);

		const baseTime = '0500';
		const pageNo = 1;
		const numOfRows = 100;

		dates.forEach((baseDate) => {
			const url = `http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=${apiKey}&pageNo=${pageNo}&numOfRows=${numOfRows}&dataType=JSON&base_date=${baseDate}&base_time=${baseTime}&nx=${lat}&ny=${lon}`;

			fetch(url)
				.then(response => response.json())
				.then(data => {
					if (data.response && data.response.body && data.response.body.items) {
						const items = data.response.body.items.item;

						const temperatureItem = items.find(item => item.category === 'TMP');
						const humidityItem = items.find(item => item.category === 'REH');
						const windItem = items.find(item => item.category === 'WSD');
						const precipitationProbabilityItem = items.find(item => item.category === 'POP');

						const temperature = temperatureItem ? temperatureItem.fcstValue : 'N/A';
						const humidity = humidityItem ? humidityItem.fcstValue : 'N/A';
						const wind = windItem ? windItem.fcstValue : 'N/A';
						const precipitationProbability = precipitationProbabilityItem ? precipitationProbabilityItem.fcstValue : 'N/A';

						// 감기 가능 지수 계산 (tempData 변수는 JSP에서 전달된 값 사용)
						let ColdPossibility = 0;
						if (tempData.includes('경기') || tempData.includes('서울')) {
							ColdPossibility = 0.4 * (Number(temperature)) + 0.3 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 5;
						} else if (tempData.includes('강원')) {
							ColdPossibility = 0.5 * (Number(temperature)) + 0.2 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 10;
						} else if (tempData.includes('충북') || tempData.includes('충청북도')) {
							ColdPossibility = 0.35 * (Number(temperature)) + 0.3 * (Number(humidity)) + 0.25 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 4;
						} else if (tempData.includes('충남') || tempData.includes('충청남도')) {
							ColdPossibility = 0.3 * (Number(temperature)) + 0.35 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.15 * (Number(precipitationProbability)) + 4;
						} else if (tempData.includes('경남') || tempData.includes('경상남도')) {
							ColdPossibility = 0.35 * (Number(temperature)) + 0.3 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.15 * (Number(precipitationProbability)) + 3;
						} else if (tempData.includes('경북') || tempData.includes('경상북도')) {
							ColdPossibility = 0.4 * (Number(temperature)) + 0.25 * (Number(humidity)) + 0.25 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 3;
						} else if (tempData.includes('전북') || tempData.includes('전라북도')) {
							ColdPossibility = 0.3 * (Number(temperature)) + 0.4 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 2;
						} else if (tempData.includes('전남') || tempData.includes('전라남도')) {
							ColdPossibility = 0.3 * (Number(temperature)) + 0.35 * (Number(humidity)) + 0.15 * (Number(wind)) + 0.2 * (Number(precipitationProbability)) + 2;
						} else if (tempData.includes('광주')) {
							ColdPossibility = 0.35 * (Number(temperature)) + 0.35 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 3;
						} else if (tempData.includes('대전')) {
							ColdPossibility = 0.4 * (Number(temperature)) + 0.3 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 5;
						} else if (tempData.includes('대구')) {
							ColdPossibility = 0.45 * (Number(temperature)) + 0.25 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.1 * (Number(precipitationProbability)) + 6;
						} else if (tempData.includes('부산')) {
							ColdPossibility = 0.3 * (Number(temperature)) + 0.4 * (Number(humidity)) + 0.25 * (Number(wind)) + 0.25 * (Number(precipitationProbability)) + 2;
						} else if (tempData.includes('울산')) {
							ColdPossibility = 0.3 * (Number(temperature)) + 0.35 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.15 * (Number(precipitationProbability)) + 2;
						} else if (tempData.includes('제주')) {
							ColdPossibility = 0.25 * (Number(temperature)) + 0.4 * (Number(humidity)) + 0.2 * (Number(wind)) + 0.15 * (Number(precipitationProbability)) + 3;
						} else {
							ColdPossibility = 0;
						}
						// 기타 지역에 대한 감기 가능 지수 계산 (생략)

						// 감기 가능 지수 텍스트
						let ColdData = '';
						if (ColdPossibility < 33) {
							ColdData = '낮음';
						} else if (ColdPossibility < 66) {
							ColdData = '보통';
						} else if (ColdPossibility < 85) {
							ColdData = '높음';
						} else {
							ColdData = '매우 높음';
						}
						let corruption = ((humidity-65)/14)*Math.pow(1.054,temperature);
						// HTML 요소에 데이터 삽입

						$('#ColdData').text(ColdData);
						$('#corruptionValue').text(corruption);
					} else {
						console.log(`데이터가 없습니다: ${baseDate}`);
					}
				})
				.catch(error => console.error('Error:', error));
		});
	}
});
