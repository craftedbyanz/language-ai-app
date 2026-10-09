# Language select & CEFR level — S043, S044; plus Home AI composer S046 and Gramify 101 S047

Captured 2026-10-08. **Observation only: nothing was selected or confirmed.** "Xác nhận" was never pressed on either screen (CLAUDE.md rule 3). Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED.

## S043 "Ngôn ngữ học" (language select)

Reached from the Home flag button (AX "US", top-right). It is a **pushed screen**, not a popover (Back button + centred title). Screenshot: [S043-language-select-screen.png](../screenshots/S043-language-select-screen.png).

| Block | Detail |
|---|---|
| Nav | Back (round, left), centred title **"Ngôn ngữ học"** |
| Hero | teal chat-translate illustration, title **"Chọn ngôn ngữ học"**, sub "Gramify hiện hỗ trợ lên tới 4 ngôn ngữ và sẽ mở rộng thêm trong tương lai." |
| List "Ngôn ngữ" | 4 white cards (≈ 750×62–64, radius ≈ 17): **English** (US flag, small orange star badge, selected: heavier outline) with sub "English"; **Korean / 한국어**, **Chinese / 中文**, **Japanese / 日本語** — each with an orange **"Coming soon"** tag (small pill, fill #FDEFE6, orange text) and dimmed text. AX buttons for the three disabled languages still exist |
| Level row | card **"TRÌNH ĐỘ HIỆN TẠI / A1 – Beginner ›"** (≈ 750×48) → opens S044 |
| CTA | full-width pill **"Xác nhận"** in cyan **#4CD0EC** (≈ 750×42) pinned to the bottom |

- So the flag is a **language-and-level preference screen**, not a quick toggle. Only English is available; the other three are placeholders. OBSERVED.
- The accent here is **cyan** (#4CD0EC) while the level screen's identical-position CTA is **green** (#2CB782): per-screen accent colours. MEASURED.
- Whether "Xác nhận" saves-and-returns or only confirms the choice is UNKNOWN (never pressed). Selecting a different language was impossible (Coming soon).

## S044 "Chọn cấp độ" (CEFR level)

Pushed from the level row. Screenshot: [S044-language-level-select-screen.png](../screenshots/S044-language-level-select-screen.png).

- Nav: Back labelled **"Ngôn ngữ học"** (parent title), centred title **"Chọn cấp độ"**. OBSERVED.
- Copy: "Khung tham chiếu ngôn ngữ chung châu Âu (CEFR) chia trình độ thành 6 cấp, từ người mới bắt đầu đến thành thạo." and a teal link-styled sentence "AI sẽ tạo ra các bài viết dựa trên trình độ của bạn, hãy chọn mức độ phù hợp nhất." (teal ≈ #208DAF). OBSERVED.
- Section title **"Trình độ của bạn"**, then 6 rows: title (bold) + 1–2 line Vietnamese description + a radio at the right; **a coloured vertical bar** at the left edge of every row (≈ 3×30 pt, taller for two-line rows) forms a traffic-light scale:

| Level | Bar colour (sampled) | Row title | Selected |
|---|---|---|---|
| A1 | #2BC25C (green) | A1 – Beginner | ✔ (current) |
| A2 | #7FCA25 (lime) | A2 – Elementary | |
| B1 | #E3B425 (yellow) | B1 – Intermediate | |
| B2 | #F27626 (orange) | B2 – Upper Intermediate | |
| C1 | #E74B46 (red) | C1 – Advanced | |
| C2 | #D4322A (dark red) | C2 – Proficient | |

- Selected radio = filled **#2CB782** circle with a white check (≈ 16 pt). Unselected = empty ring. OBSERVED / MEASURED.
- Row descriptions are *writing-ability* statements (e.g. A1: "Có thể viết lại và hoàn thành các câu rất ngắn với từ vựng quen thuộc…"). OBSERVED.
- Bottom CTA: full-width pill **"Xác nhận"** in green **#2CB782** (≈ 750×40). OBSERVED / MEASURED.
- This level feeds the lesson list's "CẤP ĐỘ · A1" pill seen in S003/S009/S021. INFERRED.
- Back (without Xác nhận) returned to S043 with "A1 – Beginner" unchanged, then to Home. OBSERVED.

## S046 Home AI composer ("Tạo bài học với AI")

Screenshot: [S046-home-ai-composer-sheet-empty.png](../screenshots/S046-home-ai-composer-sheet-empty.png). Opened from the Home link "Tạo bài học với AI" (tapping the text, not the icon).

- **Full-window sheet** that slides over Home; at the top a small **chevron-down handle** (AX button "Dấu Chữ V Nhỏ Gọn Hướng Xuống Dưới") dismisses it. The Home content stays in the AX tree beneath it. OBSERVED.
- During the slide the capture looked greyed-out; the re-capture 2 s later looked the same, so the sheet's own background is a flat **light grey (≈ #E8E8E8)** with a faint blue-lilac glow at the bottom. INFERRED (could not distinguish a fully settled state from a still-dimmed one).
- Centre: title **"Học theo cách của bạn."** + sub "Muốn luyện nhanh, tạo tình huống riêng hay sửa lỗi tiếng Anh, mình đều có thể tùy chỉnh theo nhu cầu của bạn." OBSERVED.
- Bottom: a horizontally scrolling row of suggestion chips (white pills): "Phrasal verbs phổ biến trong kinh doanh", "Mô tả sở thích của bạn chi tiết", "Tiếng Anh để giới thiệu bản thân tự tin", "Mẫu câu hữu ích cho chăm sóc khách hàng"; below a pill input with a faint **gradient border** (yellow-green→blue glow) and placeholder **"Nhập chủ đề bạn muốn học…"**, plus a round up-arrow send button (disabled until text). OBSERVED.
- An AX label "Ask AI about Đoạn văn…" exists (probably the accessibility title of the sheet / context hint). OBSERVED.
- Never submitted (would call the AI and could create a lesson).

## S047 "Gramify 101" detail ("3 Chế Độ Luyện Tập Chính")

Screenshot: [S047-gramify101-detail-3-modes-554x772.png](../screenshots/S047-gramify101-detail-3-modes-554x772.png) — **554×772**, not 788×1083, because the app window had been resized by something outside the crawl (see report). Pushed from the Home "Gramify 101" tile row (7 tiles, AX only: 3 Chế Độ Luyện Tập Chính, Trợ Lý AI & Hệ Thống Phản Hồi, AI Magic Generator, Hệ thống Flashcard & SRS, Hệ Thống Theo Dõi Tiến Độ, Chức Năng Ôn Tập Thông Minh, Mini Game: Flow Letter). Only the first was opened.

- Nav: Back + centred title (the tile title). Large lilac **illustration card** (≈ 528×448, fill ≈ #F1EFFD) showing a three-segment control with a bolt icon in the centre (the other two items are faded); then H1 **"3 Chế Độ Luyện Tập Chính"** and a bulleted article: *Đoạn văn (Paragraph)*, *Luyện câu (Sentence)*, *Hội thoại (Conversation)* with its two sub-modes **'Kịch bản'** and **'Tự do'**. OBSERVED.
- It is an **article/explainer template**; the other six tiles are INFERRED to reuse it. The product vocabulary here ("Paragraph / Sentence / Conversation") differs from the Home cards ("Đoạn văn / Sửa câu / Hội thoại") and the Appearance screen ("Paragraph / Quick Fix / Speaking"): three naming sets for the same three modes. OBSERVED.
