// '출생 연도' 셀렉트 박스 option 목록 동적 생성
const birthYearEl = document.querySelector('#birth-year')
// option 목록 생성 여부 확인
isYearOptionExisted = false;
birthYearEl.addEventListener('focus', function () {
  // year 목록 생성되지 않았을 때 (최초 클릭 시)
  if(!isYearOptionExisted) {
    isYearOptionExisted = true
    for(var i = 1940; i <= 2023; i++) {
      // option element 생성
      const YearOption = document.createElement('option')
      YearOption.setAttribute('value', i)
      YearOption.innerText = i
      // birthYearEl의 자식 요소로 추가
      this.appendChild(YearOption);
    }
  }
});
// Month, Day도 동일한 방식으로 구현


const birthMonthEl = document.querySelector('#birth-month')
// option 목록 생성 여부 확인
isMonthOptionExisted = false;
birthMonthEl.addEventListener('focus', function () {
  // Month 목록 생성되지 않았을 때 (최초 클릭 시)
  if(!isMonthOptionExisted) {
    isMonthOptionExisted = true
    for(var i = 1; i <= 12; i++) {
      // option element 생성
      const MonthOption = document.createElement('option')
      MonthOption.setAttribute('value', i)
      MonthOption.innerText = i
      // birthMonthEl의 자식 요소로 추가
      this.appendChild(MonthOption);
    }
  }
});

const birthDayEl = document.querySelector('#birth-day')
// option 목록 생성 여부 확인
isDayOptionExisted = false;
birthDayEl.addEventListener('focus', function () {
  // Day 목록 생성되지 않았을 때 (최초 클릭 시)
  if(!isDayOptionExisted) {
    isDayOptionExisted = true
    for(var i = 1; i <= 31; i++) {
      // option element 생성
      const DayOption = document.createElement('option')
      DayOption.setAttribute('value', i)
      DayOption.innerText = i
      // birthDayEl의 자식 요소로 추가
      this.appendChild(DayOption);
    }
  }
});