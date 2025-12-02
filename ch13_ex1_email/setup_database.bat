@echo off
REM ============================================
REM Script tạo database PostgreSQL cho Email List App
REM ============================================

echo.
echo ========================================
echo Tao database PostgreSQL - murach_jpa
echo ========================================
echo.

REM Kiểm tra psql có tồn tại không
where psql >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] PostgreSQL chua duoc cai dat hoac chua them vao PATH
    echo Vui long cai dat PostgreSQL hoac them vao PATH
    pause
    exit /b 1
)

echo [INFO] Tim thay PostgreSQL
echo.

REM Tạo database
echo [STEP 1] Tao database murach_jpa...
psql -U postgres -c "CREATE DATABASE murach_jpa;" 2>nul

if %ERRORLEVEL% EQU 0 (
    echo [SUCCESS] Database murach_jpa da duoc tao thanh cong!
) else (
    echo [WARNING] Database co the da ton tai hoac co loi
    echo Dang thu ket noi de kiem tra...
)

echo.
echo [STEP 2] Kiem tra database...
psql -U postgres -d murach_jpa -c "SELECT 'Database murach_jpa is ready!' AS status;"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo [SUCCESS] Setup hoan tat!
    echo.
    echo ========================================
    echo Thong tin ket noi:
    echo ========================================
    echo Database: murach_jpa
    echo User    : postgres
    echo Password: postgres (mac dinh)
    echo Port    : 5432
    echo Host    : localhost
    echo ========================================
    echo.
    echo Ban co the chay ung dung bang lenh:
    echo   mvn clean package cargo:run
    echo.
) else (
    echo.
    echo [ERROR] Khong the ket noi den database
    echo Vui long kiem tra:
    echo   1. PostgreSQL service dang chay
    echo   2. Password cua user postgres dung
    echo   3. Port 5432 khong bi chan
    echo.
)

pause
