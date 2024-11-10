const regionMap = {
    "서울": ["서울"],
    "경기": ["경기", "수원", "성남", "안양", "부천", "고양", "용인", "의정부", "평택", "시흥", "파주", "이천", "안산", "광명", "하남", "광주", "김포", "군포", "여주", "양평", "구리", "오산", "의왕", "포천", "동두천", "가평", "과천", "세종"],
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

// 지역을 찾는 함수
function findProvince(tempData) {
    for (let province in regionMap) {
        if (regionMap[province].some(region => tempData.includes(region))) {
            return province;
        }
    }
    return null; // 일치하는 시/도가 없으면 null 반환
}

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

                // 추출한 지역명으로 시/도를 찾음
                const province = findProvince(tempData2);

                if (province) {
                    const result = temp.find(item => item.OCCRNC_AREA && item.OCCRNC_AREA.split('(')[0] === province);

                    if (result && result.PATNT_CNT) {
                        const patientCount = Number(result.PATNT_CNT);
						console.log(patientCount + '계싼')

                        if (patientCount < 50) {
							document.getElementById('foodPoisonValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1YwH1ezeI1hG3GKA94ywXhwRkV9EnsHp7" alt="관심" class="small-block-icon">';
							document.getElementById('foodPoisonIndex').style.backgroundColor = '#DFFFD6';//연두
                        } else if (patientCount < 100) {
							document.getElementById('foodPoisonValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1gNLAEWkUg80wTKf2FfMyaOAdDLWiQLG3" alt="관심" class="small-block-icon">';
							document.getElementById('foodPoisonIndex').style.backgroundColor = '#D6F5FF';//파랑
                        } else if (patientCount < 150) {
							document.getElementById('foodPoisonValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1STXhOfdnB1RO1FJjpRSqKdZwK9IdajnU" alt="관심" class="small-block-icon">';
							document.getElementById('foodPoisonIndex').style.backgroundColor = '#FFF9CC';//주황?
                        } else {
							document.getElementById('foodPoisonValue').innerHTML = '<img src="https://drive.google.com/thumbnail?id=1sp86yWMrXeVNKMsCJfYFZKqYVc4mJ1xz" alt="관심" class="small-block-icon">';
							document.getElementById('foodPoisonIndex').style.backgroundColor = '#FFD6E7';//빨강
                        }
						document.getElementById('foodPoisonValue').innerHTML += `<br><a style="font-size : 32px;">${patientCount}건</a>`;

                    } else {
                        console.log("해당 지역의 데이터가 없습니다.");
                        document.getElementById('foodPoisonValue').innerText = "N/A";
                    }
                } else {
                    console.log("지역 정보가 일치하지 않습니다.");
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
