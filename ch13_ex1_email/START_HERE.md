# Hướng dẫn Nhanh - PostgreSQL Version

## 🚀 Quick Start

### 1. Tạo Database
```powershell
# Cách 1: Chạy script tự động
.\setup_database.ps1

# Cách 2: Thủ công
psql -U postgres -c "CREATE DATABASE murach_jpa;"
```

### 2. Kiểm tra Password
Mở file: `src/main/resources/META-INF/persistence.xml`

Dòng này phải khớp với password PostgreSQL của bạn:
```xml
<property name="jakarta.persistence.jdbc.password" value="postgres"/>
```

Nếu password khác, sửa `value="YOUR_PASSWORD"`

### 3. Chạy Application
```powershell
mvn clean package cargo:run
```

### 4. Mở Browser
```
http://localhost:8080/ch13_ex1_email/
```

### 5. Kiểm tra Database
```sql
psql -U postgres -d murach_jpa

-- Xem dữ liệu
SELECT * FROM "User";

-- Thoát
\q
```

## 📋 Các File Đã Thay Đổi

| File | Thay đổi |
|------|----------|
| `pom.xml` | MySQL → PostgreSQL driver |
| `persistence.xml` | MySQL dialect → PostgreSQL dialect |
| `database_setup.sql` | MySQL syntax → PostgreSQL syntax |
| `README.md` | Cập nhật hướng dẫn PostgreSQL |
| `QUICK_REFERENCE.md` | Commands cho PostgreSQL |

## 🆕 File Mới

- `POSTGRESQL_SETUP.md` - Hướng dẫn chi tiết setup PostgreSQL
- `setup_database.ps1` - Script PowerShell tạo database
- `setup_database.bat` - Script Batch tạo database

## ⚙️ Cấu hình Mặc định

```
Database: murach_jpa
Host    : localhost
Port    : 5432
User    : postgres
Password: postgres
```

## 🔍 Lưu ý Quan trọng

### PostgreSQL phân biệt chữ hoa/thường!

❌ **Sai:**
```sql
SELECT * FROM User;
```

✅ **Đúng:**
```sql
SELECT * FROM "User";
```

### Tên bảng và cột

PostgreSQL tự động chuyển về chữ thường trừ khi dùng dấu ngoặc kép:
- Hibernate tạo: `"User"` (giữ nguyên chữ U hoa)
- Khi query: phải dùng `"User"` (có dấu ngoặc)

## 🐛 Troubleshooting

### Lỗi kết nối
```powershell
# Kiểm tra service
Get-Service postgresql*

# Start nếu chưa chạy
Start-Service "postgresql-x64-16"
```

### Lỗi password
```sql
-- Trong psql, đổi password
ALTER USER postgres PASSWORD 'postgres';
```

### Xem log chi tiết
Check console output khi chạy `mvn cargo:run` - sẽ thấy SQL queries do:
```xml
<property name="hibernate.show_sql" value="true"/>
```

## 📚 Tài liệu

- Chi tiết: `README.md`
- Setup: `POSTGRESQL_SETUP.md`
- Reference: `QUICK_REFERENCE.md`

## ✅ Checklist

- [ ] PostgreSQL đã cài đặt
- [ ] Service đang chạy
- [ ] Database `murach_jpa` đã tạo
- [ ] Password trong `persistence.xml` đúng
- [ ] Port 5432 không bị chặn
- [ ] Có thể kết nối: `psql -U postgres -d murach_jpa`

---

**Nếu mọi thứ OK, chạy:**
```powershell
mvn clean package cargo:run
```

**Sau đó truy cập:** http://localhost:8080/ch13_ex1_email/
