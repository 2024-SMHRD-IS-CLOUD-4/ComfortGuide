$(document).ready(function() {
    const apiKey = 'jCDTuMMv%2F5m%2B%2FeN3UltXzWg%2FJV9nTtpP5JR%2F8tAqJ8KASXfEevwJGb3iAiEgNrYh6FOIf%2Fnrygm5jBe%2BkpR0fg%3D%3D';

    // 휴게소를 선택했을 때 `lat`과 `lon`을 가져와 날씨 API 호출
    $('#restStop').on('change', function() {
        const restStop = $(this).val();

        if (restStop) {
            // 서버에 AJAX 요청으로 `lat`과 `lon`을 가져옴
            $.ajax({
                url: 'getServiceArea',
                type: 'GET',
                data: { restStop: restStop },
                success: function(data) {
                    const lat = Math.floor(data.lat);
                    const lon = Math.floor(data.lon);
                    fetchWeatherData(lat, lon); // 날씨 API 호출
                },
                error: function(error) {
                    console.error("Service Area 데이터 로드 실패:", error);
                }
            });
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
                        const skyItem = items.find(item => item.category === 'SKY');
                        const ptyItem = items.find(item => item.category === 'PTY');
                        const precipitationProbabilityItem = items.find(item => item.category === 'POP');

                        const temperature = temperatureItem ? temperatureItem.fcstValue : 'N/A';
                        const humidity = humidityItem ? humidityItem.fcstValue : 'N/A';
                        const precipitationProbability = precipitationProbabilityItem ? precipitationProbabilityItem.fcstValue : 'N/A';
                        let weatherStatus = '';

                        // 날씨 상태 설정
                        if (ptyItem && ptyItem.fcstValue === '0') {
                            weatherStatus = skyItem.fcstValue === '1' ? '맑음' : skyItem.fcstValue === '3' ? '구름 많음' : '흐림';
                        } else {
                            switch (ptyItem ? ptyItem.fcstValue : 'N/A') {
                                case '1': weatherStatus = '비'; break;
                                case '2': weatherStatus = '비/눈'; break;
                                case '3': weatherStatus = '눈'; break;
                                case '5': weatherStatus = '빗방울'; break;
                                case '6': weatherStatus = '빗방울/눈날림'; break;
                                case '7': weatherStatus = '눈날림'; break;
                                default: weatherStatus = 'N/A';
                            }
                        }

                        // HTML 요소에 데이터 삽입
                        $('#temperature').find('span:last').text(`${temperature}°C`);
                        $('#humidity').find('span:last').text(`${humidity}%`);
                        $('#weather_conditions').find('span:last').text(weatherStatus);
                        $('#Precipitation_probability').find('span:last').text(`${precipitationProbability}%`);
                    } else {
                        console.log(`데이터가 없습니다: ${baseDate}`);
                    }
                })
                .catch(error => console.error('Error:', error));
        });
    }
});
