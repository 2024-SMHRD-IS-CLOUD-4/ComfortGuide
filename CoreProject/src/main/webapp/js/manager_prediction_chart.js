$(document).ready(function(){
	// CSV 파싱 함수

	function parseCSV(csv) {
	    const [headerLine, ...lines] = csv.trim().split('\n');
	    const headers = headerLine.split(',');
	    return lines.map(line => {
	        const values = line.split(',');
	        return headers.reduce((obj, header, i) => {
	            obj[header.trim()] = isNaN(values[i]) ? values[i].trim() : +values[i];
	            return obj;
	        }, {});
	    });
	}
	

	let filteredData = [];

$.ajax({
   url: 'managerChratController',
   type: 'GET',
   success: function(saName) {
	
			console.log("서비스 구역 이름:", saName);
			
			const csvData = `
			Year,Region,Annual_Revenue,Annual_Traffic_Volume,Annual_Visitors
			2015,강천산(광주),66655,27190,44811
			2016,강천산(광주),52636,25288,49946
			2017,강천산(광주),73713,29350,47272
			2018,강천산(광주),63653,23452,42194
			2019,강천산(광주),54438,31310,46671
			2020,강천산(광주),62762,22917,53000
			2021,강천산(광주),55044,25642,44773
			2022,강천산(광주),68177,24861,43371
			2023,강천산(광주),65453,27322,49504
			2024,강천산(광주),67623,24538,47393
			2015,강천산(대구),61224,25257,45178
			2016,강천산(대구),54307,26664,47201
			2017,강천산(대구),54937,27412,44715
			2018,강천산(대구),65979,28110,49811
			2019,강천산(대구),73116,22964,51156
			2020,강천산(대구),61143,23918,46330
			2021,강천산(대구),63593,26347,43447
			2022,강천산(대구),71550,27420,41622
			2023,강천산(대구),75406,31167,54974
			2024,강천산(대구),64457,23394,54363
			2015,거창(광주),62991,29402,50201
			2016,거창(광주),72048,27133,52652
			2017,거창(광주),65707,30878,49801
			2018,거창(광주),68276,31133,42549
			2019,거창(광주),57298,28739,43408
			2020,거창(광주),78395,25116,45501
			2021,거창(광주),78259,30078,58361
			2022,거창(광주),71585,23943,58570
			2023,거창(광주),63878,28302,53835
			2024,거창(광주),64620,27808,53712
			2015,거창(대구),68108,23319,50644
			2016,거창(대구),74344,24380,48441
			2017,거창(대구),62781,31045,52483
			2018,거창(대구),68312,24182,51829
			2019,거창(대구),61211,26283,46050
			2020,거창(대구),70078,27710,48153
			2021,거창(대구),68237,23336,41843
			2022,거창(대구),68522,26636,52300
			2023,거창(대구),81280,28674,44688
			2024,거창(대구),72969,22752,46907
			2015,논공(광주),65190,30688,45514
			2016,논공(광주),60213,25942,45914
			2017,논공(광주),73033,23370,43534
			2018,논공(광주),62764,24895,58666
			2019,논공(광주),71869,26429,43151
			2020,논공(광주),71180,23579,41580
			2021,논공(광주),73436,27030,53706
			2022,논공(광주),67730,28444,45975
			2023,논공(광주),58849,27985,45226
			2024,논공(광주),61112,25006,49263
			2015,논공(대구),63314,22597,46012
			2016,논공(대구),51044,27838,41298
			2017,논공(대구),58389,26336,45540
			2018,논공(대구),75766,22812,50490
			2019,논공(대구),65380,23139,51750
			2020,논공(대구),64512,28222,53227
			2021,논공(대구),79837,29701,47361
			2022,논공(대구),64066,29081,52399
			2023,논공(대구),69839,21963,49057
			2024,논공(대구),60793,26933,48694
			2015,지리산(광주),71612,27031,53044
			2016,지리산(광주),62576,23725,47160
			2017,지리산(광주),65526,27193,60288
			2018,지리산(광주),65360,23695,47476
			2019,지리산(광주),62595,27461,41600
			2020,지리산(광주),66053,26610,50319
			2021,지리산(광주),61717,25576,42174
			2022,지리산(광주),62400,24777,51223
			2023,지리산(광주),58049,28246,56526
			2024,지리산(광주),52051,27316,52506
			2015,지리산(대구),61454,25159,48524
			2016,지리산(대구),63683,25390,40935
			2017,지리산(대구),73201,29028,45177
			2018,지리산(대구),56012,27565,46345
			2019,지리산(대구),66569,25363,52578
			2020,지리산(대구),70198,24298,42374
			2021,지리산(대구),55247,27799,43330
			2022,지리산(대구),62311,24637,48918
			2023,지리산(대구),52928,26694,51753
			2024,지리산(대구),66218,25385,49656
			2015,함평나비(광주),68257,18935,58796
			2016,함평나비(광주),68198,24490,47254
			2017,함평나비(광주),68878,25895,39191
			2018,함평나비(광주),79189,25910,54194
			2019,함평나비(광주),61095,30225,50585
			2020,함평나비(광주),69634,23461,55133
			2021,함평나비(광주),70165,29610,46088
			2022,함평나비(광주),62480,32236,43964
			2023,함평나비(광주),64745,29178,49658
			2024,함평나비(광주),69464,25153,50997
			2015,함평나비(무안),57062,30544,48596
			2016,함평나비(무안),61173,27945,46911
			2017,함평나비(무안),56880,22671,52589
			2018,함평나비(무안),64590,25849,54477
			2019,함평나비(무안),58241,24285,47284
			2020,함평나비(무안),66257,26089,47766
			2021,함평나비(무안),65233,25918,45638
			2022,함평나비(무안),60301,26919,44796
			2023,함평나비(무안),58041,25381,48402
			2024,함평나비(무안),80450,24353,53816
			2015,영천(대구),70542,23084,52980
			2016,영천(대구),57867,19232,52159
			2017,영천(대구),54112,27381,45813
			2018,영천(대구),76531,28999,46947
			2019,영천(대구),61123,23019,47009
			2020,영천(대구),63797,25244,49948
			2021,영천(대구),69435,27116,45419
			2022,영천(대구),56200,29775,45786
			2023,영천(대구),61356,24834,40113
			2024,영천(대구),62500,24943,52228
			2015,청통(대구),70222,26209,53760
			2016,청통(대구),67869,26158,49968
			2017,청통(대구),64386,25165,47860
			2018,청통(대구),58234,26934,44293
			2019,청통(대구),71162,25546,49420
			2020,청통(대구),68879,27885,41453
			2021,청통(대구),64280,28506,40826
			2022,청통(대구),68180,20290,44149
			2023,청통(대구),65891,21859,44330
			2024,청통(대구),55977,30518,49985
			2015,영천(포항),69361,25616,47439
			2016,영천(포항),55027,25435,45432
			2017,영천(포항),71269,29189,56389
			2018,영천(포항),71234,24631,43689
			2019,영천(포항),70670,27133,40480
			2020,영천(포항),67971,28334,49467
			2021,영천(포항),64423,24083,42063
			2022,영천(포항),70891,25390,48029
			2023,영천(포항),77011,27993,51001
			2024,영천(포항),66570,30182,57633
			2015,와촌(포항),71739,27725,38876
			2016,와촌(포항),66450,25859,49639
			2017,와촌(포항),71828,19022,46377
			2018,와촌(포항),67409,24976,42209
			2019,와촌(포항),71341,26925,44401
			2020,와촌(포항),67704,28352,49203
			2021,와촌(포항),70892,26405,47233
			2022,와촌(포항),58027,25974,50132
			2023,와촌(포항),71386,25898,51426
			2024,와촌(포항),59306,24149,48634
			2015,공주(당진),58715,28349,51455
			2016,공주(당진),67470,27087,59116
			2017,공주(당진),62560,20432,50157
			2018,공주(당진),65305,24844,44363
			2019,공주(당진),62755,26675,46704
			2020,공주(당진),81472,23683,45277
			2021,공주(당진),50616,26858,39261
			2022,공주(당진),62097,25477,45687
			2023,공주(당진),77051,28805,55664
			2024,공주(당진),59846,29156,51616
			2015,공주(대전),70701,28897,44708
			2016,공주(대전),62852,28459,36117
			2017,공주(대전),75571,27649,48952
			2018,공주(대전),67085,23501,47456
			2019,공주(대전),72860,29600,62436
			2020,공주(대전),65152,24474,46648
			2021,공주(대전),58955,25995,51059
			2022,공주(대전),65413,29072,48025
			2023,공주(대전),63357,24677,41148
			2024,공주(대전),55347,23110,55577
			2015,예산(당진),71514,29802,42626
			2016,예산(당진),52716,24470,50042
			2017,예산(당진),68911,28945,50575
			2018,예산(당진),77076,25616,44687
			2019,예산(당진),54602,23870,50368
			2020,예산(당진),59804,28654,56122
			2021,예산(당진),50084,28463,38163
			2022,예산(당진),68273,29409,49496
			2023,예산(당진),57238,24666,47890
			2024,예산(당진),64441,25668,48637
			2015,예산(대전),67039,23033,47987
			2016,예산(대전),75603,25192,46994
			2017,예산(대전),72715,19494,54987
			2018,예산(대전),61490,26629,49651
			2019,예산(대전),71824,25498,45843
			2020,예산(대전),74156,20005,49277
			2021,예산(대전),56790,24204,59068
			2022,예산(대전),65345,26711,40416
			2023,예산(대전),60852,26714,50922
			2024,예산(대전),69687,26222,51769
			2015,고성공룡나라(대전),68616,21406,49359
			2016,고성공룡나라(대전),70678,27745,47388
			2017,고성공룡나라(대전),60350,23269,48532
			2018,고성공룡나라(대전),73075,21086,45932
			2019,고성공룡나라(대전),58156,28256,46451
			2020,고성공룡나라(대전),62548,25631,51367
			2021,고성공룡나라(대전),63062,18219,51849
			2022,고성공룡나라(대전),68519,25624,43846
			2023,고성공룡나라(대전),67947,27193,46865
			2024,고성공룡나라(대전),64215,23762,48299
			2015,고성공룡나라(통영),55461,27293,44533
			2016,고성공룡나라(통영),67200,22516,46275
			2017,고성공룡나라(통영),64912,21848,49743
			2018,고성공룡나라(통영),63149,21635,42768
			2019,고성공룡나라(통영),69609,28546,48528
			2020,고성공룡나라(통영),68294,26786,50798
			2021,고성공룡나라(통영),74079,22251,52504
			2022,고성공룡나라(통영),63130,25612,47691
			2023,고성공룡나라(통영),63175,22987,50079
			2024,고성공룡나라(통영),76605,26052,49170
			2015,금산인삼랜드(대전),61126,25892,51469
			2016,금산인삼랜드(대전),63207,25011,51160
			2017,금산인삼랜드(대전),59612,26861,53211
			2018,금산인삼랜드(대전),74564,25963,55902
			2019,금산인삼랜드(대전),72427,23589,43187
			2020,금산인삼랜드(대전),63636,28895,48821
			2021,금산인삼랜드(대전),61695,30266,50588
			2022,금산인삼랜드(대전),50406,27030,51734
			2023,금산인삼랜드(대전),67118,27378,48846
			2024,금산인삼랜드(대전),56984,25228,44527
			2015,금산인삼랜드(통영),59515,22890,51402
			2016,금산인삼랜드(통영),66280,25025,45984
			2017,금산인삼랜드(통영),65484,29027,39321
			2018,금산인삼랜드(통영),68111,24770,39909
			2019,금산인삼랜드(통영),52866,23808,50256
			2020,금산인삼랜드(통영),68218,23739,54178
			2021,금산인삼랜드(통영),74978,27237,46269
			2022,금산인삼랜드(통영),73018,28179,53443
			2023,금산인삼랜드(통영),61329,18773,59587
			2024,금산인삼랜드(통영),55064,26106,60885
			2015,덕유산(대전),67807,28686,41789
			2016,덕유산(대전),53969,24804,54541
			2017,덕유산(대전),63365,24118,50151
			2018,덕유산(대전),72739,22414,43224
			2019,덕유산(대전),60461,29067,50332
			2020,덕유산(대전),79633,28653,49004
			2021,덕유산(대전),73941,26754,45710
			2022,덕유산(대전),70101,24375,47749
			2023,덕유산(대전),74353,25934,45227
			2024,덕유산(대전),62590,28877,46460
			2015,덕유산(통영),63098,24863,50081
			2016,덕유산(통영),63107,22003,44814
			2017,덕유산(통영),59515,29457,53174
			2018,덕유산(통영),69492,24875,45165
			2019,덕유산(통영),62306,23444,61458
			2020,덕유산(통영),50900,27677,42860
			2021,덕유산(통영),64953,23611,43386
			2022,덕유산(통영),58154,30798,48523
			2023,덕유산(통영),60612,27656,49228
			2024,덕유산(통영),70364,21420,50670
			2015,산청(대전),70709,21846,51381
			2016,산청(대전),76771,26161,53216
			2017,산청(대전),70039,24346,49373
			2018,산청(대전),55352,25017,50484
			2019,산청(대전),70384,26264,52718
			2020,산청(대전),58398,25933,49272
			2021,산청(대전),77778,25638,46723
			2022,산청(대전),65778,23791,50125
			2023,산청(대전),63241,21506,48889
			2024,산청(대전),63553,21923,48847
			2015,산청(통영),75413,27565,52186
			2016,산청(통영),56832,27449,49907
			2017,산청(통영),69110,27307,42490
			2018,산청(통영),65366,24214,48931
			2019,산청(통영),59747,29638,44953
			2020,산청(통영),59737,26395,43880
			2021,산청(통영),62850,24025,56117
			2022,산청(통영),70795,26049,47253
			2023,산청(통영),71814,27261,51626
			2024,산청(통영),65466,21776,48624
			2015,함양(대전),62142,27890,54153
			2016,함양(대전),61319,27427,57714
			2017,함양(대전),61255,30606,44984
			2018,함양(대전),65788,26170,49234
			2019,함양(대전),60139,24651,45893
			2020,함양(대전),67784,27064,60124
			2021,함양(대전),74637,24864,50775
			2022,함양(대전),72182,26280,48835
			2023,함양(대전),65976,28472,45005
			2024,함양(대전),63500,27432,50709
			2015,함양(통영),67210,25231,53960
			2016,함양(통영),79644,27264,48227
			2017,함양(통영),70598,24787,45490
			2018,함양(통영),65853,19433,43502
			2019,함양(통영),63354,22654,44099
			2020,함양(통영),62771,21895,47180
			2021,함양(통영),62124,26266,54853
			2022,함양(통영),66770,26255,49666
			2023,함양(통영),67130,23536,48613
			2024,함양(통영),67664,22608,53434
			2015,벌곡(대전),72736,24545,47990
			2016,벌곡(대전),59873,28032,43958
			2017,벌곡(대전),64177,23949,49428
			2018,벌곡(대전),53861,29675,44433
			2019,벌곡(대전),66031,25643,45429
			2020,벌곡(대전),59810,28653,46592
			2021,벌곡(대전),67418,24100,45994
			2022,벌곡(대전),68737,28637,48315
			2023,벌곡(대전),56304,31434,44965
			2024,벌곡(대전),55519,32997,47190
			2015,현풍(대구),56043,24409,50984
			2016,현풍(대구),66887,23968,58141
			2017,현풍(대구),62214,23096,53901
			2018,현풍(대구),74361,24058,42286
			2019,현풍(대구),72401,20835,43145
			2020,현풍(대구),71988,26054,47879
			2021,현풍(대구),67953,25799,42790
			2022,현풍(대구),74014,29671,50187
			2023,현풍(대구),65934,32329,47818
			2024,현풍(대구),63934,27154,56413
			2015,현풍(창원),76092,25522,50693
			2016,현풍(창원),56592,25382,45045
			2017,현풍(창원),59029,30605,45281
			2018,현풍(창원),62148,27158,55559
			2019,현풍(창원),68796,33429,48810
			2020,현풍(창원),67336,26922,56234
			2021,현풍(창원),68967,25895,44517
			2022,현풍(창원),67242,29871,47159
			2023,현풍(창원),69109,26844,53424
			2024,현풍(창원),60355,32348,42886

			`;

			const data = parseCSV(csvData);
			        // JSP에서 받은 서비스 구역 이름과 일치하는 데이터만 필터링
			        const filteredData = data.filter(d => d.Region === saName);

			        // 필터링된 데이터를 확인 (예: 차트나 테이블에 사용할 수 있습니다)
			        console.log("필터링된 데이터:", filteredData);
					
					drawChart(filteredData);
			        
   },
   error: function(error) {
  console.error("서비스 구역 이름 로드 실패:", error);	  
   }
});

function drawChart(filteredData, saName) {
    if (filteredData.length === 0) {
        console.log("데이터가 없습니다.");
        return;
    }
    // 차트 그리기 로직을 여기에 추가
    console.log("차트 데이터:", filteredData);
	// 향후 6년 예측 데이터 생성
	const lastYear = filteredData[filteredData.length - 1].Year;
	for (let i = 1; i <= 6; i++) {
	    const lastRecord = filteredData[filteredData.length - 1];
	    filteredData.push({
	        Year: lastYear + i,
	        Region: saName,
	        Annual_Revenue: Math.round(lastRecord.Annual_Revenue * 1.03),
	        Annual_Traffic_Volume: Math.round(lastRecord.Annual_Traffic_Volume * 1.02),
	        Annual_Visitors: Math.round(lastRecord.Annual_Visitors * 1.01)
	    });
	}
	// 차트에 사용할 데이터 준비
	const years = filteredData.map(d => d.Year);
	const revenueData = filteredData.map(d => d.Annual_Revenue);
	const trafficVolumeData = filteredData.map(d => d.Annual_Traffic_Volume);
	const visitorsData = filteredData.map(d => d.Annual_Visitors);

	// 차트를 생성할 'chartContainer'에 'canvas' 추가
	const canvas = document.getElementById('manager-chart');
	  const ctx = canvas.getContext('2d');
	// 차트를 chartContainer에 생성
	new Chart(ctx, {
	    type: 'line',
	    data: {
	        labels: years,
	        datasets: [
	            {
	                label: '매출',
	                data: revenueData,
	                borderColor: 'orange',// 주황색
	                fill: false,
	            },
	            {
	                label: '통행량',
	                data: trafficVolumeData,
	                borderColor: 'blue', // 파란색
	                fill: false,
	            },
	            {
	                label: '이용객',
	                data: visitorsData,
	                borderColor: 'green',  // 녹색
	                fill: false,
	            }
	        ]
	    },
	    options: {
	        responsive: true,
	        maintainAspectRatio: false,
	        interaction: {
	            mode: 'index',
	            intersect: false
	        },
	        stacked: false,
	        scales: {
	            x: {
	                title: {
	                    display: true,
	                    text: 'Year'
	                }
	            },
	            y: {
	                title: {
	                    display: true,
	                    text: 'Values'
	                }
	            }
	        }
	    }
	});

	//보조칸 차트를 생성하는 함수
	function createChart(canvasId, label, data, color) {
	    const ctx = document.getElementById(canvasId).getContext('2d');

	    new Chart(ctx, {
	        type: 'bar',
	        data: {
	            labels: years,
	            datasets: [
	                {
	                    label: label,
	                    data: data,
	                    backgroundColor: color, // 막대의 색상
	                    borderColor: color,
	                    borderWidth: 1,
	                }
	            ]
	        },
	        options: {
	            responsive: true,
	            maintainAspectRatio: false,
	            scales: {
	                x: {
	                    title: {
	                        display: true,
	                        text: 'Year'
	                    }
	                },
	                y: {
	                    title: {
	                        display: true,
	                        text: label
	                    }
	                }
	            }
	        }
	    });
	}

	// 각 차트를 해당 canvas 요소에 생성하며 각 차트의 색상을 지정
	createChart('sales-chart', '매출', revenueData, 'rgba(255, 159, 64, 0.7)');  // 주황색
	createChart('traffic-chart', '통행량', trafficVolumeData, 'rgba(54, 162, 235, 0.7)');  // 파란색
	createChart('guests-chart', '이용객', visitorsData, 'rgba(75, 192, 192, 0.7)');  // 녹색

}


});
