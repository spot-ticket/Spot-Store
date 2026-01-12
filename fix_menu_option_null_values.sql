-- MenuOptionEntity의 null 값을 기본값으로 업데이트

-- is_available이 null인 경우 true로 설정
UPDATE p_menu_option
SET is_available = true
WHERE is_available IS NULL;

-- is_hidden이 null인 경우 false로 설정
UPDATE p_menu_option
SET is_hidden = false
WHERE is_hidden IS NULL;

-- 컬럼에 NOT NULL 제약조건 추가 및 기본값 설정 (PostgreSQL)
ALTER TABLE p_menu_option
  ALTER COLUMN is_available SET NOT NULL,
  ALTER COLUMN is_available SET DEFAULT true,
  ALTER COLUMN is_hidden SET NOT NULL,
  ALTER COLUMN is_hidden SET DEFAULT false;
