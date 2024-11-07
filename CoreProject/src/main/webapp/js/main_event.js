async function fetchData() {
    try {
        const response = await fetch('https://data.ex.co.kr/openapi/restinfo/restEventList?key=5529045187&type=xml&numOfRows=50&pageNo=1');
        const textData = await response.text();

        const parser = new DOMParser();
        const xmlDoc = parser.parseFromString(textData, "application/xml");

        // XML 파싱 결과 확인
        const parserError = xmlDoc.getElementsByTagName("parsererror");
        if (parserError.length) {
            throw new Error("XML 파싱 오류");
        }

        const listItems = xmlDoc.getElementsByTagName("list");
        let html = '';

        for (let i = 0; i < listItems.length; i++) {
            // 각 태그를 안전하게 가져오는 함수
            const getTagContent = (tagName) => {
                const element = listItems[i].getElementsByTagName(tagName)[0];
                return element ? element.textContent : "정보 없음";
            };

            const eventNm = getTagContent("eventNm");
            const eventDetail = getTagContent("eventDetail");
            const stdRestNm = getTagContent("stdRestNm");
            const routeNm = getTagContent("routeNm");
            const stime = getTagContent("stime");
            const etime = getTagContent("etime");

            const endDate = new Date(etime);
            const today = new Date();

            if (endDate > today) {
                html += `<tr><td>${stdRestNm}</td><td>${eventNm} : ${eventDetail}</td><td>${stime}<br>${etime}</td></tr>`;
            }
        }

        document.getElementById("table-card").querySelector("tbody").innerHTML = html;
    } catch (error) {
        console.error("데이터를 불러오는 중 오류가 발생했습니다:", error);
        document.getElementById("table-card").querySelector("tbody").innerHTML =
            "<tr><td colspan='6'>데이터를 불러오는 중 오류가 발생했습니다.</td></tr>";
    }
}

// fetchData 함수 호출
fetchData();
