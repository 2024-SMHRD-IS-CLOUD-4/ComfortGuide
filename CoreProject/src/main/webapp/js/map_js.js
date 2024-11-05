/*global kakao */
var mapContainer = document.getElementById('map'),
	mapOption = {
		center: new kakao.maps.LatLng(36.349296, 127.398433),
		level: 11
	};

var map = new kakao.maps.Map(mapContainer, mapOption);


var imageSrc = "images/pngwing.com.png";
var imageSize = new kakao.maps.Size(30, 30);
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

positions.forEach(function(pos) {
	var marker = new kakao.maps.Marker({
		map: map,
		position: pos.latlng,
		title: pos.title,
		image: markerImage
	});

	var overlay = new kakao.maps.CustomOverlay({
		content: pos.content,
		position: pos.latlng
	});
	overlay.setMap(null);

	kakao.maps.event.addListener(marker, 'click', function() {
		closeAllOverlays();
		overlay.setMap(map);
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
