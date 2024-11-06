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
				document.getElementById('dustValue').innerHTML = '<img src="images/smile.png" alt="좋음" class="small-block-icon"><br>좋음'
				document.getElementById('dustValue').style.cssText='color: blue;'
			} else if (pm10 <= 80 || pm2_5 <= 35) {
				document.getElementById('dustValue').innerHTML = '<img src="images/what.png" alt="보통" class="small-block-icon"><br>보통'
				document.getElementById('dustValue').style.cssText='color: green;'
			} else if (pm10 <= 150 || pm2_5 <= 75) {
				document.getElementById('dustValue').innerHTML = '<img src="images/mask_normal.png" alt="나쁨" class="small-block-icon"><br>나쁨'
				document.getElementById('dustValue').style.cssText='color: yellow;'
			} else {
				document.getElementById('dustValue').innerHTML = '<img src="images/mask_hard.png" alt="매우 나쁨" class="small-block-icon"><br>매우 나쁨'
				document.getElementById('dustValue').style.cssText='color: red;'
			}
		})
		.catch(error => console.error('Error:', error)); // 에러 처리
});
