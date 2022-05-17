## SSAFIT
- **220517 작업내역**

  **기존 back-end 프로젝트 이식, 명칭 및 기능 변경**
    -  WebConfig, DBConfig, application.properties 세팅
    
  **github 브랜치 룰(토의)**
    - master > (release) > develop > feature/'기능' or '작업자명'
      - master : 오류 없이 정상작동 되는 상태의 프로젝트 원본, develop과 동일하지만, 안정된 코드만 포함
      - (release) : 프로젝트를 배포하기 위한 브랜치
      - develop : 브랜치를 분기하는 브랜치 지점, 기능 개발 후 병합하는 지점
      - feature/이름 : 실질적으로 기능을 개발하는 브랜치, 완료 혹은 저장 시 develop으로 병합
      - [브랜치 설명 참조](https://gmlwjd9405.github.io/2018/05/11/types-of-git-branch.html)
    - 일일 작업은 develop(master)에서 feature브랜치를 생성해서 작업을 실시하고, 
    - 병합 시 원격 브랜치(origin/feature/---)에 푸시하고, develop으로 병합요청을 한다.
    - 병합 가능 여부를 확인하고, 본인이 승인한다.
    - 기능이 완전히 구현되어 master 브랜치 반영이 가능하면 전체 병합을 한다.
    - 배포는 하지 않으므로 release는 사용하지 않는다.
    - 병합 시 오류가 발생하면 중복 수정된 내용을 조정하고, 
    - 만약, develop 브랜치 상태에서 프로젝트가 실행이 되지 않으면, 실행이 가능한 master브랜치로 초기화한다.
  - **SpringBoot 작업내역**
    - Member 관련 기능 구현, sql 수정, mapper 세팅완료
      - ApiMemberController 기능 구현
        - JWT를 이용한 login 기능 구현( 미완 : UserNotFoundEx, PWIncorrectEx 기능이 미작동 다르게 캐치됨.) 
        - GetMember 개인상세 정보 불러오기, 내가 follow한 목록, 나를 follow한 목록 불러오기 완료(토큰 필요)
        - Join 기능 구현, userId, password, username을 받고, 성공 시 CREATED, sql에 id중복시 CONFLICT상태값 반환 
        - update 기능 구현, password와 username만 수정 가능(토큰 필요)
        - delete 기능 구현, userId 기준으로 삭제(토큰 필요, 토큰과 호출된 userId 맞는 지 비교 기능 추가예정)
    - asdf
      - asdf  

--------------
- **220516 작업내역**

  - 프로젝트 생성

    **vue 프로젝트 생성** ( vue create ssafit-vue )
    - dependencies
      - router ( vue add router )
      - vuex ( vue add vuex )
      - axios ( npm install axios )
      - bootstrap-vue (npm install vue bootstrap-vue bootstrap )
        - main.js 추가
          - import BootstrapVue from 'bootstrap-vue'
          - import 'bootstrap/dist/css/bootstrap.min.css'
          - import 'bootstrap-vue/dist/bootstrap-vue.css'
          - Vue.use(BootstrapVue)

    **springboot 프로젝트 생성** ( Spring starter project )
    - dependencies
      - MyBatis Framwork,
      - MySQL Driver,
      - Spring Boot DevTools,
      - Spring Web
      
      ![SQL](./ssafit-mysql/sql_v1.JPG)
      
    **MySQL database 구성** 
    
    - Table
      - SF_VIDEO - PART_NO
      - SF_MEMBER
      - SF_REVIEW
      - ZZIM
      - FOLLOW_MEMBER





    
