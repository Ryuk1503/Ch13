-- ============================================
-- Database Setup for Email List Application
-- Chapter 13, Exercise 1 - PostgreSQL Version
-- ============================================

-- Connect to PostgreSQL
-- \c postgres

-- Create database if it doesn't exist
CREATE DATABASE murach_jpa;

-- Connect to the database
\c murach_jpa;

-- Optional: View existing tables (if any)
\dt

-- Note: The application will automatically create these tables:
-- 1. User table with columns: UserID, FirstName, LastName, Email
-- 2. User_SEQ sequence (for tracking auto-generated IDs)

-- After running the application, you can verify data with:
-- SELECT * FROM "User";
-- SELECT * FROM "User_SEQ";

-- Optional: Clear all data (use with caution!)
-- DELETE FROM "User";

-- Optional: Drop tables to reset (use with caution!)
-- DROP TABLE IF EXISTS "User" CASCADE;
-- DROP SEQUENCE IF EXISTS "User_SEQ";

-- Optional: Create a user with specific privileges (if not using postgres)
-- CREATE USER emaillist_user WITH PASSWORD 'password123';
-- GRANT ALL PRIVILEGES ON DATABASE murach_jpa TO emaillist_user;
-- GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO emaillist_user;
-- GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO emaillist_user;

-- Check database encoding
SELECT pg_encoding_to_char(encoding) FROM pg_database WHERE datname = 'murach_jpa';

-- Verify connection
SELECT 'Database murach_jpa is ready!' AS Status;
