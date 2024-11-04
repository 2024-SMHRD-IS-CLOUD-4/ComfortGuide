document.addEventListener('DOMContentLoaded', function() {
        var sentimentDiv = document.getElementById('sentiment');
        sentimentDiv.innerHTML = `
            Positive: ${positive}%<br>
            Negative: ${negative}%<br>
            Neutral: ${neutral}%
        `;
    });