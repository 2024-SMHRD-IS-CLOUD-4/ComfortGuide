$(document).ready(function () {
        // 휴게소 선택 시 시설 정보 가져오기
        $('#restStop').on('change', function () {
            const saName = $(this).val();

            // name 값이 비어 있을 경우 아무 작업도 하지 않음
            if (!saName) {
                console.log("No restStop selected.");
                return;
            }

            // AJAX를 통해 서버에서 시설 정보를 가져옵니다.
            $.ajax({
                url: 'getFacility',
                method: 'GET',
                data: { restStop: saName },  // 파라미터 이름을 'restStop'으로 맞춤
                dataType: 'json',
                success: function (facilityDetails) {
                    console.log("Received facility details:", facilityDetails);
                    if (facilityDetails) {
                        // 시설 정보를 기반으로 배경색 설정
                        setFacilityBackground(facilityDetails);
                    } else {
                        console.log("No facility details found.");
                    }
                },
                error: function (xhr, status, error) {
                    console.error("데이터 가져오기 오류:", xhr.responseText);
                }
            });
        });

        // 시설 정보를 기반으로 배경색을 설정하는 함수
        function setFacilityBackground(facilityDetails) {
			const facilities = {
			        drugStore: facilityDetails.is_drug_store,
			        nursingRoom: facilityDetails.is_nursing_room,
			        evCharge: facilityDetails.is_ev_charge,
			        restaurant: facilityDetails.is_restaurant,
			        lpgStation: facilityDetails.is_lpg_station,
			        gasStation: facilityDetails.is_gas_station,
			        snackBar: facilityDetails.is_snack_bar,
			        breakRoom: facilityDetails.is_break_room,
			        carMaintenance: facilityDetails.is_car_maintenance,
			        hydrogenCharge: facilityDetails.is_hydrogen_charge,  // 여기를 수정
			        restRoom: facilityDetails.is_rest_room
			    };

            // 각 시설의 배경색 설정
            $.each(facilities, function (facilityId, availability) {
                const facilityElement = $('#' + facilityId);
                if (facilityElement.length) { // 요소가 존재하는지 확인
                    facilityElement.css('background-color', availability === "Y" ? 'white' : 'gray');
                }
            });
        }
    });