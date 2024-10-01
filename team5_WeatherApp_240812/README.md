# team5_WetherApp_240812

# 날씨 프로젝트

프로젝트 기간 : 2024.08.12 ~ 2024.08.20 (9일 간)

버전: iOS 16

git : GitHub, GitKraken으로 관리

외부 라이브러리 SnapKit

codebaseUI, MVC패턴 적용

> **역할 분담**
> 
- 임혜정 - 메인뷰, 사용자 현재 위치, 한국시간변환, 관심지역 저장, 각 페이지 모달창, 깃 관리, 스케쥴관리
- 김광현 - 리스트뷰, 서치바 검색기능, 모달
- 김동준 - 메인 뷰
- 유민우 - 상세 뷰, 상세 정보 연결
- 이진규 - 네트워크 매니저, api 통신
- 

> **코드 컨벤션**
> 
- 변수명 정할 때, 기능과 관련된 명확한 이름을 사용합니다
- img, btn, vc같은 축약어는 사용하지 않기
- ID,URL처럼 쓸 수 밖에 없을 축약어는 모두 대문자로 합니다 
*예시) userid() {} → userID() {}*
- 이름과 꺽쇠 {} 사이에 반드시 공백 1개를 넣어주세요

```swift
func name() -> String {
}
```

- **코드가 두줄 이상**일때는 함수화해서 lifeCycle 메서드 내에는 메서드만 넣기
- 코드 하나가 끝나면 엔터 간격 1번으로 합니다.

```swift
func method1() {
}

func method2() {
}

func method3() {
}
```

- extension이 시작될 때 엔터 간격 1번과 //MARK: - 주석 사용으로 명확한 설명 붙이기

```swift
	func method1() {
	}
}

// MARK: - 뷰 컨트롤러 확장입니다

extension ViewController: UIViewController {
}

```

- 

> **깃 컨벤션**
> 
- 코드 리뷰를 적극적으로 합니다. 
팀원의 코드에 흠을 잡는게 아닌 궁금한 점, 개선 방향 제안의 자세로 임합니다. 
pr당 최소 1코멘트씩 달기 *ex) “final키워드는 어떨 때 쓰는 것인가요?!”*
- 타이틀(브랜치명이 될) 포멧 = [feat] 구현 내용 / 작업자 이름
- 

> Commit message
> 
- feat - 새로운 기능 추가
- bug - 오류 해결시
- etc - 기타
- 

> Commit Convention
> 
- ex ) feat: [#1](https://nbcamp2024.slack.com/archives/C077DKAAGTX) - “스위프트 파일명 - 추가 로그인 함수” 로그인 API 개발
- ex ) art: #2 - “스위프트 파일명 - UIImage 구현” 메인화면 이미지 추가
- 

> PR
> 
- PR 할 때 팀원 전부 체크
- PR 한 후 해당 이슈 Close 됐는지 체크(안됐으면 본인이 Close)
- Approve할 때 PR 템플릿 참고
