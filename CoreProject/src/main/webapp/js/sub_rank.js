$(document).ready(function () {
    // 휴게소 선택 시 랭킹 정보 가져오기
    $('#restStop').on('change', function () {
        const saName = $(this).val();

        // saName 값이 비어 있을 경우 아무 작업도 하지 않음
        if (!saName) {
            console.log("No restStop selected.");
            return;
        }

        // AJAX를 통해 서버에서 랭킹 정보를 가져옵니다.
        $.ajax({
            url: 'SaRanking',  // Controller의 매핑 URL
            method: 'GET',
            data: { restStop: saName },
            dataType: 'json',
            success: function (rankData) {
                console.log("Received ranking data:", rankData);
                if (rankData && rankData.length > 0) {
                    // 받은 랭킹 데이터를 화면에 표시하는 함수 호출
                    displayRankingData(rankData);
                    
                    // 도넛 차트를 생성하는 함수 호출
                    createDonutChart(rankData);
                } else {
                    console.log("No ranking data found.");
                    $('#rankingContainer').html('<p>No data available</p>');  // 데이터가 없을 때 표시
                }
            },
            error: function (xhr, status, error) {
                console.error("데이터 가져오기 오류:", xhr.responseText);
            }
        });
    });

    // 랭킹 데이터를 화면에 표시하는 함수
	function displayRankingData(rankData) {
	    const rankingContainer = $('#rankingContainer');
	    rankingContainer.empty();

	    // rankData 리스트를 순회하며 각 항목을 HTML로 추가
	    rankData.forEach(function (item, index) {
	        const rankingItem = `
	            <div class="ranking-item-box">
	                <p class="ranking-item-title">${index + 1}. 매장 이름: <span class="truncate">${item.store_name}</span></p>
	                <p class="ranking-item-sales">월 매출: ${item.monthly_sales.toLocaleString()}원</p>
	            </div>
	        `;
	        rankingContainer.append(rankingItem);
	    });
	}

    // 도넛 차트를 생성하는 함수
    function createDonutChart(rankData) {
        const labels = rankData.map(item => item.store_name); // 품목 이름
        const salesData = rankData.map(item => item.monthly_sales); // 판매량 데이터

        const ctx = document.getElementById('donutChart').getContext('2d');
        new Chart(ctx, {
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
                    },
                    tooltip: {
                        callbacks: {
                            label: function(context) {
                                const label = context.label || '';
                                const value = context.raw || 0;
                                return `${label}: ${value} sales`;
                            }
                        }
                    }
                }
            }
        });
    }
});
