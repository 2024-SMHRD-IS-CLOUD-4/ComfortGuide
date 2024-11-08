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
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=10-_0PuNhgHsv14FaehmcIVd8508zujpo" alt="좋음" class="small-block-icon"><br>좋음'
				document.getElementById('dustValue').style.cssText='color: blue;'
			} else if (pm10 <= 80 || pm2_5 <= 35) {
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1aYPt0Ma6cjQTGjHkuwdLTHi1n1rAuboU" alt="보통" class="small-block-icon"><br>보통'
				document.getElementById('dustValue').style.cssText='color: green;'
			} else if (pm10 <= 150 || pm2_5 <= 75) {
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=16I0ql4_Q5SA2D-KcjxN31p4KDNT8Lq0m" alt="나쁨" class="small-block-icon"><br>나쁨'
				document.getElementById('dustValue').style.cssText='color: yellow;'
			} else {
				document.getElementById('dustValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1jfOjME7NJyR43qnXVwaZtA3OB1_dUdgd" alt="매우 나쁨" class="small-block-icon"><br>매우 나쁨'
				document.getElementById('dustValue').style.cssText='color: red;'
			}
		})
		.catch(error => console.error('Error:', error)); // 에러 처리
});
