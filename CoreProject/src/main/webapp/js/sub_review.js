$(document).ready(function() {
    $('#restStop').on('change', function() {
        const selectedRestStop = $(this).val();

        if (selectedRestStop && selectedRestStop !== "휴게소 이름") {
            $.ajax({
                url: 'reviewController', // Java 서블릿 엔드포인트
                method: 'GET',
                data: { restStop: selectedRestStop },
                success: function(data) {
                    const reviewsContainer = $('#reviews-container');
                    reviewsContainer.empty(); // 기존 내용 삭제

                    // 최대 8개의 리뷰만 출력
                    data.slice(0, 50).forEach(review => {
                        const reviewDiv = `
                            <div class="review-item">
                                <p><strong>제목:</strong> <a href="${review.link}" target="_blank">${review.title}</a></p>
                                <p>${review.content}</p>
                            </div>
                        `;
                        reviewsContainer.append(reviewDiv);
                    });
                },
                error: function(error) {
                    console.error("데이터를 불러오는 중 오류 발생:", error);
                    $('#reviews-container').html("<p>데이터를 불러오는 중 오류가 발생했습니다.</p>");
                }
            });
        }
    });
});
