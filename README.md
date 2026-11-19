# HyperLis

Bộ công cụ hỗ trợ kỹ thuật I.T & Tối ưu hóa hệ điều hành Windows.

- **Tác giả / Phát triển:** Việt.HVQ - I.T department
- **Website chính thức:** [https://viethvq.name.vn](https://viethvq.name.vn)
- **GitHub Repository:** [https://github.com/viethvq/HyperLis](https://github.com/viethvq/HyperLis)
- **Bản quyền:** Copyright © 2026 Việt.HVQ - I.T department. All rights reserved.

---

## 1. Yêu cầu môi trường & Công cụ

- **Hệ điều hành:** Windows 10 / 11 (yêu cầu quyền **Administrator**).
- **Nền tảng:** .NET 9.0 SDK / Desktop Runtime (`net9.0-windows`).
- **Kiến trúc:** `win-x64`.
- **Công cụ đóng gói (Tùy chọn):** [Inno Setup 6](https://jrsoftware.org/isdl.php) (cần thiết nếu muốn tạo bộ cài đặt `.exe`).

---

## 2. Hướng dẫn Build & Đóng gói

Dự án đã tích hợp sẵn script tự động hóa toàn bộ quy trình:

1. Mở PowerShell hoặc Command Prompt tại thư mục gốc dự án.
2. Chạy lệnh:
   ```cmd
   .\build.bat
   ```
3. Script sẽ tự động:
   - Restore các NuGet packages từ nguồn chuẩn.
   - Clean các bản build cũ.
   - Publish bản Release theo kiến trúc `win-x64`.
   - Tìm kiếm công cụ Inno Setup trên máy và đóng gói file installer hoàn chỉnh vào thư mục `Output/`.

---

## 3. Cơ chế Cập nhật tự động (Auto-Update Mechanism)

Ứng dụng **không đọc trực tiếp từ trang web Releases**, mà kiểm tra phiên bản mới thông qua 2 tệp cấu hình JSON lưu trên nhánh `main` của repository:

- **Bản tiếng Anh:** `https://raw.githubusercontent.com/viethvq/HyperLis/main/update_en.json`
- **Bản tiếng Việt:** `https://raw.githubusercontent.com/viethvq/HyperLis/main/update_vn.json`

### Luồng hoạt động của tính năng Check Update:
1. **Kiểm tra phiên bản:** Ứng dụng đọc trường `version` trong tệp JSON tương ứng với ngôn ngữ đang dùng và so sánh với phiên bản đang chạy.
2. **Hiển thị thông báo:** Nếu có bản mới hơn, hiển thị cửa sổ cập nhật cùng các nội dung thay đổi (`content`).
3. **Tải bộ cài đặt:** Khi nhấn **Update Now**, ứng dụng sẽ tự động tải file `.exe` cài đặt từ URL cấu hình ở trường `download_url_setup` trong file JSON.
4. **Xem chi tiết:** Nút *View full changelog on GitHub* sẽ mở trang Releases chính thức: [https://github.com/viethvq/HyperLis/releases](https://github.com/viethvq/HyperLis/releases).

---

## 4. Hướng dẫn phát hành phiên bản mới & Cập nhật Changelog

Khi phát hành phiên bản mới (ví dụ từ `v1.0.7` lên `v1.0.8`), thực hiện theo các bước:

### Bước 1: Cập nhật Changelog lịch sử (Local)
Trước khi đóng gói bộ cài, cập nhật danh sách tính năng mới vào 2 file JSON lịch sử để hiển thị trong cửa sổ **Dashboard > Changelog**:
- Mở `Changelog/vn.json` và `Changelog/en.json`.
- Thêm block phiên bản mới (ví dụ `"v1.0.8 Chính thức"`) kèm danh sách nội dung thay đổi (`"content"`).
- *(Tùy chọn)* Cập nhật số Version trong file `HyperLisUI.csproj` (`<Version>1.0.8</Version>`).

### Bước 2: Build bộ cài mới
Chạy script tự động trong PowerShell/CMD:
```cmd
.\build.bat
```
File cài đặt mới sẽ được tạo trong thư mục `Output/` (ví dụ: `HyperLis_Setup_v1.0.8_NoDotNet.exe`).

### Bước 3: Tạo Release trên GitHub
1. Truy cập: [https://github.com/viethvq/HyperLis/releases/new](https://github.com/viethvq/HyperLis/releases/new)
2. Nhập Tag và Title: `v1.0.8`.
3. Đính kèm file installer vừa tạo trong thư mục `Output/`.
4. Nhấn **Publish release**.
5. Chuột phải vào file `.exe` vừa upload trong Release, chọn **Copy link address** (đây là link tải trực tiếp).

### Bước 4: Cập nhật Changelog Online (Kích hoạt Auto-Update)
Mở 2 file `update_en.json` và `update_vn.json`:
- Đổi `"version": "1.0.8"`.
- Dán link tải trực tiếp vào trường `"download_url_setup"`.
- Viết tóm tắt các tính năng mới vào mảng `"content"` (phần này sẽ hiển thị trực tiếp trên popup của người dùng khi bấm Check Update).

### Bước 5: Commit & Push lên GitHub
Commit và đẩy các thay đổi lên nhánh `main`. Ngay lập tức người dùng đang chạy bản cũ khi bấm **Check Update** sẽ nhận được thông báo bản mới kèm nội dung Changelog online.

---

## 5. Giấy phép sử dụng

Phần mềm được phát triển cho mục đích hỗ trợ kỹ thuật I.T, tối ưu hóa hệ điều hành và nghiên cứu học tập cá nhân.
Mọi chi tiết xin liên hệ: [https://viethvq.name.vn](https://viethvq.name.vn).
