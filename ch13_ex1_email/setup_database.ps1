# ============================================
# PostgreSQL Database Setup Script
# Email List Application - Chapter 13
# ============================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "PostgreSQL Database Setup - murach_jpa" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Kiểm tra PostgreSQL
Write-Host "[1/5] Checking PostgreSQL installation..." -ForegroundColor Yellow
try {
    $psqlVersion = psql --version
    Write-Host "      Found: $psqlVersion" -ForegroundColor Green
} catch {
    Write-Host "      ERROR: PostgreSQL not found in PATH" -ForegroundColor Red
    Write-Host "      Please install PostgreSQL or add to PATH" -ForegroundColor Red
    pause
    exit 1
}

# Kiểm tra PostgreSQL Service
Write-Host "`n[2/5] Checking PostgreSQL service..." -ForegroundColor Yellow
$service = Get-Service -Name "postgresql*" -ErrorAction SilentlyContinue | Select-Object -First 1
if ($service) {
    if ($service.Status -eq "Running") {
        Write-Host "      Service is running: $($service.Name)" -ForegroundColor Green
    } else {
        Write-Host "      Service is not running. Attempting to start..." -ForegroundColor Yellow
        Start-Service $service.Name
        Write-Host "      Service started successfully" -ForegroundColor Green
    }
} else {
    Write-Host "      WARNING: Could not find PostgreSQL service" -ForegroundColor Yellow
}

# Tạo database
Write-Host "`n[3/5] Creating database 'murach_jpa'..." -ForegroundColor Yellow
$createDb = "CREATE DATABASE murach_jpa;"
$result = psql -U postgres -c $createDb 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "      Database created successfully!" -ForegroundColor Green
} else {
    if ($result -match "already exists") {
        Write-Host "      Database already exists (OK)" -ForegroundColor Yellow
    } else {
        Write-Host "      ERROR: $result" -ForegroundColor Red
    }
}

# Kiểm tra kết nối
Write-Host "`n[4/5] Testing database connection..." -ForegroundColor Yellow
$testQuery = "SELECT 'Connection successful!' AS status;"
$testResult = psql -U postgres -d murach_jpa -c $testQuery 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "      Connection test passed!" -ForegroundColor Green
} else {
    Write-Host "      ERROR: Cannot connect to database" -ForegroundColor Red
    Write-Host "      $testResult" -ForegroundColor Red
    pause
    exit 1
}

# Hiển thị thông tin
Write-Host "`n[5/5] Setup completed!" -ForegroundColor Green
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Connection Information:" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Database : murach_jpa" -ForegroundColor White
Write-Host "Host     : localhost" -ForegroundColor White
Write-Host "Port     : 5432" -ForegroundColor White
Write-Host "User     : postgres" -ForegroundColor White
Write-Host "Password : postgres (default)" -ForegroundColor White
Write-Host "========================================`n" -ForegroundColor Cyan

# Hướng dẫn tiếp theo
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "  1. Update password in persistence.xml if different" -ForegroundColor White
Write-Host "  2. Run the application with:" -ForegroundColor White
Write-Host "     cd `"$PSScriptRoot`"" -ForegroundColor Gray
Write-Host "     mvn clean package cargo:run" -ForegroundColor Gray
Write-Host "  3. Access: http://localhost:8080/ch13_ex1_email/`n" -ForegroundColor White

# Tùy chọn: Liệt kê databases
$choice = Read-Host "Do you want to list all databases? (y/n)"
if ($choice -eq 'y' -or $choice -eq 'Y') {
    Write-Host "`nExisting databases:" -ForegroundColor Cyan
    psql -U postgres -c "\l"
}

Write-Host "`nPress any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
