# DSP Lab 4 – Digital Signal Processing
## 1. Giới thiệu

Repository chứa mã nguồn Scilab, kết quả mô phỏng và hình ảnh minh họa cho Bài thực hành 4 (Lab 4) của môn Xử lý tín hiệu số.

Nội dung thực hành tập trung vào biến đổi Z, miền hội tụ (ROC), xử lý âm thanh, xử lý ảnh và các phương pháp tính tích chập tuyến tính, tích chập vòng.

## 2. Nội dung bài thực hành

| Bài tập | Nội dung | Phương pháp |
|---|---|---|
| 1 | Z-Transform của tín hiệu xung | Lý thuyết |
| 2 | Z-Transform của tín hiệu phía phải | Lý thuyết |
| 3 | Z-Transform của tín hiệu hai phía | Lý thuyết |
| 4 | Audio Processing | Scilab |
| 5 | Image Processing | Scilab |
| 6 | Linear Convolution | Folding and Shifting, Matrix Method |
| 7 | Circular Convolution | Folding and Shifting, Matrix Method |

Các bài 1–3 được trình bày trong báo cáo. Các bài 4–7 được hiện thực và kiểm chứng bằng Scilab.

## 3. Cấu trúc thư mục

```text
DSP_LAB4/
├── Code/
│   ├── lab4_ex4.sci
│   ├── lab4_ex5.sci
│   ├── lab4_ex6_folding.sci
│   ├── lab4_ex6_matrix.sci
│   ├── lab4_ex7_folding.sci
│   └── lab4_ex7_matrix.sci
│
├── Console/
│   └── lab4_ex*_console.txt
│
├── Images/
│   ├── lab4_ex4_audio.png
│   ├── lab4_ex5_image.png
│   ├── lab4_ex6_folding.png
│   ├── lab4_ex6_matrix.png
│   ├── lab4_ex6_energy.png
│   ├── lab4_ex7_folding.png
│   ├── lab4_ex7_matrix.png
│   └── lab4_ex7_energy.png
│
└── README.md
```

File WAV tạo bởi Bài 4 được lưu trong thư mục `Code/`.

## 4. Kết quả thực hiện

### Exercise 4 – Audio Processing

- Tạo tín hiệu âm thanh gồm hai thành phần 440 Hz và 880 Hz.
- Lưu và đọc tín hiệu WAV 16-bit với tần số lấy mẫu 8000 Hz.
- Phân tích phổ tần số bằng FFT.
- Biểu diễn dạng sóng và phổ biên độ.

### Exercise 5 – Image Processing

- Tạo ảnh xám kích thước 256 × 256 pixel.
- Làm mờ ảnh bằng bộ lọc trung bình 9 × 9.
- Hiển thị ảnh trước và sau xử lý.
- Phân tích histogram và độ lệch cường độ pixel.

### Exercise 6 – Linear Convolution

Tính tích chập tuyến tính bằng hai phương pháp: Folding and Shifting và Matrix Method.

**Kết quả:**

\[
y[n]=[1,2,-4,0,4,-2,-1]
\]

- Năng lượng tín hiệu đầu vào: 19.
- Năng lượng tín hiệu đầu ra: 42.

### Exercise 7 – Circular Convolution

Tính tích chập vòng 5 điểm bằng hai phương pháp: Folding and Shifting và Matrix Method.

**Kết quả:**

\[
y[n]=[4,-4,-3,0,3]
\]

- Năng lượng đầu vào trên một chu kỳ: 19.
- Năng lượng đầu ra trên một chu kỳ: 50.

Cả hai phương pháp cho kết quả thống nhất với tính toán lý thuyết.

## 5. Công cụ sử dụng

- **Scilab 2026.1.0:** Tính toán và mô phỏng tín hiệu.
- **LaTeX:** Soạn thảo báo cáo thực hành.
- **GitHub:** Lưu trữ mã nguồn và kết quả.

Các chương trình sử dụng những hàm cơ bản của Scilab và không yêu cầu cài đặt toolbox bổ sung.

## 6. Hướng dẫn chạy

1. Cài đặt Scilab.
2. Mở file `.sci` tương ứng trong thư mục `Code/` bằng SciNotes.
3. Chạy chương trình bằng chức năng Execute.
4. Kiểm tra kết quả trong các thư mục:
   - `Console/`: Kết quả tính toán dạng `.txt`.
   - `Images/`: Các đồ thị và hình ảnh mô phỏng.
   - `Code/`: Mã nguồn và tệp WAV được tạo trong Bài 4.

## 7. Tài liệu tham khảo
- Scilab Documentation: https://help.scilab.org/

---

*Digital Signal Processing – HCMUT – Semester 261*
