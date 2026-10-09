# Flow log — session 2: conversation, Insight, Flow Letter, extras

Captured 2026-10-08 with the Peekaboo CLI. Each row: state read **before** the action → action → state read **after**. All clicks returned "dispatched but not verified"; results below come from the following read. Tags: OBSERVED / INFERRED.

| # | From | Action | To | Notes |
|---|---|---|---|---|
| 1 | S018 (AX: "Chuỗi Streak", ON FIRE 0) | click Back | S001 | OBSERVED; closes the earlier INFERRED edge |
| 2 | S001 | click card 03 GIAO TIẾP | S019 | AX showed only "Đóng" + "Tùy chỉnh Bài học": a coachmark *over* the picker |
| 3 | S019 | click coachmark "Đóng" | S020 | picker visible; coachmark gone |
| 4 | S020 | click topic card | S021 | AX: "Bài học", "Bắt đầu chat", AI card |
| 5 | S021 | click "Bắt đầu chat" | S022 | AI opening message already present; composer field auto-focused |
| 6 | S022 | click "Thêm" | S023 | menu in AX (3 items); **not in the screenshot** |
| 7 | S023 | click "Ẩn bản dịch" | S024 | VI lines removed |
| 8 | S024 | "Thêm" → "Hiện bản dịch" | S022-like | restored |
| 9 | S022 | typed text via background AX | (no change) | `Type outcome is indeterminate`; screenshot showed an empty field |
| 10 | S022 | typed text via foreground | S022 + corrupted text | field read "I have bên lẻaning Englíh lately." (Telex) |
| 11 | S022 | foreground type with `--clear` | S025 | "Hello, I am OK, thank you." intact; send button enabled (#475DE8) |
| 12 | S025 | click send | S026 | bubble right, typing dots left, composer cleared, send disabled |
| 13 | S026 | wait ≈ 6 s | S027 | AI reply (EN + VI) and chip "58 · Câu đúng ngữ pháp nhưng chưa tự nhiên trong hội thoại." |
| 14 | S027 | click score chip | S028 | blank white panel 446×≈508; AX tree incomplete ×3 reads; not rendered by window capture, area capture or native `screencapture` over ≈ 15 s |
| 15 | S028 | press Escape (foreground) | S028 | **no change** |
| 16 | S028 | foreground click outside, `--input-strategy synthOnly` | S027 | panel closed (background coordinate click was refused: no pressable element) |
| 17 | S027 | click "Đóng" | S007 dialog | "Thoát bài tập?" — same copy as writing/grammar |
| 18 | S007 | click "Thoát" | S021 | chat discarded |
| 19 | S021 | click AI card | S029 | "TẠO BẰNG AI / CHỌN CHỦ ĐỀ"; list starts "Gọi món ở nhà hàng, Khiếu nại của khách hàng…" (S029 screenshot is from this entry) |
| 20 | S029 | click "Đóng" | S021 | |
| 21 | S021 | Back | S020 | |
| 22 | S020 | click nav "AI" | S029' | same layout, **different scenario list** ("Thảo luận về ước mơ, Đi khám bác sĩ…") |
| 23 | S029' | click "TÙY CHỈNH" | S029' | no change (AX tree and a capture were identical; it is the already-selected row) |
| 24 | S029' | click "MÔ TẢ CHỦ ĐỀ" | S030 | sheet "Tạo Hội Thoại"; CTA disabled; nothing typed |
| 25 | S030 | click ✕ → click "Đóng" | S029' → S020 | then FAB click by coordinate (needs a *screenshot* snapshot, not a tree-only one) → S031; AX added "Trò chuyện Tự do", "Giọng: Thoải mái", "Thông Tin", "Đóng" |
| 26 | S031 | click "Thông Tin" | S032 | half sheet "Hướng dẫn Cài đặt" |
| 27 | S032 | click ✕ → click FAB "Đóng" | S020 | |
| 28 | S020 | Back | S001 | |
| 29 | S001 | click Menu (AX lags: first read still Home; capture showed overlay; re-read showed the items) | S011 | |
| 30 | S011 | click "Insight" | S033 | |
| 31 | S033 | click Back | S001 | menu closed |
| 32 | S001 | Menu → "Chơi FlowLetter" | S034 | tutorial overlay |
| 33 | S034 | click "Chạm để bắt đầu" | S035 | |
| 34 | S035 | click "Chơi" | S036 | topic select (screenshot first misnamed "gameplay"; renamed) |
| 35 | S036 | click "Nature" | S037 | |
| 36 | S037 | click "Gợi ý" | S037 | no visible change (capture discarded) |
| 37 | S037 | Quay Lại ×2 | S039 | resume row appeared |
| 38 | S039 | "Độ khó" / "Cài đặt" / "?" each → Back | S040 / S041 / S042 → S039 | each observed and left; no values changed |
| 39 | S039 | click "Đóng" | S001 | no dialog |
| 40 | S001 | click flag "US" | S043 | pushed language screen |
| 41 | S043 | click level row | S044 | |
| 42 | S044 → S043 → S001 | Back ×2 | S001 | "A1 – Beginner" unchanged |
| 43 | S001 | click Plus banner | S045 | view only |
| 44 | S045 | click "Đóng" | S001 | |
| 45 | S001 | click "Tạo bài học với AI" | S046 | capture looked mid-transition twice (grey wash); re-captured after 2 s, same |
| 46 | S046 | click chevron handle | S001 | |
| 47 | S001 | click Gramify 101 tile "3 Chế Độ…" | S047 | window now 554×772 |
| 48 | S047 | Back | S001 | |
| 49 | S001 | click gear → "Cài đặt bài học" / "Giao diện" / "Giọng đọc" | S048 / S049 / S050 | each left via Back ("Profile") |

Between #46 and #47 the window could not be found for one capture and its size changed; see REVERSE_ENGINEERING_REPORT.md.
