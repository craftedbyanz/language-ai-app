# Paywall "Nâng cấp Gramify+" — S045

Captured 2026-10-08. **View-only.** Opened once from the Home Plus banner ("Đăng ký Gramify Plus"), text read, screenshot taken, closed with the ✕. No plan, trial, restore, terms or privacy control was touched (CLAUDE.md rules 2–3).
Screenshot: [S045-paywall-plus.png](../screenshots/S045-paywall-plus.png). Tags: OBSERVED / MEASURED / ESTIMATED / INFERRED.

## Presentation

- **Half sheet** over Home (x 171–617 = 446 wide, y 304–811), same container geometry as the S006 feedback sheet and the S028 popover. Home behind it is **not dimmed**: the page background stays #F9FAFB and the banner stays saturated (a pixel check at (700,320) gives #F9FAFB in both S001 and S045). The grey mode card visible behind the sheet is the same #D4D4D5 it has in S001. The window's title-bar controls render grey in this capture (cause not tested). OBSERVED / MEASURED. (An earlier draft of this file wrongly called #D4D4D5 a scrim.)
- The sheet **scrolls** internally: the screenshot shows the header, hero, plan cards, start of the benefits list and the pinned CTA; more benefits exist below (AX lists 6). OBSERVED.
- Entry points known: Home banner (this one), Home Menu "Nâng cấp Gramify Plus" (S011), S008 PLUS tile, S016 "Upgrade" / "Gói đăng ký". Only the Home banner was opened. The others are INFERRED to open the same sheet.

## Content (top to bottom) — OBSERVED

| Block | Detail |
|---|---|
| Header | ✕ round button (left, light grey, "Đóng") + centred title **"Nâng cấp Gramify+"** |
| Hero | wordmark **"gramify ✨"** (large, black, ≈ 44 pt) over **"plus"** in brand blue (#4383FC) |
| Hero carousel | sub-copy "Mở khóa toàn bộ tính năng AI cao cấp với mức sử dụng cao hơn." and a 3-segment pager (active segment blue, others grey). The hero is a rotating message set: AX also holds the words "hạn mức / cao hơn" and "Mức sử dụng AI cao hơn so với gói Miễn phí. Tạo flashcard và học mọi chủ đề." |
| Plan cards (2, single-select) | **Hàng năm** — radio selected, "đ29.083 / tháng", badge **"Giảm 40%"** (blue pill #4383FC, white text) on the top edge, price **349.000đ / năm**, "7 ngày miễn phí, sau đó 349.000đ". **Hàng tháng** — radio empty, "đ49.000 / tháng", **49.000đ / tháng**, "3 ngày miễn phí, sau đó 49.000đ". Selected card: pale-blue fill #F0F5FF + blue border (#4383FC); unselected: white with hairline border |
| Benefits | heading **"Đặc quyền gói Gramify Plus"**, sub "Mở khóa toàn bộ tính năng cao cấp để học ngoại ngữ hiệu quả hơn, nhanh hơn và thú vị hơn."; 6 rows (SF-symbol icon + title + 2-line body): **Hạn mức cao hơn** · **Kho Flashcard mở rộng** · **Chat AI nhiều hơn** · **Chế độ Vô cực** (infinity icon; "luyện câu nâng cao với độ khó tăng dần") · **Truy cập sớm các tính năng** · **Tất cả ngôn ngữ** + small "coming soon" tag |
| Pinned footer | dark CTA (fill #131827, white text) **"Dùng thử 7 ngày • sau đó 349.000đ/năm"** (≈ 411×40, radius ≈ 19–20 = full pill at that height) + caption "Dùng thử miễn phí 7 ngày. Sau đó tự động gia hạn với giá 349.000đ/năm. Hủy bất cứ lúc nào." |
| Legal row | text buttons **Điều khoản · Quyền riêng tư · Khôi phục** (Restore) |
| Fine print | "Sau khi mua, bạn có thể quản lý và tắt tính năng tự động gia hạn trong cài đặt tài khoản iTunes & App Store của mình." |

## Design / UX observations

- The CTA copy follows the selected plan ("Dùng thử 7 ngày …/năm"); the monthly plan's CTA copy was not observed (needs a selection change; not done). INFERRED that it reads "Dùng thử 3 ngày …".
- **Annual is pre-selected** and shows the per-month equivalent as the secondary price, a standard anchoring pattern. OBSERVED.
- The pricing is in **VND** (storefront-dependent). OBSERVED.
- The ✕ is the only dismiss affordance; no grabber was exposed to AX. OBSERVED.
- Brand blue on this sheet (#4383FC) differs from the Home Plus banner (#3B82F6) and from the in-chat indigo (#475DE8), so there are at least three blues in the product. MEASURED.
- Terms/Privacy/Restore are present from a store-compliance standpoint (App Store requires Restore). INFERRED.

## Not explored (by policy)

Plan switch, CTA outcome, Restore, Terms, Privacy, scrolling to the benefits' end, any success/error states.
