// Existing map setup
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
var overlays = {}; // To store overlays by title for quick access

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
	overlay.setMap(null); // Initially hide overlay
	overlays[pos.title] = overlay; // Store overlay by title

	kakao.maps.event.addListener(marker, 'click', function() {
		closeAllOverlays();
		overlay.setMap(map); // Show overlay on marker click
		openOverlays.push(overlay); // Track open overlays
	});
});

var openOverlays = [];

function closeAllOverlays() {
	openOverlays.forEach(function(ov) {
		ov.setMap(null); // Hide each overlay in openOverlays
	});
	openOverlays = [];
}

function closeOverlay() {
	closeAllOverlays();
}

// Generate HTML list of markers
function createMarkerList() {
    var listContainer = document.getElementById('markerList');
    listContainer.innerHTML = ''; // Clear previous list
    var ul = document.createElement('ul');

    positions.forEach(function(pos) {
        var li = document.createElement('li');
        li.textContent = pos.title;
        li.style.cursor = "pointer"; // Make list items look clickable

        // Add click event for each list item
        li.onclick = function() {
            var overlay = overlays[pos.title];
            if (overlay) {
                closeAllOverlays(); // Close any currently open overlays
                overlay.setMap(map); // Show overlay for clicked list item
                openOverlays.push(overlay); // Track as open
                map.panTo(pos.latlng); // Center map on marker position
            }
        };

        ul.appendChild(li);
    });

    listContainer.appendChild(ul);
}

// Initialize marker list on page load
createMarkerList();
