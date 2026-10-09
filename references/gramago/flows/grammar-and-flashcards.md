# Flows: Grammar Mode, Flashcards, Menu, Utility Screens

> **Stale blocks corrected 2026-10-09:** the 'Menu navigation' table below lists Insight / Plus / Flow Letter / flag as INFERRED-unvisited — all are now OBSERVED (S033, S045, S034–S042, S043–S044). The 'Crawl stop' section is historical (the lock cleared in session 2). Grammar feedback is still not reached.

Captured 2026-10-08. Companion to [home-to-writing.md](home-to-writing.md). Tags: OBSERVED / INFERRED.

## Grammar flow (compressed)

```
S001 Home --card 02 NGỮ PHÁP--> S008 picker "Hoàn thiện ngữ pháp" --topic card--> S009 lesson list
  --"Sửa nhanh"--> S010 sentence editor --"Đóng"--> S007 dialog --"Thoát"--> S009 --Back--> S008 --Back--> S001
```

All transitions OBSERVED except "Ở lại" (not chosen). Template chain identical to writing mode; deltas: "N Qs" counts, PLUS tile first in grid, "Sửa nhanh" CTA, single-sentence prompt, "Nhập câu trả lời..." placeholder. Grammar feedback variant NOT REACHED (input automation blocked).

## Flashcard flow

```
S001 --Menu star--> S011 menu sheet --"Học flashcard"--> S012 deck list --deck card--> S013 deck detail
  --"Ôn tập (10)"--> S014 SRS tutorial --"Đã hiểu, bắt đầu học"--> S015 SRS active --"Đóng"--> S013 --Back×2--> S001
```

All transitions OBSERVED. Session exit needs no confirmation (contrast with exercise editors).

## Menu navigation (S011)

| Item | Destination | Tag |
|---|---|---|
| Insight | analytics/progress screen | INFERRED, unvisited |
| Nâng cấp Gramify Plus | paywall | INFERRED, deliberately unvisited |
| Học flashcard | S012 | OBSERVED |
| Chuỗi của tôi | S018 (same as streak pill) | INFERRED |
| Chơi FlowLetter | mini-game | INFERRED, unvisited |

## Utility screens (single hop from Home bottom bar)

| Control | Destination | Tag |
|---|---|---|
| Streak pill "Chuỗi: 0 ngày" | S018 Chuỗi Streak | OBSERVED |
| Left icon (Rotate-Left) | S017 history "Ôn tập" | OBSERVED |
| Right icon (Sun label / gear glyph) | S016 Profile/Settings | OBSERVED |
| Flag "US" | language switch | INFERRED, unvisited |

## Crawl stop

The macOS GUI session locked after S018; Back from S018 could not be verified (click failed: no pressable element; then capture refused: "session is locked"). The app is presumably still on S018. No further actions were attempted. OBSERVED.
