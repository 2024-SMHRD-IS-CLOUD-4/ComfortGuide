// 비밀번호 확인
let pw1 = document.getElementById('pw');
let pw2 = document.getElementById('pw_true');
let confirmPwMessage = document.getElementById('confirmPw');

pw2.addEventListener('keyup', () => {
	if (pw1.value === pw2.value) {
		confirmPwMessage.innerText = '비밀번호가 일치합니다.';
		confirmPwMessage.style.color = 'green'; // 일치할 때는 초록색
	} else {
		confirmPwMessage.innerText = '비밀번호가 일치하지 않습니다.';
		confirmPwMessage.style.color = 'red'; // 불일치할 때는 빨간색
	}
});

// jQuery를 사용한 아이디 중복 확인
$(document).ready(function() {
	$('#id').on('input', function() {
		const id = $(this).val();
		const confirmId = $('#confirmId');

		if (id) {
			$.ajax({
				url: 'checkId.jsp',
				type: 'GET',
				data: { id: id },
				success: function(data) {
					if (data.trim() === "true") {
						confirmId.text('이미 사용 중인 아이디입니다.').css('color', 'red');
					} else {
						confirmId.text('사용 가능한 아이디입니다.').css('color', 'green');
					}
				},
				error: function() {
					confirmId.text('서버 오류로 아이디 확인 실패').css('color', 'red');
				}
			});
		} else {
			confirmId.text(''); // 아이디 입력이 없으면 메시지 지우기
		}
	});

	// 회원가입 버튼 클릭 시 유효성 검사
	$('#joinForm').on('submit', function(event) {
		const idAvailable = $('#confirmId').text().trim() === '사용 가능한 아이디입니다.';
		const pwMatch = pw1.value === pw2.value;

		if (!idAvailable) {
			alert('아이디가 이미 사용 중입니다.');
			event.preventDefault(); // 폼 제출 방지
		} else if (!pwMatch) {
			alert('비밀번호가 일치하지 않습니다.');
			event.preventDefault(); // 폼 제출 방지
		}else{
			alert('회원가입에 성공하였습니다!');
		}
	});
});