$(document).ready(function () {
    // 휴게소 선택 시 랭킹 정보 가져오기
    $('#restStop').on('change', function () {
        const saName = $(this).val();
      console.log('선택된 휴게소: ', saName);

        // saName 값이 비어 있을 경우 아무 작업도 하지 않음
        if (!saName) {
            console.log("No restStop selected.");
            return;
        }
      if (saName) {
        // AJAX를 통해 서버에서 랭킹 정보를 가져옵니다.
        $.ajax({
            url: 'SaRanking',  // Controller의 매핑 URL
            method: 'GET',
            data: { restStop: saName },
            dataType: 'json',
            success: function (rankData) {
            console.log("수신된 랭킹 데이터:", rankData);
                if (rankData && rankData.length > 0) {
               createDonutChart(rankData);  // 데이터로 도넛 차트 생성
                    // 받은 랭킹 데이터를 화면에 표시하는 함수 호출
                    displayRankingData(rankData);
                    
                    // 도넛 차트를 생성하는 함수 호출
                    createDonutChart(rankData);
                } else {
                    console.log("No ranking data found.");
					if (window.myDonutChart) {
						 window.myDonutChart.destroy();
						    }
					
                    $('#rankingContainer').html('<p>No data available</p>');  // 데이터가 없을 때 표시
					if (window.myDonutChart) {
					  	window.myDonutChart.destroy();  // 기존 차트 제거
					                   }
                }
            },
            error: function (xhr, status, error) {
                console.error("데이터 가져오기 오류:", xhr.responseText);
            }
        });
      }
    });

	function createDonutChart(rankData) {
	    if (window.myDonutChart) {
	        window.myDonutChart.destroy();
	    }

	    // 맨 처음에는 랭킹 데이터 리스트를 화면에 표시
	    updateRankingData(rankData.map(item => item.store_name), rankData.map(item => item.monthly_sales));

	    const labels = rankData.map(item => item.store_name); // 매장이름
	    const salesData = rankData.map(item => item.monthly_sales); // 판매액

	    const ctx = document.getElementById('donutChart').getContext('2d');
	    window.myDonutChart = new Chart(ctx, {
	        type: 'doughnut',
	        data: {
	            labels: labels,
	            datasets: [{
	                label: 'Monthly Sales',
	                data: salesData,
	                backgroundColor: [
	                    'rgba(255, 99, 132, 0.6)',
	                    'rgba(54, 162, 235, 0.6)',
	                    'rgba(255, 206, 86, 0.6)',
	                    'rgba(75, 192, 192, 0.6)',
	                    'rgba(153, 102, 255, 0.6)',
	                    'rgba(255, 159, 64, 0.6)'
	                ],
	                borderWidth: 1
	            }]
	        },
	        options: {
	            responsive: true,
	            plugins: {
	                legend: {
	                    position: 'top',
	                    onClick: function (event, legendItem) {
	                        const chart = this.chart;
	                        const index = legendItem.index;
	                        const dataset = chart.data.datasets[0];

	                        // 클릭 시 해당 데이터셋 토글
	                        dataset.data[index] = dataset.data[index] === null ? rankData[index].monthly_sales : null;

	                        // 차트 다시 그리기
	                        chart.update();

	                        // 랭킹 데이터 갱신
	                        updateRankingData(chart.data.labels, dataset.data);
	                    }
	                },
	                tooltip: {
	                    callbacks: {
	                        label: function (context) {
	                            const label = context.label || '';
	                            const value = context.raw || 0;
	                            return `${label}: ${value} 원`;
	                        }
	                    }
	                }
	            }
	        }
	    });
	}

	// 랭킹 데이터를 화면에 표시하는 함수
	function updateRankingData(labels, salesData) {
	    const rankingContainer = $('#rankingContainer');
	    rankingContainer.empty();

	    const filteredData = labels.map((label, index) => ({
	        store_name: label,
	        monthly_sales: salesData[index]
	    })).filter(item => item.monthly_sales !== null); // 판매액이 null인 항목은 제외

	    filteredData.forEach(function (item, index) {
	        const rankingItem = `
	            <table class="ranking-table">
	                <tr>
	                    <td rowspan="2" style="text-align: center;">${index + 1}</td>
	                    <td class="truncate" style="text-align: center;">매장이름: ${item.store_name}</td>
	                </tr>
	                <tr>
	                    <td style="text-align: center;">${item.monthly_sales.toLocaleString()}원</td>
	                </tr>
	            </table>
	            <hr />
	        `;
	        rankingContainer.append(rankingItem);
	    });
	}

});
