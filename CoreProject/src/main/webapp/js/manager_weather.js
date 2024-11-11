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

	  let baseTime = '0500';

	  const currentHour = today.getHours();
      if (currentHour < 5) {
          // 5시 이전이면 전날 2300 시간 데이터를 사용
          today.setDate(today.getDate() - 1);
          baseDate = formatDate(today);
          baseTime = '2300';
      } else if (currentHour < 11) {
          baseTime = '0500';
      } else if (currentHour < 17) {
          baseTime = '1100';
      } else if (currentHour < 23) {
          baseTime = '1700';
      } else {
          baseTime = '2300';
      }
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
				  const regionMap = {
				      "서울": ["서울"],
				      "경기": ["경기", "수원", "성남", "안양", "부천", "고양", "용인", "의정부", "평택", "시흥", "파주", "이천", "안산", "광명", "하남", "광주", "김포", "군포", "여주", "양평", "구리", "오산", "의왕", "포천", "동두천", "가평", "과천","세종"],
				      "강원": ["강원", "춘천", "원주", "강릉", "동해", "속초", "삼척", "태백", "정선", "철원", "화천", "양구", "인제", "고성", "양양"],
				      "충북": ["충북", "충청북도", "청주", "충주", "제천", "보은", "옥천", "영동", "증평", "진천", "괴산", "음성", "단양"],
				      "충남": ["충남", "충청남도", "천안", "아산", "서산", "태안", "공주", "보령", "논산", "계룡", "당진", "부여", "서천", "홍성", "예산", "청양"],
				      "경북": ["경북", "경상북도", "포항", "구미", "경주", "안동", "김천", "영주", "영천", "상주", "문경", "경산", "의성", "청송", "영양", "영덕", "청도", "고령", "성주", "칠곡", "예천", "봉화", "울진", "울릉"],
				      "경남": ["경남", "경상남도", "창원", "김해", "진주", "양산", "거제", "사천", "밀양", "통영", "거창", "함안", "창녕", "고성", "하동", "산청", "함양", "합천", "남해"],
				      "전북": ["전북", "전라북도", "전주", "군산", "익산", "정읍", "남원", "김제", "완주", "진안", "무주", "장수", "임실", "순창", "고창", "부안"],
				      "전남": ["전남", "전라남도", "목포", "여수", "순천", "광양", "나주", "담양", "고흥", "보성", "화순", "장흥", "강진", "해남", "영암", "무안", "함평", "영광", "장성", "완도", "진도", "신안"],
				      "광주": ["광주"],
				      "대전": ["대전"],
				      "대구": ["대구"],
				      "울산": ["울산"],
				      "부산": ["부산"],
				      "제주": ["제주", "서귀포"]
				  };

				  function findProvince(tempData) {
				      for (let province in regionMap) {
				          if (regionMap[province].some(region => tempData.includes(region))) {
				              return province;
				          }
				      }
				      return null; // 일치하는 시/도가 없으면 null 반환
				  }
				  const province = findProvince(tempData);
				  if (province === "경기" || province === "서울") {
				      ColdPossibility = 0.4 * Number(temperature) + 0.3 * Number(humidity) + 0.2 * Number(wind) + 0.1 * Number(precipitationProbability) + 5;
				  } else if (province === "강원") {
				      ColdPossibility = 0.5 * Number(temperature) + 0.2 * Number(humidity) + 0.2 * Number(wind) + 0.1 * Number(precipitationProbability) + 10;
				  } else if (province === "충북") {
				      ColdPossibility = 0.35 * Number(temperature) + 0.3 * Number(humidity) + 0.25 * Number(wind) + 0.1 * Number(precipitationProbability) + 4;
				  } else if (province === "충남") {
				      ColdPossibility = 0.3 * Number(temperature) + 0.35 * Number(humidity) + 0.2 * Number(wind) + 0.15 * Number(precipitationProbability) + 4;
				  } else if (province === "경남") {
				      ColdPossibility = 0.35 * Number(temperature) + 0.3 * Number(humidity) + 0.2 * Number(wind) + 0.15 * Number(precipitationProbability) + 3;
				  } else if (province === "경북") {
				      ColdPossibility = 0.4 * Number(temperature) + 0.25 * Number(humidity) + 0.25 * Number(wind) + 0.1 * Number(precipitationProbability) + 3;
				  } else if (province === "전북") {
				      ColdPossibility = 0.3 * Number(temperature) + 0.4 * Number(humidity) + 0.2 * Number(wind) + 0.1 * Number(precipitationProbability) + 2;
				  } else if (province === "전남") {
				      ColdPossibility = 0.3 * Number(temperature) + 0.35 * Number(humidity) + 0.15 * Number(wind) + 0.2 * Number(precipitationProbability) + 2;
				  } else if (province === "광주") {
				      ColdPossibility = 0.35 * Number(temperature) + 0.35 * Number(humidity) + 0.2 * Number(wind) + 0.1 * Number(precipitationProbability) + 3;
				  } else if (province === "대전") {
				      ColdPossibility = 0.4 * Number(temperature) + 0.3 * Number(humidity) + 0.2 * Number(wind) + 0.1 * Number(precipitationProbability) + 5;
				  } else if (province === "대구") {
				      ColdPossibility = 0.45 * Number(temperature) + 0.25 * Number(humidity) + 0.2 * Number(wind) + 0.1 * Number(precipitationProbability) + 6;
				  } else if (province === "부산") {
				      ColdPossibility = 0.3 * Number(temperature) + 0.4 * Number(humidity) + 0.25 * Number(wind) + 0.25 * Number(precipitationProbability) + 2;
				  } else if (province === "울산") {
				      ColdPossibility = 0.3 * Number(temperature) + 0.35 * Number(humidity) + 0.2 * Number(wind) + 0.15 * Number(precipitationProbability) + 2;
				  } else if (province === "제주") {
				      ColdPossibility = 0.25 * Number(temperature) + 0.4 * Number(humidity) + 0.2 * Number(wind) + 0.15 * Number(precipitationProbability) + 3;
				  } else {
				      ColdPossibility = 0; // 일치하는 시/도가 없을 경우
				  }
				  console.log("ColdPossibility:", ColdPossibility);

                  
                  // 감기 가능 지수 텍스트 설정
                  if (ColdPossibility < 33) {
                     document.getElementById('ColdData').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1AydowXfb6WSLFuTF6CAJ25IiWyivnNoa" alt="낮음" class="small-block-icon"><br>낮음';
                     document.getElementById('ColdData').style.cssText = 'color: green;';   
					 document.getElementById('ColdPossibility').style.backgroundColor = '#DFFFD6';//연두
                  } else if (ColdPossibility < 66) {
                     document.getElementById('ColdData').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1WO6xiYog-VaY0htSXLD7j-CUnji39QaZ" alt="보통" class="small-block-icon"><br>보통';
                     document.getElementById('ColdData').style.cssText = 'color: blue;';
					 document.getElementById('ColdPossibility').style.backgroundColor = '#D6F5FF';//파랑
                  } else if (ColdPossibility < 85) {
                     document.getElementById('ColdData').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1gXzRPvgYi2f7v2IEQD7KlywG_sIujd5D" alt="높음" class="small-block-icon"><br>높음';
                     document.getElementById('ColdData').style.cssText = 'color: yellow;';
					 document.getElementById('ColdPossibility').style.backgroundColor = '#FFF9CC';//주황?
                  } else {
                     document.getElementById('ColdData').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1vrLdjzfq4MSPYkreTLDwOoJ22gF4hc52" alt="매우 높음" class="small-block-icon"><br>매우 높음';
                     document.getElementById('ColdData').style.cssText = 'color: red;';
					 document.getElementById('ColdPossibility').style.backgroundColor ='#FFD6E7';//빨강
                  }
                  let corruption = ((humidity-65)/14)*Math.pow(1.056,temperature);
                  console.log('corruption : '+corruption);
                  console.log('ColdData : ' +'ColdData');
                  let corruptionText = '';
                  let corruptionImage = '';
                  if (corruption < 3.0) {
                     corruptionText = '양호';
                     corruptionImage = 'https://drive.google.com/thumbnail?id=1XsKMs2F06dVrWDf26gcrNL5IQmS6QgIR';
                     document.getElementById('corruptionValue').style.cssText = 'color: green;';       
					 document.getElementById('corruption').style.backgroundColor = '#DFFFD6';//연두

                  } else if (corruption < 7.0) {
                     corruptionText = '보통';
                     corruptionImage = 'https://drive.google.com/thumbnail?id=1Cdv88eNEee3Yod4mxovoeXrMHVPT0g80';
                     document.getElementById('corruptionValue').style.cssText = 'color: yellow;';               
					 document.getElementById('corruption').style.backgroundColor = '#FFF9CC';//주황?
                  } else {
                     corruptionText = '위험';
                     corruptionImage = 'https://drive.google.com/thumbnail?id=1mhoxOVldG5Ttooi0INtnjIvFNU9wytto';
                     document.getElementById('corruptionValue').style.cssText = 'color: red;';               
					 document.getElementById('corruption').style.backgroundColor = '#FFD6E7';//빨강
                  }
                     // HTML 요소에 부패 지수 이미지 및 텍스트 추가
                  document.getElementById('corruptionValue').innerHTML = `<img src="${corruptionImage}" alt="${corruptionText}" class="small-block-icon"><br>${corruptionText}`;
                  
                  
               } else {
                  console.log(`데이터가 없습니다: ${baseDate}`);
               }
            })
            .catch(error => console.error('Error:', error));
      });
   }
});
