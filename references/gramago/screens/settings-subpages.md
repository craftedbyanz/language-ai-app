# Settings sub-pages — S048 Lesson Settings, S049 Appearance, S050 Voice

Captured 2026-10-08 from Profile/Settings (S016, rows "Cài đặt bài học", "Giao diện", "Giọng đọc"). **Read-only: no swatch, style tile, toggle, reorder handle or Reset was touched.** All three were left via the nav Back button, which is labelled **"Profile"** on each (parent title). Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED.

**Window size note.** These captures are **554×772**, not 788×1083. The app window changed size between S046 (788×1083) and S047 (554×772) with no crawl action issuing a resize. Cause UNKNOWN; the window also briefly could not be found (minimized-window candidates) just before that. Widths and positions measured on them are *not* comparable with S001–S046; colours, radii and relative layout are.

The page background on every sub-page is **#F9FAFB** with white (#FFFFFF) rounded section cards. MEASURED.

## S048 "Lesson Settings" — [S048-settings-lesson-settings-554x772.png](../screenshots/S048-settings-lesson-settings-554x772.png)

Nav title is English ("Lesson Settings") although the Profile row is Vietnamese ("Cài đặt bài học"). OBSERVED.

| Block | Detail |
|---|---|
| Live preview | top card (fill #F3F4F6, radius ≈ 20): a round **swap** button (blue #4E80EE, white ⇅ icon), a large rounded **answer field in the chosen colour** (#4E80EE, placeholder "Nhập bản dịch của bạn…" in translucent white; radius ≈ 18–19), and a row of three blurred word-chips with ↶ undo and → submit at the ends — i.e. a **miniature of the exercise editor** (S004) |
| "Màu ô nhập" (answer-box colour) | white card, 4×2 grid of round swatches (≈ 28 pt) with captions: **Default #4E80EE** (selected, white ✔), **Orange #F09343**, **Yellow #F7CE46**, **Green #65C466**, **Blue #3B86F7**, **Pink #EB445A**, **Purple #BB3ED9**, **Indigo #6466E9** |
| "Cài đặt gợi ý" | row with a struck-through light-bulb icon, **"Luôn hiển thị gợi ý"** + "Hiển thị từ gợi ý mà không cần chạm", and a toggle (**off**, track #B9B9BA) |

- This explains the editor-card colours seen earlier: S004's answer card was **purple #A855F7** and S010's was **iOS blue #007AFF**; both are (inferred) *user-configurable* "input-box colour" values or mode defaults, not fixed design tokens. INFERRED.
- "Default" (#4E80EE) is **not** the colour either earlier editor used (#A855F7 writing, #007AFF grammar), so "Default" is probably a per-mode default. INFERRED.

## S049 "Appearance" — [S049-settings-appearance-554x772.png](../screenshots/S049-settings-appearance-554x772.png)

Nav title **"Appearance"** (English). OBSERVED.

| Block | Detail |
|---|---|
| Live preview | top carousel replica of the **Home mode cards** ("TRANSLATION · Paragraph · 01 · 'Master sentence structure & flow.' · EXPLORE ↗" and a peeking purple "GRAMMAR · Quick Fix"), clipped with a bottom fade. Card colours: Paragraph #608DEF→#AEC3F3 (fade), Quick Fix #9271EE. By contrast the real Home mode cards looked **flat grey** in S001, S011 and S045 but **blue** in an unsaved capture taken with the Menu overlay open; cause UNKNOWN (load/transition animation, or a style effect). Do not take the grey as the card's real colour |
| Style picker | 4 tiles, each ≈ 126×86 white card with a coloured dot over the label: **Regular** (blue gradient dot), **Mono** (dark grey #4D5562), **Minimal** (white ring), **Glass** (lilac #BBA3F6). **Glass is selected** (2 pt dark outline). These are INFERRED to be *card styles* for the Home carousel (the preview above them changes with the pick; not tested) |
| "Card Order" + **Reset** | list card (white) of 3 rows with a pastel-tinted rounded-square icon, **Paragraph / Translation**, **Quick Fix / Grammar**, **Speaking / Dialogue**, and a drag handle (≡) at the right (AX "Reorder …"): the Home card order is user-reorderable |

- The three names (Paragraph/Quick Fix/Speaking · Translation/Grammar/Dialogue) are the **internal English names** of the modes. The Home cards use "Đoạn văn / Sửa câu / Hội thoại". OBSERVED.
- Because this carousel is a *preview of Home*, the **Home card look is configurable**. The earlier Home screenshots therefore show one variant (Glass) of four. That matters for the clone: the "ModeCard" has 4 visual styles. INFERRED.
- Row "Giao diện" is *not* a dark-mode switch. It shows no light/dark option; dark mode remains UNOBSERVED. OBSERVED.

## S050 "Giọng đọc" (Voice) — [S050-settings-voice-no-models-554x772.png](../screenshots/S050-settings-voice-no-models-554x772.png)

- Nav: Back ("Profile"), centred title "Giọng đọc", trailing round **?** button (opens a "Xem hướng dẫn" guide; not tapped). OBSERVED.
- Hero: blue/teal **audio-waveform** icon, H1 **"Neural Voice Engine"**, sub "Gramify sử dụng công nghệ Neural Audio của Apple để mang lại trải nghiệm nghe tự nhiên và sống động nhất." Section "Voice Models" (English).
- Card (white): orange **cloud-download** icon (#F09343), **"Chưa có giọng Neural Engine"**, "Vui lòng tải giọng Premium hoặc Enhanced trong Cài đặt Iphone của bạn để sử dụng." and a blue link **"Xem hướng dẫn"**. This is an **empty state** (no premium voices installed); the populated list (voice rows) was **not** seen. OBSERVED.
- The copy says "Iphone" while the app is running on macOS: the app is an iOS app run on Mac (Designed for iPad/iPhone); the observed UI is the iOS layout. INFERRED.
