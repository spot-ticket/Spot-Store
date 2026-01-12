-- Add status column to p_store table
ALTER TABLE p_store ADD COLUMN IF NOT EXISTS status VARCHAR(20) NOT NULL DEFAULT 'PENDING';

-- Add check constraint for valid status values
ALTER TABLE p_store DROP CONSTRAINT IF EXISTS p_store_status_check;
ALTER TABLE p_store ADD CONSTRAINT p_store_status_check
    CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED'));

-- Update existing records to have PENDING status if they don't have one
UPDATE p_store SET status = 'PENDING' WHERE status IS NULL;
