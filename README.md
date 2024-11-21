# Comfort Guide
![image](https://github.com/user-attachments/assets/5ad75f50-f734-4a5b-b57c-c4cd420cd3a0)

## 📂 서비스 소개
* 서비스명 : 휴게소 관리자를 위한 종합정보 대시보드
* 서비스 설명 : 휴게소 관리자가 자신의 휴게소에 대한 관리 및 정보 등을 파악할 수 있으며 관리자가 아닌 일반 사람들도 자신이 가고자 하는 휴게소에 대한 검색을 통해 정보를 확인 가능
  
## 🗓️ 프로젝트 기간  
2024-10-07 ~ 2024-11-12 (6주)

##  주요기능
* 개발목표
  - 메인페이지에서 이벤트 중인 휴게소, 주유 가격 정보, 휴게소 위치에 대한 간단한 정보 제고
  - 휴게소 검색 페이지에서 시설물 현황, 날씨 정보, 휴게소 리뷰, 인기 판매 품목 정복 파악
  - 로그인 사용자에게 휴게소에 대한 매출 및 이용객 현황 등의 다양한 정보를 시각화
  - 데이터를 통해 휴게소 관리자는 비즈니스 지표를 한눈에 파악하여 경영 전략 수립에 도입
* 메인 페이지
  - 지역별 모든 휴게소 리스트 제공<br>
  - 지도에 휴게소 위치 마커 및 간략 정보 제공<br>
  - 이벤트 중인 휴게소 확인 가능

* 휴게소 검색 페이지
  - [시설물 정보 아이콘]을 통한 휴게소 내의 시설 유무를 간편하게 확인 가능<br>
  - 검색한 휴게소의 인기 품목 순위를 그래프로 한눈에 파악

* 글 작성 페이지
  - 오프라인 상 작성된 고객의 소리를 OCR 텍스트 추출을 통해 작성<br>
  - 고객의 소리 내용은 목록을 통해 확인 가능
    
* 관리자 페이지
  - 예측모델을 통한 휴게소의 매출액, 이용객, 통행량을 식각화하여 한눈에 파악<br>
  - 음식 코너의 매출액 그래프를 통해 고객의 선호도 확인<br>

## ⚒️ 기술스택
<table>
   <tr>
      <th>구분</th>
      <th>내용</th>
    </tr>
    <tr>
      <td>사용언어</td>
      <td>
  HTML, CSS, JavaScript, Java, Python
      </td>
    <tr>
     <td>사용 프레임워크</td>
      <td>
Mybatis, Flask
      </td>
    <tr>
    <td>개발도구</td>
    <td>
Visual StudioCode, Jupyter, Eclipse
    </td>
  <tr>
  <td>서버환경</td>
  <td>
Tomcat
  </td>
  <tr>
  <td>데이터 베이스</td>
  <td>
Oracle
  </td>
<tr>
 <td> 협업도구</td>
  <td>
  GitHub
  </td>
</tr>
</table>

## ⚙ 시스템 아키텍처

<details><summary>[이미지]
</summary>
<br>

< 데이터 분석 > 
![image](https://github.com/user-attachments/assets/2ba399ca-8675-4288-baa0-a90c4d713780)

< Flask >
![image](https://github.com/user-attachments/assets/4c99c265-99df-492b-90f7-924a102e5b94)

< JSP Servlet >
![image](https://github.com/user-attachments/assets/1b2ed7a7-0e03-43f0-856e-3beb0dfccf05)
</details>


## 📍 유스케이스

<details><summary>[이미지]
</summary>

![image](https://github.com/user-attachments/assets/02158d5c-9f8f-4cbd-9b2b-a1075bea9f8f) 
![image](https://github.com/user-attachments/assets/d2bc6ae2-7b5b-4f7c-8cad-0bb22c555f0b) 
</details>


## 📍 ER 다이어그램

<details><summary>[이미지]
</summary>

![image](https://github.com/user-attachments/assets/6e768193-05ad-4e7a-96e3-e06e58b5ccef)
</details>


## 🖥 화면 구성

<details><summary>[메인 페이지]
</summary>

![image](https://github.com/user-attachments/assets/e1bcb304-0dcf-45b2-b1af-2022a1697e87)![image](https://github.com/user-attachments/assets/9ba0b47b-6a14-4adc-8b17-215174e31ded)
  - 카카오 맵 API를 사용한 지도 구성

    1. 카카오 맵 API를 사용한 지도 불러오기
    2. 한국관광공사 휴게소 상세정보 CSV를 사용한 휴게소 위도 경도 데이터베이스 입력 및 불러오기
    3. 휴게소 위도 경도에 따른 마커 생성
    4. 휴게소 지역에 따른 리스트 구현
    5. 휴게소 이름에 따른 검색 구현
  - 한국도로공사 휴게소 이벤트 API를 사용한 이벤트 중인 휴게소 구성
  - Opinet API, CSV를 사용한 주유 가격 정보 구성

    1. Opinet API를 사용한 주유가격 정보
    2. Opinet CSV를 사용한 전기차 충전소, 등유 정보
  - 한국관광공사 데이터랩 CSV 데이터를 사용한 국내여행 횟수, 관광 지출액, 지역 방문자 증가율 구성
</details>
<details><summary>[휴게소 검색 페이지]
</summary>

![image](https://github.com/user-attachments/assets/4d3c5168-61db-4db2-9b4d-5a5110928ba8)
- 유튜브 크롤링을 통한 휴게소 유튜브 소개영상 구현
- 기상청 단기예보 API를 사용한 해당 지역 날씨정보 구현

    1. 데이터베이스 상 있는 휴게소 위도 경도 정보를 통한 해당 지역 날씨정보 구현
- 한국도로공사 휴게소 시설물 현황CSV를 사용한 휴게소 시설물 현황 구현

    1. 휴게소 시설물 현황 및 기타 CSV파일을 사용한 휴게소 시설물 현황 데이터베이스 입력
    2. Ajax를 사용한 지역별 휴게소 정보 불러오기 비동기 처리 및 불러온 값에 따른 화면 변환
    3. 해당 휴게소 시설물에 따른 아이콘 그레이아웃 효과
- 한국도로공사 휴게소별 인기판매 매장API를 사용한 휴게소 인기 판매 순위 구현
- 네이버 블로그 크롤링을 토안 방문후기 구현
</details>
<details><summary>[글 작성 페이지]
</summary>

![image](https://github.com/user-attachments/assets/8f5820b4-5d88-4a25-a36d-1c352ae8006f)
- 휴게소 고객의소리 글작성 페이지

    1. 휴게소 고객의 소리 작성
    2. 모든 항목 필수 작성 처리 및 미 작성 시 작성 버튼 미작동
    3. 지역 및 휴게소 선택 시 해당 휴게소 관리자만 확인 가능
    4. Tessaract 라이브러리 기반 OCR 기능
</details>
<details><summary>[로그인 / 회원가입 페이지]
</summary>

![image](https://github.com/user-attachments/assets/99afa285-c2ca-49a3-ae62-d292f8195e0e)

![image](https://github.com/user-attachments/assets/5ebff2fd-39e1-4442-a2d5-a551f4fe5429)
- 로그인 기능
- 회원가입 기능

    1. AJAX 기반 아이디 데이터베이스 중복 확인
    2. AJAX 기반 비밀빈호 확인 비동기 처리
</details>
<details><summary>[고객의 소리]
</summary>

![image](https://github.com/user-attachments/assets/71c79b2a-1c35-4c62-88ef-ee6ee988ca84)
- 글작성 페이지 휴게소에 선택된 휴게소 관리자만 확인 가능
- Tessaract 라이브러리 기반 OCR 기능
</details>
<details><summary>[관리자 페이지]
</summary>

![image](https://github.com/user-attachments/assets/7f592d9b-2bde-4c91-88ab-e2ed6a196721)

![image](https://github.com/user-attachments/assets/395d4e16-6c1f-4042-b087-1ebe0c9804c5)
- 관리자의 휴게소에 대한 이용객, 매출액, 교통량 그래프 제공

    1. 예측모델을 활용한 예측 그래프 제공
- 휴게소 매장 매출액 CSV기반 그래프 제공
- 크롤링 데이터를 통한 만족도, 감정분석 데이터

    1. 감정분석 모델을 사용한 크롤링 데이터 감정분석
    2. 파이썬 Flask를 활용한 GET 방식으로 데이터 가져오기
- 식중독, 감기, 부패, 미세먼지 환경정보 제공

    1. OpenWeatehr, 기상청 단기예보 API를 활용한 환경정보 제공
    2. 현재 지원하고 있지 않은 감기가능지수, 부패가능지수 산출 데이터를 기반한 기능 구현
</details>



## 🎬 시연영상

<details><summary>영상
</summary>

![컴포트가이트_핵심_영상(용량줄임)](https://github.com/user-attachments/assets/92d139a6-1bed-4f76-ac57-36f489ad1799)
</details>

## 📄 역할
<table>
   <tr>
      <th>이름</th>
      <th>역할</th>
      <th>상세내용</th>
    </tr>
    <tr>
      <td>배성현</td>
      <td>Full-stack, 팀장</td>
      <td>
         ■ 프로젝트 발표 <br> 
         ■ 문서(요구사항 정의서, 브레인 스토밍, 프로젝트 기획서)  <br>      
         ■ 페이지구현(자바)  <br>
          - 메인페이지(전체)<br>
          - 글쓰기 및 고객의소리 관리(전체)<br>
          - 휴게소 검색페이지(지역검색, 유튜브 소개영상, 시설 확인, 방문후기, 날씨정보)<br>
          - 회원가입 및 로그인<br>
          - 관리자 페이지(만족도, 감정분석, 식중독, 감기, 부패, 미세먼지 환경정보, 고객의소리)<br>
         ■ 파이썬(Flask)<br>
          - BERT 기반 감정 분석 모델을 활용한 관리자 페이지 만족도 구현<br>
          - 네이버 블로그 크롤링을 활용한 방문 후기 정보 구현<br>
     </td>
    </tr>
<tr>
      <td>정현지</td>
      <td>Front-end</td>
      <td>
         ■ 문서(화면설계서, 시연 포스터, ppt 제작)  <br>      
         ■ 페이지구현  <br>
          - 웹페이지 화면 구성(전체)<br>
     </td>
    </tr>
<tr>
 <td>이석열</td>
      <td>Back-end</td>
      <td>
         ■ 문서(시스템 아키텍쳐, 메뉴 구성도, 플로우 차트, 시연 영상 제작)  <br>      
         ■ 페이지구현  <br>
          - 검색 페이지 화면 구성(휴게소별 인기 판매 품목)<br>
          - 관리자 페이지 화면 구성(매출액, 교통량, 이용객 그래프, 음식코너 매출액)<br>
     </td>
</tr>
 <td>노유빈</td>
      <td>DB</td>
      <td>
         ■ 문서(테이블 명세서, 데이터베이스 요구사항 정의서, 시연 영상 제작)  <br>      
         ■ DB설계  <br>
          - 회원가입, 휴게소, 관광지 DB 설계<br>
         ■ 자료 수집  <br>
          - 휴게소 유튜브 후기 크롤링<br>
     </td>
</tr>
</table>

## 💣 트러블 슈팅


<details><summary>휴게소 감기가능지수 API 및 CSV, 식중독 가능지수 데이터 생산 종료
</summary>

- **문제점**

![image](https://github.com/user-attachments/assets/9b2575ce-a060-421f-a51f-1906aeae386e)
참고자료 : https://data.kma.go.kr/data/lwi/hwiRltmList.do?pgmNo=642

1. 기존 CSV 및 API 데이터가 2022년 부로 생산이 종료된 것을 확인
2. 감기 가능지수 및 식중독 가능 지수를 산출하는 방법 탐색

<br>

- **해결 방안**
![image](https://github.com/user-attachments/assets/df88449c-9b37-41b7-b540-c8875da4c205)
![image](https://github.com/user-attachments/assets/4e604feb-3353-4f73-b400-76ba45c190b4)
1. DB에서 불러온 위도 및 경도, 검색창에서 선택된 지역을 JS에 가져옴.
2. 감기 가능지수 및 식중독 가능 지수 산출 데이터를 JS로 구현
</details>





    
