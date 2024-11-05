
// 지역
$(document).ready(function() {
        $('#region').on('change', function() {
            const selectedRegion = $(this).val();
            const restStopSelect = $('#restStop');

            // 기존 옵션 초기화
            restStopSelect.html('<option value="">휴게소 선택</option>');

            // 지역이 선택되었을 때만 AJAX 요청 보내기
            if (selectedRegion) {
                $.ajax({
                    url: 'getRestStops',  // 서버에서 처리할 엔드포인트 URL
                    type: 'GET',
                    data: { region: selectedRegion },
                    success: function(data) {
                        // JSON 데이터를 받아서 휴게소 목록 추가
                        data.forEach(function(sa_name) {
                            const option = $('<option>').val(sa_name).text(sa_name);
                            restStopSelect.append(option);
                        });
                    },
                    error: function() {
                        alert('휴게소 정보를 불러오는 데 실패했습니다.');
                    }
                });
            }
        });
    });