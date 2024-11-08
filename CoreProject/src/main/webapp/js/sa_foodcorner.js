const salist = [
	{
		file_name: "거창(대구)",
		data: [
			{ corner: "중식", menu: "짜장면", price: 7000, monthlyRevenue: 125000 },
			{ corner: "한식", menu: "백반정식", price: 8500, monthlyRevenue: 4233000 },
			{ corner: "한식", menu: "순두부찌개", price: 7000, monthlyRevenue: 427000 },
			{ corner: "한식", menu: "양파뚝배기불고기", price: 9500, monthlyRevenue: 1073100 },
			{ corner: "한식", menu: "돼지김치찌개", price: 8500, monthlyRevenue: 1503000 },
			{ corner: "한식", menu: "쇠고기육개장", price: 8500, monthlyRevenue: 784000 },
			{ corner: "한식", menu: "비빔밥", price: 7500, monthlyRevenue: 3615000 },
			{ corner: "한식", menu: "얼갈이된장국", price: 7000, monthlyRevenue: 1265000 },
			{ corner: "한식", menu: "제육덮밥", price: 8000, monthlyRevenue: 560000 },
			{ corner: "분식", menu: "왕새우튀김우동", price: 8000, monthlyRevenue: 1478000 },
			{ corner: "분식", menu: "유부우동", price: 7000, monthlyRevenue: 1187000 },
			{ corner: "분식", menu: "꼬치어묵우동", price: 7500, monthlyRevenue: 1655000 },
			{ corner: "분식", menu: "라면", price: 3500, monthlyRevenue: 470000 },
			{ corner: "분식", menu: "EX라면", price: 6000, monthlyRevenue: 539000 },
			{ corner: "분식", menu: "계란 떡라면", price: 5000, monthlyRevenue: 435000 },
			{ corner: "분식", menu: "치즈 라면", price: 5000, monthlyRevenue: 445000 },
			{ corner: "분식", menu: "왕돈가스", price: 13000, monthlyRevenue: 1862000 },
			{ corner: "분식", menu: "치즈돈가스", price: 14000, monthlyRevenue: 518000 },
			{ corner: "분식", menu: "돈가스&소시지", price: 14000, monthlyRevenue: 708000 },
			{ corner: "분식", menu: "오므라이스", price: 5000, monthlyRevenue: 300000 },
			{ corner: "분식", menu: "떡볶이", price: 4500, monthlyRevenue: 1579500 },
			{ corner: "스낵", menu: "치즈맛바", price: 4000, monthlyRevenue: 1579000 },
			{ corner: "스낵", menu: "소떡소떡", price: 4000, monthlyRevenue: 1723000 },
			{ corner: "스낵", menu: "옛날핫도그", price: 4000, monthlyRevenue: 854000 },
			{ corner: "스낵", menu: "문어와오징어바", price: 4000, monthlyRevenue: 659000 },
			{ corner: "스낵", menu: "고추맛바", price: 4000, monthlyRevenue: 1982000 },
			{ corner: "스낵", menu: "불갈비맛소시지", price: 4000, monthlyRevenue: 1102000 },
			{ corner: "스낵", menu: "고구마스틱", price: 4000, monthlyRevenue: 1972000 },
			{ corner: "스낵", menu: "쥐포", price: 4000, monthlyRevenue: 866639 },
			{ corner: "스낵", menu: "토스트", price: 5000, monthlyRevenue: 1105000 },
			{ corner: "스낵", menu: "수제호떡", price: 5000, monthlyRevenue: 713000 },
			{ corner: "스낵", menu: "알감자", price: 3000, monthlyRevenue: 450000 },
			{ corner: "스낵", menu: "통감자구이(160g)", price: 2500, monthlyRevenue: 669100 },
			{ corner: "스낵", menu: "통감자구이(300g)", price: 5000, monthlyRevenue: 731000 },
			{ corner: "스낵", menu: "호두과자(200g)", price: 3000, monthlyRevenue: 1866000 },
			{ corner: "스낵", menu: "호두과자(400g)", price: 6000, monthlyRevenue: 1857000 },
			{ corner: "스낵", menu: "델리만주(200g)", price: 4000, monthlyRevenue: 1800000 },
			{ corner: "스낵", menu: "델리만주(400g)", price: 8000, monthlyRevenue: 1720000 },
			{ corner: "카페", menu: "아메리카노", price: 3000, monthlyRevenue: 1248000 },
			{ corner: "카페", menu: "카페라떼", price: 3500, monthlyRevenue: 742000 },
			{ corner: "카페", menu: "핫초코", price: 3500, monthlyRevenue: 1165500 },
			{ corner: "기타", menu: "생수", price: 1000, monthlyRevenue: 171000 },
			{ corner: "기타", menu: "탄산음료", price: 1500, monthlyRevenue: 490500 }
		]
	},
	{
		file_name: "지리산(대구)",
		data: [
			{ corner: "중식", menu: "짜장면", price: 5000, monthlyRevenue: 160000 },
			{ corner: "한식", menu: "백반정식", price: 8500, monthlyRevenue: 153000 },
			{ corner: "한식", menu: "순두부찌개", price: 7000, monthlyRevenue: 224000 },
			{ corner: "한식", menu: "된장찌개", price: 7000, monthlyRevenue: 210000 },
			{ corner: "한식", menu: "김치찌개", price: 7000, monthlyRevenue: 290000 },
			{ corner: "한식", menu: "육개장", price: 8000, monthlyRevenue: 240000 },
			{ corner: "한식", menu: "비빔밥", price: 7500, monthlyRevenue: 253500 },
			{ corner: "한식", menu: "불고기덮밥", price: 8500, monthlyRevenue: 365000 },
			{ corner: "한식", menu: "제육덮밥", price: 8000, monthlyRevenue: 464000 },
			{ corner: "한식", menu: "남원시래기국밥", price: 5500, monthlyRevenue: 355000 },
			{ corner: "한식", menu: "남원추어탕", price: 9000, monthlyRevenue: 352000 },
			{ corner: "분식", menu: "라면", price: 3500, monthlyRevenue: 470000 },
			{ corner: "분식", menu: "라면 (공기밥 포함)", price: 5000, monthlyRevenue: 550000 },
			{ corner: "분식", menu: "계란 떡라면", price: 5000, monthlyRevenue: 435000 },
			{ corner: "분식", menu: "치즈 라면", price: 5000, monthlyRevenue: 445000 },
			{ corner: "분식", menu: "우동", price: 5000, monthlyRevenue: 370000 },
			{ corner: "분식", menu: "유부우동", price: 5000, monthlyRevenue: 305000 },
			{ corner: "분식", menu: "꼬치어묵우동", price: 6000, monthlyRevenue: 810000 },
			{ corner: "분식", menu: "돈가스", price: 8500, monthlyRevenue: 480000 },
			{ corner: "분식", menu: "치즈돈가스", price: 8000, monthlyRevenue: 435000 },
			{ corner: "분식", menu: "왕돈가스", price: 6000, monthlyRevenue: 420000 },
			{ corner: "분식", menu: "오므라이스", price: 5000, monthlyRevenue: 300000 },
			{ corner: "분식", menu: "떡볶이", price: 4500, monthlyRevenue: 1579500 },
			{ corner: "스낵", menu: "어묵바", price: 2000, monthlyRevenue: 140000 },
			{ corner: "스낵", menu: "핫도그", price: 2500, monthlyRevenue: 168000 },
			{ corner: "스낵", menu: "소떡소떡", price: 3000, monthlyRevenue: 165000 },
			{ corner: "스낵", menu: "임실치즈", price: 4000, monthlyRevenue: 341000 },
			{ corner: "스낵", menu: "알감자", price: 3000, monthlyRevenue: 450000 },
			{ corner: "스낵", menu: "호두과자(200g)", price: 3000, monthlyRevenue: 286600 },
			{ corner: "스낵", menu: "호두과자(400g)", price: 6000, monthlyRevenue: 485700 },
			{ corner: "스낵", menu: "델리만주(200g)", price: 4000, monthlyRevenue: 480000 },
			{ corner: "스낵", menu: "델리만주(400g)", price: 8000, monthlyRevenue: 372000 },
			{ corner: "커피", menu: "할리스커피", price: 4500, monthlyRevenue: 465000 },
			{ corner: "커피", menu: "서울도너츠", price: 2500, monthlyRevenue: 365000 },
			{ corner: "카페", menu: "아메리카노", price: 3000, monthlyRevenue: 1248000 },
			{ corner: "카페", menu: "카페라떼", price: 3500, monthlyRevenue: 742000 },
			{ corner: "카페", menu: "핫초코", price: 3500, monthlyRevenue: 1165500 },
			{ corner: "기타", menu: "생수", price: 1000, monthlyRevenue: 171000 },
			{ corner: "기타", menu: "탄산음료", price: 1500, monthlyRevenue: 490500 }
		]
	},
	{
		file_name: "함평나비(광주)",
		data: [
			{ corner: "중식", menu: "짜장면", price: 5000, monthlyRevenue: 150000 },
			{ corner: "한식", menu: "백반정식", price: 8500, monthlyRevenue: 4233000 },
			{ corner: "한식", menu: "순두부찌개", price: 7000, monthlyRevenue: 427000 },
			{ corner: "한식", menu: "된장찌개", price: 7000, monthlyRevenue: 2191000 },
			{ corner: "한식", menu: "김치찌개", price: 7000, monthlyRevenue: 2177000 },
			{ corner: "한식", menu: "추어탕", price: 8000, monthlyRevenue: 3576000 },
			{ corner: "한식", menu: "소고기국밥", price: 8000, monthlyRevenue: 1024000 },
			{ corner: "한식", menu: "육개장", price: 8000, monthlyRevenue: 2040000 },
			{ corner: "한식", menu: "비빔밥", price: 7500, monthlyRevenue: 3615000 },
			{ corner: "한식", menu: "불고기덮밥", price: 8500, monthlyRevenue: 4131000 },
			{ corner: "한식", menu: "제육덮밥", price: 8000, monthlyRevenue: 560000 },
			{ corner: "분식", menu: "라면", price: 4000, monthlyRevenue: 612000 },
			{ corner: "분식", menu: "라면 (공기밥 포함)", price: 5000, monthlyRevenue: 550000 },
			{ corner: "분식", menu: "계란 떡라면", price: 5000, monthlyRevenue: 435000 },
			{ corner: "분식", menu: "치즈 라면", price: 5000, monthlyRevenue: 445000 },
			{ corner: "분식", menu: "김밥", price: 3000, monthlyRevenue: 468000 },
			{ corner: "분식", menu: "우동", price: 5000, monthlyRevenue: 2300000 },
			{ corner: "분식", menu: "유부우동", price: 5000, monthlyRevenue: 305000 },
			{ corner: "분식", menu: "꼬치어묵우동", price: 6000, monthlyRevenue: 810000 },
			{ corner: "분식", menu: "잔치국수", price: 5500, monthlyRevenue: 445500 },
			{ corner: "분식", menu: "돈가스", price: 8500, monthlyRevenue: 462000 },
			{ corner: "분식", menu: "왕돈가스", price: 6000, monthlyRevenue: 420000 },
			{ corner: "분식", menu: "치즈돈가스", price: 8000, monthlyRevenue: 256000 },
			{ corner: "분식", menu: "오므라이스", price: 5000, monthlyRevenue: 300000 },
			{ corner: "분식", menu: "새우덮밥", price: 8000, monthlyRevenue: 364000 },
			{ corner: "분식", menu: "새우튀김", price: 7500, monthlyRevenue: 125000 },
			{ corner: "분식", menu: "오징어덮밥", price: 8000, monthlyRevenue: 256000 },
			{ corner: "분식", menu: "떡볶이", price: 4500, monthlyRevenue: 157500 },
			{ corner: "분식", menu: "튀김 (모듬)", price: 4000, monthlyRevenue: 900000 },
			{ corner: "분식", menu: "소떡소떡", price: 2500, monthlyRevenue: 102500 },
			{ corner: "스낵", menu: "알감자", price: 3000, monthlyRevenue: 450000 },
			{ corner: "스낵", menu: "호두과자(200g)", price: 3000, monthlyRevenue: 286600 },
			{ corner: "스낵", menu: "호두과자(400g)", price: 6000, monthlyRevenue: 485700 },
			{ corner: "스낵", menu: "델리만주(200g)", price: 4000, monthlyRevenue: 480000 },
			{ corner: "스낵", menu: "델리만주(400g)", price: 8000, monthlyRevenue: 372000 },
			{ corner: "카페", menu: "아메리카노", price: 3000, monthlyRevenue: 124000 },
			{ corner: "카페", menu: "카페라떼", price: 3500, monthlyRevenue: 742000 },
			{ corner: "카페", menu: "핫초코", price: 3500, monthlyRevenue: 116500 },
			{ corner: "기타", menu: "생수", price: 1000, monthlyRevenue: 171000 },
			{ corner: "기타", menu: "탄산음료", price: 1500, monthlyRevenue: 490500 }
		]
	}
];

// 선택된 휴게소 데이터 찾기
const selectedData = salist.find(item => item.file_name === saName);

// 코너별 메뉴 분류 및 매출 데이터 준비
if (selectedData) {
	const labels = selectedData.data.map(item => item.menu);
	const data = selectedData.data.map(item => item.monthlyRevenue);
	const corners = selectedData.data.map(item => item.corner);
	const prices = selectedData.data.map(item => item.price);
	// 코너별 색상 지정
	const cornerColors = {
		"한식": 'rgba(255, 99, 132, 2)',
		"중식": 'rgba(54, 162, 235, 2)',
		"분식": 'rgba(75, 192, 192,2)',
		"스낵": 'rgba(153, 102, 255, 2)',
		"카페": 'rgba(255, 206, 86, 2)',
		"기타": 'rgba(201, 203, 207, 2)'
	};

	const backgroundColors = corners.map(corner => cornerColors[corner]);

	// 그래프 생성
	document.addEventListener("DOMContentLoaded", function() {
		const ctx = document.getElementById('foodcorner-chart').getContext('2d');
		new Chart(ctx, {
			type: 'bar',
			data: {
				labels: labels,
				datasets: [{
					label: '월간 매출액',
					data: data,
					backgroundColor: backgroundColors,
					borderColor: backgroundColors,
					borderWidth: 1
				}]
			},
			options: {
				responsive: true,
				maintainAspectRatio: false,
				plugins: {
					tooltip: {
						callbacks: {
							label: function(context) {
								const index = context.dataIndex;
								return `코너: ${corners[index]}, 메뉴: ${labels[index]}, 가격: ₩${prices[index]}, 월간 매출: ₩${data[index]}`;
							}
						}
					}
				},
				scales: {
					x: {
						title: {
							display: false
						}
					},
					y: {
						title: {
							display: true,
							text: '월간 매출액 (₩)'
						}
					}
				}
			}
		});
	});
} else {
	console.log("해당 휴게소의 데이터가 없습니다.");
}