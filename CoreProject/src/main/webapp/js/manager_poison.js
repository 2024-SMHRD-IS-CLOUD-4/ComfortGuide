$(document).ready(function() {
    const keyId = 'd8ec119e961f40dca662';
    const serviceId = 'I2848';
    const dataType = 'json';
    const startIdx = 1;
    const endIdx = 14;

	const url = `http://openapi.foodsafetykorea.go.kr/api/${keyId}/${serviceId}/${dataType}/${startIdx}/${endIdx}`;

    fetch(url)
        .then(response => {
            if (!response.ok) {
                throw new Error("Network response was not ok " + response.statusText);
            }
            return response.json();
        })
        .then(data => {
            console.log("Data fetched:", data);

            if (data.I2848 && data.I2848.row) {
                const temp = data.I2848.row;
                console.log("Row data:", temp);

                const result = temp.find(item => item.OCCRNC_AREA && item.OCCRNC_AREA.split('(')[0] === tempData2);
                
                if (result && result.PATNT_CNT) {
                    document.getElementById('foodPoisonValue').innerText = result.PATNT_CNT;
                } else {
                    console.log("해당 지역의 데이터가 없습니다.");
                    document.getElementById('foodPoisonValue').innerText = "N/A";
                }
            } else {
                console.log("데이터 형식이 예상과 다릅니다.");
                document.getElementById('foodPoisonValue').innerText = "N/A";
            }
        })
        .catch(error => {
            console.error("API 요청 중 오류 발생:", error);
            document.getElementById('foodPoisonValue').innerText = "오류";
        });
});
