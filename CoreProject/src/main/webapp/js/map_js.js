var mapContainer = document.getElementById('map'),
    mapOption = {
        center: new kakao.maps.LatLng(36.349296, 127.398433),
        level: 11
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

var imageSrc = "images/pngwing.com.png";
var imageSize = new kakao.maps.Size(30, 30);
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

var markers = [];
var overlays = {}; // 제목으로 오버레이를 저장

// 마커 및 오버레이 생성
positions.forEach(function(pos) {
    var marker = new kakao.maps.Marker({
        map: map,
        position: pos.latlng,
        title: pos.title,
        image: markerImage
    });

    markers.push(marker);

    var overlay = new kakao.maps.CustomOverlay({
        content: pos.content,
        position: pos.latlng
    });
    overlay.setMap(null); // 처음엔 오버레이 숨김
    overlays[pos.title] = overlay; // 제목으로 오버레이 저장

    kakao.maps.event.addListener(marker, 'click', function() {
        closeAllOverlays();
        overlay.setMap(map); // 마커 클릭 시 오버레이 표시
        openOverlays.push(overlay);
    });
});

var openOverlays = [];

function closeAllOverlays() {
    openOverlays.forEach(function(ov) {
        ov.setMap(null);
    });
    openOverlays = [];
}

function closeOverlay() {
    closeAllOverlays();
}

// 검색 기능 구현
function searchMarker() {
    var searchKeyword = document.getElementById('searchInput').value.trim();
    var foundMarker = null;

    markers.forEach(function(marker) {
        if (marker.getTitle().includes(searchKeyword)) { // 제목에 검색어 포함 여부 확인
            foundMarker = marker;
        }
    });

    if (foundMarker) {
        var position = foundMarker.getPosition();
        map.panTo(position); // 해당 마커 위치로 지도 이동

        closeAllOverlays(); // 기존 오버레이 닫기
        var overlay = overlays[foundMarker.getTitle()];
        if (overlay) {
            overlay.setMap(map); // 해당 마커의 오버레이 표시
            openOverlays.push(overlay); // 오픈된 오버레이 목록에 추가
        }
    } else {
        alert("일치하는 장소를 찾을 수 없습니다.");
    }
}

// 마커 리스트 생성 함수
function createMarkerList() {
    var listContainer = document.getElementById('markerList');
    listContainer.innerHTML = ''; // 기존 리스트 초기화
    var ul = document.createElement('ul');

    positions.forEach(function(pos) {
        var li = document.createElement('li');
        li.textContent = pos.title;
        li.style.cursor = "pointer";

        li.onclick = function() {
            var overlay = overlays[pos.title];
            if (overlay) {
                closeAllOverlays();
                overlay.setMap(map); // 리스트 아이템 클릭 시 오버레이 표시
                openOverlays.push(overlay);
                map.panTo(pos.latlng); // 해당 마커 위치로 이동
            }
        };

        ul.appendChild(li);
    });

    listContainer.appendChild(ul);
}

// 페이지 로드 시 마커 리스트 초기화
createMarkerList();