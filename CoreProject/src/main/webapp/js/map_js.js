var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(36.349296, 127.398433),
        level: 11
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

var imageSrc = "https://drive.google.com/thumbnail?id=1LoqoKvreDu8FjhTG__GGBcsbpBgrb6_O";
var imageSize = new kakao.maps.Size(30, 30);
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

var markers = [];
var overlays = {}; // 제목으로 오버레이를 저장
var openOverlay = null; // 현재 열려 있는 오버레이를 추적

// 모든 마커와 오버레이를 제거하는 함수
function clearMarkers() {
    markers.forEach(function(marker) {
        marker.setMap(null); // 지도에서 마커 제거
    });
    markers = []; // 마커 배열 초기화
    closeOverlay(); // 모든 오버레이 닫기
}

// 현재 열려 있는 오버레이를 닫는 함수
function closeOverlay() {
    if (openOverlay) {
        openOverlay.setMap(null); // 열려 있는 오버레이가 있으면 닫기
        openOverlay = null;
    }
}

// 특정 지역에 따라 마커와 리스트를 생성하고 표시하는 함수
function updateMarkersAndList(region) {
    clearMarkers(); // 이전 마커 제거

    var listContainer = document.getElementById('markerList');
    listContainer.innerHTML = ''; // 기존 리스트 초기화
    var ul = document.createElement('ul');

    // 선택된 지역에 따라 positions 배열 필터링
    var filteredPositions = positions.filter(function(pos) {
        return region === "" || pos.region === region;
    });

    // 마커와 리스트 업데이트
    filteredPositions.forEach(function(pos) {
        // 마커 생성
        var marker = new kakao.maps.Marker({
            map: map,
            position: pos.latlng,
            title: pos.title,
            image: markerImage
        });
        markers.push(marker);

        // 오버레이 생성 및 저장
        var overlay = new kakao.maps.CustomOverlay({
            content: pos.content,
            position: pos.latlng
        });
        overlay.setMap(null); // 처음엔 오버레이 숨김
        overlays[pos.title] = overlay; // 제목으로 오버레이 저장

        // 마커 클릭 시 오버레이 표시
        kakao.maps.event.addListener(marker, 'click', function() {
            closeOverlay(); // 이전 오버레이 닫기
            overlay.setMap(map); // 클릭한 마커의 오버레이 표시
            openOverlay = overlay; // 현재 오버레이로 설정
        });

        // 리스트 아이템 생성
        var li = document.createElement('li');
        li.textContent = pos.title;
        li.style.cursor = "pointer";

        li.onclick = function() {
            closeOverlay(); // 이전 오버레이 닫기
            overlay.setMap(map); // 리스트 아이템 클릭 시 오버레이 표시
            openOverlay = overlay; // 현재 오버레이로 설정
            map.panTo(pos.latlng); // 해당 마커 위치로 이동
        };

        ul.appendChild(li);
    });

    listContainer.appendChild(ul);
}

// 검색 기능 구현 (전체 positions 배열을 검색)
function searchMarker() {
    var searchKeyword = document.getElementById('searchInput').value.trim();

    // 전체 positions 배열에서 검색어가 포함된 항목 찾기
    var foundPosition = positions.find(function(pos) {
        return pos.title.includes(searchKeyword);
    });

    if (foundPosition) {
        // 검색된 위치의 오버레이 찾기
        var foundOverlay = overlays[foundPosition.title];

        if (foundOverlay) {
            var position = foundPosition.latlng;
            map.panTo(position); // 해당 위치로 지도 이동

            closeOverlay(); // 기존 오버레이 닫기
            foundOverlay.setMap(map); // 해당 위치의 오버레이 표시
            openOverlay = foundOverlay; // 현재 오버레이로 설정
        }
    } else {
        alert("일치하는 장소를 찾을 수 없습니다.");
    }
}

// 지역 선택 시 마커와 리스트를 업데이트
document.getElementById('region').addEventListener('change', function() {
    var selectedRegion = this.value;
    updateMarkersAndList(selectedRegion);
});

// 페이지 로드 시 모든 지역의 마커와 리스트 초기화
updateMarkersAndList(""); // 모든 지역 표시
