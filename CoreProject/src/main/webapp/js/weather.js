const apiKey = 'jCDTuMMv%2F5m%2B%2FeN3UltXzWg%2FJV9nTtpP5JR%2F8tAqJ8KASXfEevwJGb3iAiEgNrYh6FOIf%2Fnrygm5jBe%2BkpR0fg%3D%3D';

const today = new Date();
const formatDate = (date) => date.toISOString().slice(0, 10).replace(/-/g, '');
const dates = [new Date(), new Date(today.setDate(today.getDate() + 1)), new Date(today.setDate(today.getDate() + 1))].map(formatDate);

const baseTime = '0500';
const pageNo = 1;
const numOfRows = 100;



dates.forEach((baseDate) => {
	const url = `http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst?serviceKey=${apiKey}&pageNo=${pageNo}&numOfRows=${numOfRows}&dataType=JSON&base_date=${baseDate}&base_time=${baseTime}&nx=${nx}&ny=${ny}`;

	fetch(url)
		.then(response => response.json())
		.then(data => {
			if (data.response && data.response.body && data.response.body.items) {
				const items = data.response.body.items.item;

				const temperatureItem = items.find(item => item.category === 'TMP');
				const humidityItem = items.find(item => item.category === 'REH');
				const skyItem = items.find(item => item.category === 'SKY');
				const ptyItem = items.find(item => item.category === 'PTY');
				const precipitationProbabilityItem = items.find(item => item.category === 'POP');

				const maxTemperatureItem = items.find(item => item.category === 'TMX');  // 최고온도
				const minTemperatureItem = items.find(item => item.category === 'TMN');  // 최저온도

				const temperature = temperatureItem ? temperatureItem.fcstValue : 'N/A';
				const humidity = humidityItem ? humidityItem.fcstValue : 'N/A';

				const maxTemperature = maxTemperatureItem ? maxTemperatureItem.fcstValue : 'N/A';
				const minTemperature = minTemperatureItem ? minTemperatureItem.fcstValue : 'N/A';

				const sky = skyItem ? skyItem.fcstValue : 'N/A';
				const pty = ptyItem ? ptyItem.fcstValue : 'N/A';
				const precipitationProbability = precipitationProbabilityItem ? precipitationProbabilityItem.fcstValue : 'N/A';

				let weatherStatus = '';
				if (pty === '0') {
					weatherStatus = sky === '1' ? '맑음' : sky === '3' ? '구름 많음' : '흐림';
				} else if (pty === '1') {
					weatherStatus = '비';
				} else if (pty === '2') {
					weatherStatus = '비/눈';
				} else if (pty === '3') {
					weatherStatus = '눈';
				} else if (pty === '5') {
					weatherStatus = '빗방울';
				} else if (pty === '6') {
					weatherStatus = '빗방울/눈날림';
				} else if (pty === '7') {
					weatherStatus = '눈날림';
				}

				const weatherInfoDiv = document.getElementById('weatherInfo');
				weatherInfoDiv.innerHTML += `
                                <div class="forecast">
                                    <h3>${baseDate}</h3>
                                    <p><strong>최고 온도:</strong> ${maxTemperature}°C</p>
                                    <p><strong>최저 온도:</strong> ${minTemperature}°C</p>
                                    <p><strong>현재 온도:</strong> ${temperature}°C</p>
                                    <p><strong>습도:</strong> ${humidity}%</p>
                                    <p><strong>날씨 상태:</strong> ${weatherStatus}</p>
                                    <p><strong>강수 확률:</strong> ${precipitationProbability}%</p>
                                </div>`;
			} else {
				console.log(`데이터가 없습니다: ${baseDate}`);
			}
		})
		.catch(error => console.error('Error:', error));
});
