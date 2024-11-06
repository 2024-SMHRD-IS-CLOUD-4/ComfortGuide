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
					if(result.PATNT_CNT<35){
						document.getElementById('foodPoisonValue').innerHTML = '<img src="images/smile.png" alt="관심" class="small-block-icon"><br>관심'
						document.getElementById('foodPoisonValue').style.cssText='color: green;'
					}
				else if(result.PATNT_CNT<70){
						document.getElementById('foodPoisonValue').innerHTML = '<img src="images/what.png" alt="주의" class="small-block-icon"><br>주의'
						document.getElementById('foodPoisonValue').style.cssText='color: yellow;'
					}
				else if(result.PATNT_CNT<95){
						document.getElementById('foodPoisonValue').innerHTML = '<img src="image/so_bad.png" alt="경고" class="small-block-icon"><br>경고'
						document.getElementById('foodPoisonValue').style.cssText='color: orange;'
					}
				else if(result.PATNT_CNT>=95){
						document.getElementById('foodPoisonValue').innerHTML = '<img src="images/bad.png" alt="위험" class="small-block-icon"><br>위험'
						document.getElementById('foodPoisonValue').style.cssText='color: red;'
					}
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
