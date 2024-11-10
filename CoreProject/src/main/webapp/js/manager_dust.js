$(document).ready(function() {
	const APIkey = 'c9ff99ee2852e19283c56fc2242cbe73';
	const url = `http://api.openweathermap.org/data/2.5/air_pollution?lat=${lat2}&lon=${lon2}&appid=${APIkey}`;

	fetch(url)
		.then(response => response.json())
		.then(data => {
			console.log(data); // 데이터 출력
			const component = data.list[0].components;
			console.log(component);
			const pm10 = component.pm10;
			const pm2_5 = component.pm2_5;
			if (pm10 <= 15 || pm2_5 <= 30) {
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=19cdWn4dH2iiB7BTvhDOadhKNktUpKesg" alt="좋음" class="small-block-icon"><br>좋음'
				document.getElementById('dustValue').style.cssText='color: green;'
				document.getElementById('dustIndex').style.backgroundColor = '#DFFFD6';//연두
			} else if (pm10 <= 80 || pm2_5 <= 35) {
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1b2ZadHyQds4sr8PN6tvfC2YAWkZKcwWJ" alt="보통" class="small-block-icon"><br>보통'
				document.getElementById('dustValue').style.cssText='color: blue;'
				document.getElementById('dustIndex').style.backgroundColor = '#D6F5FF';//파랑
			} else if (pm10 <= 150 || pm2_5 <= 75) {
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1DsBweMw9-GzYDPAl82vqshokm1bZXAvB" alt="나쁨" class="small-block-icon"><br>나쁨'
				document.getElementById('dustValue').style.cssText='color: yellow;'
				document.getElementById('dustIndex').style.backgroundColor = '#FFF9CC';//주황?
			} else {
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1J_cvu3C4s8Vyoaik5bxV_oJ3DQQhTpO-" alt="매우 나쁨" class="small-block-icon"><br>매우 나쁨'
				document.getElementById('dustValue').style.cssText='color: red;'
				document.getElementById('dustIndex').style.backgroundColor = '#FFD6E7';//빨강
			}
		})
		.catch(error => console.error('Error:', error)); // 에러 처리
});
