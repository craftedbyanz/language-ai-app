# Profile, History, Streak — S016, S017, S018

Three utility screens reached from the Home floating bottom bar. Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED. Local = global − (1362, −1174).

## S016 `profile-settings--default`

Source: snapshot `ps1_6653ff9de5127961fbaa9893c6fe2030`, screenshot [S016-profile-settings.png](../screenshots/S016-profile-settings.png).
Reached from Home by the bottom-right icon (AX label "Sun--Streamline-Flex", gear glyph). OBSERVED. Nav title "Profile".

| Element | Role | Global x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| Back | AXButton | 1369 | −1126 | 33 | 33 | Yes |
| Account card "Free, An" | AXButton | 1719 | −1072 | 73 | 118 | Yes |
| Avatar "LauchScreenLogo" | AXImage | 1389 | −932 | 43 | 43 | Yes |
| "Dùng thử Gramify Plus" / "Nâng cấp để có giới hạn cao hơn" | AXStaticText | 1442 | −926/−908 | 132/153 | 16/12 | No |
| "Upgrade" | AXButton | 2051 | −925 | 70 | 29 | Yes |
| "English, English" language selector | AXButton | 1380 | −817 | 752 | 63 | Yes |
| "Đang học" caption | AXStaticText | 1383 | −840 | 49 | 13 | No |
| 13 settings rows (below) | AXButton | 1380 | −706… | 751 | 61 | Yes |
| "Gramify v1.1.2 (17)" | AXStaticText | 1708 | 223 | 95 | 11 | No |
| "Develop and Design by Huyt in Vietnam 🇻🇳" | AXStaticText | 1679 | 237 | 154 | 9 | No |

Settings rows in order (OBSERVED): "Chỉnh sửa hồ sơ" (edit profile) · "Cài đặt bài học" · "Giọng đọc" · "Giao diện" · "Thông báo" · "Gói đăng ký" (subscription) · "Nhập mã ưu đãi" (promo code) · "Mời bạn bè" · "Đánh giá ứng dụng" · "Gửi phản hồi" · "Điều khoản dịch vụ" · "Chính sách quyền riêng tư" · "Đăng xuất" (log out).
Section captions: "Cài đặt chung", "Khác". Row pitch 62–63. MEASURED.

**Blocked/unsafe (not opened):** edit profile (account data), subscription package, promo code (purchase flow), log out (auth). Per safety rules.
**Not explored:** lesson settings, voice, appearance, notifications, invite, rate, feedback, ToS, privacy, language selector, Upgrade button (paywall).

## S017 `history-review--default` — "Ôn tập"

Source: snapshot `ps1_02bd0b5ddd21fae84e917a567db1ea72`, screenshot [S017-history.png](../screenshots/S017-history.png).
Reached from Home bottom-left icon (AX "Rotate-Left--Streamline-Flex"). OBSERVED. Nav title "Ôn tập".

| Element | Role | Global x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| Back | AXButton | 1369 | −1126 | 33 | 33 | Yes |
| "Thêm" (filter/menu?) | AXButton | 1917 | −1123 | 27 | 27 | Yes |
| Search field "Tìm kiếm tiêu đề, mô tả..." | AXTextField | 1957 | −1122 | 184 | 27 | Settable |
| History cards ×3 | AXButton | 1380 | −1043/−846/−650 | 123 | 142 | Yes |
| "Xem thêm" ×3 | AXButton | 2080 | per card | 51 | 9 | Yes |
| Floating "+" button | AXButton (`plus`) | 1742 | −128 | 27 | 27 | Yes |

- Cards grouped by exercise type with a category label (OBSERVED): "Đoạn văn" (the Door-to-Hell paragraph, topic "Kỳ quan thiên nhiên"), "Câu" (grammar, "Lên thực đơn cả tuần", items 1–2), "Hội thoại" (conversation "Mở rộng vốn từ tự nhiên").
- The grammar and conversation entries exist although we never completed those exercises → seeded sample history. INFERRED.
- Scroll content 788×653. MEASURED.
- Not explored: card detail ("Xem thêm"), search, the floating "+".

## S018 `streak--default` — "Chuỗi Streak"

Source: snapshot `ps1_4f7d68dd5519bde77e311f153d3b3c87`, screenshot [S018-streak-progress.png](../screenshots/S018-streak-progress.png).
Reached from the Home streak pill "Chuỗi: 0 ngày". OBSERVED. (Menu "Chuỗi của tôi" presumably lands here too. INFERRED.)

| Element | Role | Global x | y | w | h | Interactive |
|---|---|---|---|---|---|---|
| Back | AXButton | 1369 | −1126 | 33 | 33 | Yes |
| "ON FIRE" micro-label | AXStaticText | 1386 | −1069 | 38 | 9 | No |
| "0" streak count | AXStaticText | 1380 | −1054 | 37 | 70 | No |
| "ngày liên tiếp" | AXStaticText | 1380 | −981 | 69 | 13 | No |
| Motivation "Bắt đầu chuỗi học tập ngay hôm nay!" | AXStaticText | 1380 | −954 | 120 | 26 | No |
| Month label "tháng 10 năm 2026" | AXStaticText | 1398 | −879 | 126 | 17 | No |
| Month chevrons | AXButton ×2 | 2082/2104 | −877 | 9 | 13 | Yes |
| "Đã học 0 ngày" | AXStaticText | 1398 | −858 | 63 | 11 | No |
| Weekday header CN T2–T7 | AXStaticText ×7 | 1444–2058, −831 | 8–11 | 9 | No |
| Day numbers 2–31 | AXStaticText ×30 | grid, −806…−671 | 5–12 | 11 | No |
| Stat: flame "HIỆN TẠI" 0 | image + texts | 1540–1571, −592/−577 | — | — | image Yes |
| Stat: bolt "DÀI NHẤT" 0 | image + texts | 1921–1953, −592/−577 | — | — | image Yes |

- Calendar grid: 7 columns, weekday headers localized Vietnamese abbreviations; month navigation via chevrons. Day cell pitch ≈ 102×34. MEASURED.
- Two stat tiles side by side (current / longest) with SF Symbol icons (flame.fill, bolt.fill). OBSERVED.
- Not explored: month chevrons (past months).
