document.addEventListener("DOMContentLoaded", function() {
	// Select 요소에 change 이벤트 리스너 추가
	document.getElementById("restStop").addEventListener("change", function() {
		const restStopName = this.value;
		if (restStopName) {
			fetchVideo(restStopName);
		} else {
			document.getElementById("videoContainer").innerHTML = "▶";
		}
	});
});

function fetchVideo(restStopName) {
	// AJAX 요청으로 LinkController 호출
	$.ajax({
		url: "LinkController", // 서버의 LinkController URL
		type: "GET",
		data: {
			restStop: restStopName
		},
		dataType: "json",
		success: function(response) {
			console.log("Response:", response); // 응답 데이터 확인
			if (response.video_link) {
				// 유니코드 인코딩된 \u003d을 =로 복원
				const videoLink = response.video_link.replace("\\u003d", "=");

				// videoId 초기화
				let videoId = null;

				// video_link 형식에 따라 videoId 추출
				if (videoLink.includes("v=")) {
					videoId = videoLink.split("v=")[1];
					if (videoId.includes("&")) {
						videoId = videoId.split("&")[0]; // 추가 파라미터가 있을 경우 첫 부분만 추출
					}
				} else if (videoLink.includes("youtu.be/")) {
					videoId = videoLink.split("youtu.be/")[1];
				}

				console.log("Extracted videoId:", videoId); // 추출된 videoId 확인

				if (videoId) {
					// YouTube embed URL 형식에 videoId를 사용하여 iframe 생성
					const embedHtml = `<iframe 
                                           src="https://www.youtube.com/embed/${videoId}" 
                                           frameborder="0" allow="accelerometer; autoplay; 
                                           clipboard-write; encrypted-media; gyroscope; 
                                           picture-in-picture" allowfullscreen>
                                           </iframe>`;
					document.getElementById("videoContainer").innerHTML = embedHtml;
				} else {
					alert("YouTube video ID를 추출할 수 없습니다.");
				}
			} else {
				alert("해당 휴게소에 대한 영상이 없습니다.");
			}
		},
		error: function(xhr, status, error) {
			console.log("AJAX error:", error); // 오류 로그 확인
			alert("서버와의 통신에 문제가 발생했습니다.");
		}
	});
}