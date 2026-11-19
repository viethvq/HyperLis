# HƯỚNG DẪN DÀNH CHO AI AGENT & LỊCH SỬ THAO TÁC (AGENTS.MD)

Tài liệu này ghi lại toàn bộ bối cảnh dự án, kiến trúc kỹ thuật, quy trình thao tác và lịch sử các thay đổi đã thực hiện trên source code **HyperLis**. Các AI Agent hoặc lập trình viên tiếp nhận sau này cần tuân thủ các nguyên tắc được định nghĩa trong tài liệu này.

---

## 1. THÔNG TIN DỰ ÁN & BỐI CẢNH

- **Tên dự án:** HyperLis
- **Mục tiêu:** Phần mềm hỗ trợ kỹ thuật IT, tối ưu hóa hệ điều hành Windows, dọn dẹp hệ thống, tinh chỉnh dịch vụ, quản lý ứng dụng UWP, cài đặt Win tự động (WSAP), tạo USB Boot...
- **Nền tảng công nghệ:**
  - Ngôn ngữ: C# (.NET 9.0 Desktop Runtime)
  - UI Framework: Windows Presentation Foundation (WPF) - `net9.0-windows`
  - Output Type: WinExe (`HyperLis.exe`)
  - Quyền hạn: Administrator (`Properties\app.manifest`)
  - Chế độ Render: `RenderMode.SoftwareOnly` (tránh crash GPU/AMD driver)
  - Công cụ đóng gói: Inno Setup 6 (`ISCC.exe`)

---

## 2. THÔNG TIN CÁ NHÂN HÓA (BRANDING)

Dự án đã được cá nhân hóa toàn diện từ source code gốc (`ZitTechLab`):
- **Tác giả / Thương hiệu:** `Việt.HVQ - I.T department`
- **Bản quyền:** `Copyright © 2026 Việt.HVQ - I.T department`
- **Website chính thức:** `https://viethvq.name.vn`
- **Mạng xã hội:** Đã loại bỏ hoàn toàn các liên kết Facebook của tác giả cũ.
- **Quyên góp & Ngân hàng (Donation/Bank):** Đã loại bỏ hoàn toàn mã QR barcode (`Images/QR.jpg`) và số tài khoản ngân hàng `MBBANK: MDUCIT168` khỏi giao diện Settings và Description panel.
- **GitHub Repository:** `https://github.com/viethvq/HyperLis`
- **Cập nhật tự động (Auto-Update):** Đã trỏ endpoint cập nhật về repo cá nhân (`raw.githubusercontent.com/viethvq/HyperLis/main/...`).
- **Git Remote:** `origin` -> `https://github.com/viethvq/HyperLis.git` (branch `main`).

---

## 3. LỊCH SỬ CHI TIẾT CÁC THAO TÁC ĐÃ THỰC HIỆN

### Bước 1: Clone Repository
- Clone source code từ Git repository `https://github.com/ZitTechLab/HyperLis` vào thư mục làm việc `D:\Projects\HyperLis`.

### Bước 2: Phân tích kiến trúc & cấu trúc mã nguồn
- Rà soát toàn bộ project file [HyperLisUI.csproj](HyperLisUI.csproj).
- Kiểm tra các views chính trong `Views/` (Dashboard, Settings, License, Cleaning, WSAP...).
- Đánh giá luồng cập nhật tự động trong [UpdateService.cs](Services/UpdateService.cs) và [App.xaml.cs](App.xaml.cs).
- Phân tích cơ chế đóng gói bộ cài qua [HyperLis.iss](HyperLis.iss), [HyperLis_NoDotNet.iss](HyperLis_NoDotNet.iss) và các script `.bat`.

### Bước 3: Cá nhân hóa mã nguồn (Personalization)
1. **Thông tin Assembly & Project:**
   - [HyperLisUI.csproj](HyperLisUI.csproj): Sửa `Company` và `Copyright` thành `Việt.HVQ - I.T department`.
2. **Giao diện chính (MainWindow):**
   - [MainWindow.xaml](MainWindow.xaml): Thêm dòng phụ đề `© Việt.HVQ - I.T department` dưới logo/tên `HyperLis` ở góc trên bên trái thanh điều hướng.
3. **Màn hình Tổng quan (Dashboard):**
   - [Views/DashboardView.xaml](Views/DashboardView.xaml): Xóa bỏ thẻ liên kết Facebook cũ, bố trí lại thành 2 thẻ cân đối: `GitHub Repository` và `Website`.
   - [Views/DashboardView.xaml.cs](Views/DashboardView.xaml.cs): 
     - Xóa sự kiện click Facebook.
     - Cập nhật sự kiện click Website trỏ về `https://viethvq.name.vn`.
     - Đặt hằng số `GITHUB_REPO_URL = ""` chờ bổ sung sau.
     - Thêm stub fields tương thích giao diện tránh lỗi runtime.
4. **Màn hình Cài đặt & Thông tin (Settings):**
   - [Views/SettingsView.xaml](Views/SettingsView.xaml):
     - Xóa link Facebook, thay bằng link Website `https://viethvq.name.vn`.
     - Sửa phần giới thiệu nhà phát triển: `Phát triển bởi Việt.HVQ - I.T department.`
     - Thay thế 3 nút liên hệ Facebook cũ bằng nút mở website chính thức.
   - [Views/SettingsView.xaml.cs](Views/SettingsView.xaml.cs): Cập nhật các hàm xử lý sự kiện click tương ứng.
5. **Màn hình Quản lý bản quyền (License):**
   - [Views/LicenseView.xaml.cs](Views/LicenseView.xaml.cs): Chuyển hướng nút `Contact Support` (`BtnSupport_Click`) từ fanpage Facebook cũ sang `https://viethvq.name.vn`.
6. **Đa ngôn ngữ (Localization):**
   - [Resources/Language/VN.json](Resources/Language/VN.json) & [Resources/Language/EN.json](Resources/Language/EN.json):
     - Cập nhật các chuỗi `lblDeveloperInfo`, `lblWebsiteDesc`, `lblDonationDesc`, `lblActivateStep2`.
     - Loại bỏ toàn bộ các cụm từ tham chiếu tới `Zịt's Tech Lab`, `Lê Minh Đức`, `Tuấn Hải`.
7. **Cơ chế cập nhật (Auto-Updater & Dialogs):**
   - [Services/UpdateService.cs](Services/UpdateService.cs): Vô hiệu hóa `UPDATE_EN_URL` và `UPDATE_VN_URL`, thêm điều kiện chặn tải nếu URL rỗng.
   - [Views/Components/ChangelogWindow.xaml.cs](Views/Components/ChangelogWindow.xaml.cs) & [Views/Components/UpdateWindow.xaml.cs](Views/Components/UpdateWindow.xaml.cs): Đặt `GITHUB_RELEASES_URL = ""` chờ bổ sung.
8. **Kịch bản đóng gói Inno Setup:**
   - [HyperLis.iss](HyperLis.iss) & [HyperLis_NoDotNet.iss](HyperLis_NoDotNet.iss):
     - Đổi `MyAppPublisher` sang `Việt.HVQ - I.T department`.
     - Sửa đường dẫn tuyệt đối máy cũ (`E:\GGAI\...`) thành đường dẫn tương đối (`bin\Release\net9.0-windows\win-x64\publish\*`).

### Bước 4: Kiểm tra biên dịch (Build Verification)
- Khởi tạo NuGet source `https://api.nuget.org/v3/index.json`.
- Chạy `dotnet restore` và `dotnet build HyperLisUI.csproj -c Debug`.
- Kết quả: **Build Succeeded** (0 Error, 458 Warnings tương thích kiểu nullable nguyên bản).

### Bước 5: Cài đặt công cụ & Đóng gói bộ cài đặt (Publishing)
- Cài đặt `Inno Setup 6` (v6.7.3) tự động qua winget (`JRSoftware.InnoSetup`).
- Thực hiện restore và publish phiên bản Release:
  ```powershell
  dotnet publish HyperLisUI.csproj -c Release -r win-x64
  ```
- Biên dịch bộ cài đặt bằng Inno Setup Compiler (`ISCC.exe`):
  ```powershell
  & "C:\Users\Administrator\AppData\Local\Programs\Inno Setup 6\ISCC.exe" /O"D:\Projects\HyperLis\Output" "D:\Projects\HyperLis\HyperLis_NoDotNet.iss"
  ```
- Kết quả file setup được tạo thành công:
  - Đường dẫn: `D:\Projects\HyperLis\Output\HyperLis_Setup_v1.0.7_NoDotNet.exe`
  - Kích thước: **97.2 MB**
  - Trạng thái: Hoàn chỉnh, sẵn sàng cài đặt.

### Bước 6: Loại bỏ hoàn toàn mã QR & Thông tin tài khoản ngân hàng (Donation)
- Xóa file ảnh mã QR: `Images/QR.jpg`.
- [Views/SettingsDescriptionView.xaml](Views/SettingsDescriptionView.xaml): Xóa khối hình chữ nhật hiển thị ảnh mã QR và dòng TextBlock tài khoản `MBBANK: MDUCIT168`.
- [MainWindow.xaml.cs](MainWindow.xaml.cs): Cập nhật hàm `SettingsButton_Click` hiển thị Settings toàn màn hình (`spansTwoColumns = true`, `rightView = null`) để ẩn hoàn toàn panel Donation bên phải.
- [Resources/Language/VN.json](Resources/Language/VN.json) & [Resources/Language/EN.json](Resources/Language/EN.json): Cập nhật chuỗi thông báo mục Thông tin/Website, loại bỏ nội dung kêu gọi donate.
- Biên dịch lại bản Release và đóng gói lại file setup `HyperLis_Setup_v1.0.7_NoDotNet.exe` (96.99 MB).

### Bước 7: Cập nhật link WinPE và xóa triệt để link tải tác giả cũ
- [update_en.json](update_en.json) & [update_vn.json](update_vn.json): Xóa link `download_url_setup` trỏ về release cũ, để trống `""`.
- [Download/winpe.json](Download/winpe.json) & [Warehouse/ApplyWinPEtoHDD.ps1](Warehouse/ApplyWinPEtoHDD.ps1): Cập nhật link tải WinPE mới: `https://github.com/viethvq/WSAP/releases/download/ver1.0.7/winpe.iso`.
- Đã gỡ bỏ toàn bộ remote git cũ và không còn bất kỳ liên kết nào tới `ZitTechLab` trên GitHub.

---

## 4. HƯỚNG DẪN DÀNH CHO AI AGENT THỰC HIỆN TIẾP SAO NÀY

1. **Khi người dùng có link GitHub:**
   - Mở [Views/DashboardView.xaml.cs](Views/DashboardView.xaml.cs), cập nhật `GITHUB_REPO_URL`.
   - Mở [Views/SettingsView.xaml.cs](Views/SettingsView.xaml.cs), cập nhật `GITHUB_REPO_URL`.
   - Mở [Views/Components/ChangelogWindow.xaml.cs](Views/Components/ChangelogWindow.xaml.cs), cập nhật `GITHUB_RELEASES_URL`.
   - Mở [Views/Components/UpdateWindow.xaml.cs](Views/Components/UpdateWindow.xaml.cs), cập nhật `GITHUB_RELEASES_URL`.
   - Mở [Services/UpdateService.cs](Services/UpdateService.cs), cập nhật link raw của `update_en.json` và `update_vn.json`.

2. **Quy tắc làm việc trên Codebase này:**
   - **Tôn trọng logic cũ:** Tuyệt đối không tự ý thay đổi cấu trúc dữ liệu, luồng tối ưu hệ thống trong `Helpers/HyperLisOptimization.cs` hoặc `Helpers/OptimizationHelper.cs`.
   - **Quy tắc Git:** Không tự ý `git push` hay `git pull` lên remote repository nếu chưa có sự đồng ý của người dùng.
   - **Quy tắc biên dịch:** Luôn chỉ định rõ Runtime Identifier `-r win-x64` khi restore/publish vì ứng dụng tích hợp các thư viện native và cấu hình `net9.0-windows`.

3. **Quy chuẩn Kỹ thuật & Kịch bản Script:**
   - **Batch script (.bat):** Tuyệt đối không dùng vòng lặp `for` lồng biến `%ProgramFiles(x86)%` vì dấu ngoặc `()` làm hỏng cú pháp `cmd.exe` (`Setup was unexpected at this time`). Sử dụng các khối `if exist "..."` tuần tự riêng biệt.
   - **PowerShell:** Môi trường mặc định là PowerShell 5.1, không dùng toán tử `&&`. Dùng dấu `;` hoặc tách từng câu lệnh riêng lẻ.

4. **Quy trình Cập nhật & Hai tầng Changelog:**
   - **Tầng 1 - Changelog Local (Offline):** `Changelog/vn.json` & `Changelog/en.json` - Phải cập nhật trước khi chạy `build.bat` để đóng gói vào bộ cài; hiển thị trong `ChangelogWindow` từ Dashboard.
   - **Tầng 2 - Changelog Online:** `update_vn.json` & `update_en.json` - Cập nhật trên GitHub sau khi tạo Release; hiển thị trên popup `UpdateWindow` khi người dùng bấm Check Update.
