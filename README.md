<h1  align="center">
<p  align="center">혼자 하는 SNS_(Solo Network SNS)

</h1>
</p>

## 프로젝트 개요

### 혼자 하는 SNS (Solo Network SNS)는 다른 사람과의 연결이나 팔로우 관계 없이, 오직 나만의 공간에서 감정, 기록, 아이디어를 자유롭게 표현하고 AI가 반응해주는 새로운 형태의 개인용 SNS 플랫폼입니다.

### 이 프로젝트는 기존 SNS의 피로감이나 비교 심리를 배제하고, 개인의 창의성과 자기 성찰을 도와주고 동시에 내가 원하는 성격의 AI가 반응 해줌으로 자존감을 올려주는 플랫폼을 목표로 하고 있습니다.

## 팀원 구성

| **황상진** | **차부곤** | **권유진** | **문아린** | **고성훈** |

### 프로젝트 일정

25/01/03 ~ 25/01/13

### 사용 기술

| Riverpod | Cloud Firestore | Firebase Authentication | Firebase App Check | Go Router | Image Picker |
| Animated Splash Screen | 클린 아키텍쳐 |

## 주요 기능

| 로고 화면 | 로그인 화면 | 프로필 생성 화면 | 리스트 화면 | 상세 화면 | 글 작성 화면 | 마이페이지 화면 | 프로필 설정 화면 |
| --------- | ----------- | ---------------- | ----------- | --------- | ------------ | --------------- | ---------------- |
|           |             |                  |             |           |              |                 |                  |
|           |             |                  |             |           |              |                 |                  |
|           |             |                  |             |           |              |                 |                  |
|           |             |                  |             |           |              |                 |                  |

## TroubleShooting

#### 구글 계정으로 로그인 시도시 로그인 되지 않 이슈

1. 문제 정의

   - 구글 계정으로 로그인 시도시 앱에 로그인 되지 않는 현상 .

2. 사실 수집

   - PlatformException(sign_in_failed, com.google.android.gms.common.api.ApiException: 10: , null, null)
     위와 같은 오류 메세지 발생
   - 다른 팀원들은 모두 정상 동작함

3. 원인 추론

   - SHA-1 키 또는 계정에 문제 있을 것으로 예

4. 조사 방법 결정

   - 구글 검색, 챗gpt 이용, 튜터님께 문의
   - 참고 블로그 :[https://velog.io/@zinkiki/FlutterAndroid-Unhandled-Exception-PlatformExceptionsigninfailed-com.google.android.gms.common.api.ApiException-10-null-null](https://velog.io/@zinkiki/FlutterAndroid-Unhandled-Exception-PlatformExceptionsigninfailed-com.google.android.gms.common.api.ApiException-10-null-null)

5. 조사 방법 구현

   - SHA-1 키 재확인 → 효과 없음
   - 에뮬레이터 교체 → 효과 없음
   - google-services.json 삭제 후 다운 받아 사 → 효과 없음
   - 키 삭제 후 재설치 → 효과 없음(블로그 참고)
   - 빌드 할 때 참고한 키 확인하여 firebase에 입력 → 정상 작동(튜터님께서 알려주심)
     ![이미지](https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FdXsiho%2FbtsLFA9p8bT%2FX7wTU5FWvZIbSxdkfiBeXk%2Fimg.png)
   - 위치 : build\app\outputs\flutter-apk\
     명령어 : keytool -printcert -jarfile app-debug.apk

6. 결과 관찰
   - build\app\outputs\flutter-apk\위치에서 명령어를 실행시켜 나온 키값을 기존 입력한 키와 비교시 다르다는 것을 확인
   - 해당 키로 교체하여 시도시 정상 작동 확인
   - 원인은 파악 불가
