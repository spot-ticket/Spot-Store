# Spot-Store Service

가게 및 메뉴 관리를 담당하는 마이크로서비스

## 주요 기능

- 가게 등록/조회/수정/삭제
- 가게 승인/거절 (관리자)
- 메뉴 관리 (CRUD)
- 메뉴 옵션 관리
- 원산지 정보 관리
- 가게 카테고리 관리
- 리뷰 관리

## 기술 스택

- Spring Boot 3.x
- Spring Data JPA
- PostgreSQL
- JWT (인증은 User Service에서 처리)

## API 엔드포인트

### 가게 관리
- `POST /api/stores` - 가게 등록
- `GET /api/stores` - 가게 목록 조회
- `GET /api/stores/{storeId}` - 가게 상세 조회
- `PUT /api/stores/{storeId}` - 가게 정보 수정
- `DELETE /api/stores/{storeId}` - 가게 삭제
- `GET /api/stores/search` - 가게 검색

### 메뉴 관리
- `POST /api/stores/{storeId}/menus` - 메뉴 등록
- `GET /api/stores/{storeId}/menus` - 메뉴 목록 조회
- `GET /api/menus/{menuId}` - 메뉴 상세 조회
- `PUT /api/menus/{menuId}` - 메뉴 수정
- `DELETE /api/menus/{menuId}` - 메뉴 삭제

### 메뉴 옵션
- `POST /api/menus/{menuId}/options` - 옵션 추가
- `PUT /api/options/{optionId}` - 옵션 수정
- `DELETE /api/options/{optionId}` - 옵션 삭제

### 리뷰
- `POST /api/stores/{storeId}/reviews` - 리뷰 작성
- `GET /api/stores/{storeId}/reviews` - 리뷰 목록 조회
- `PUT /api/reviews/{reviewId}` - 리뷰 수정
- `DELETE /api/reviews/{reviewId}` - 리뷰 삭제

### 관리자
- `GET /api/admin/stores` - 전체 가게 조회
- `PATCH /api/stores/{storeId}/status` - 가게 상태 변경 (승인/거절)
- `DELETE /api/admin/stores/{storeId}` - 가게 삭제

## 환경 변수

```properties
# Database
SPRING_DATASOURCE_URL=jdbc:postgresql://localhost:5432/spot_store
SPRING_DATASOURCE_USERNAME=postgres
SPRING_DATASOURCE_PASSWORD=your_password

# Server Port
SERVER_PORT=8082

# User Service URL (for authentication)
USER_SERVICE_URL=http://localhost:8081
```

## 실행 방법

```bash
# Gradle 빌드
./gradlew build

# 애플리케이션 실행
./gradlew bootRun

# Docker로 실행
docker-compose up -d
```

## 데이터베이스 스키마

### p_store
- 가게 정보 테이블
- id (PK), name, address, phone_number, status, open_time, close_time

### p_menu
- 메뉴 정보 테이블
- menu_id (PK), store_id (FK), name, price, category, description

### p_menu_option
- 메뉴 옵션 테이블
- option_id (PK), menu_id (FK), name, detail, price, is_available, is_hidden

### p_origin
- 원산지 정보 테이블
- id (PK), menu_id (FK), ingredient_name, origin_name

### p_review
- 리뷰 테이블
- id (PK), store_id (FK), user_id (FK), rating, content

### p_category
- 카테고리 테이블
- id (PK), name

### p_store_category
- 가게-카테고리 매핑 테이블
- id (PK), store_id (FK), category_id (FK)

### p_store_user
- 가게-사용자 매핑 테이블 (소유자 관계)
- id (PK), store_id (FK), user_id (FK)

## MSA 통신

다른 마이크로서비스와의 통신:
- **Spot-User**: 사용자 인증, 소유자 검증
- **Spot-Order**: 주문 생성 시 메뉴/가게 정보 제공

## 포트

- User Service: `8081`
- Store Service: `8082`
- Order Service: `8083`
- Payment Service: `8084`
