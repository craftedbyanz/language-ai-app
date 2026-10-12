# Feature Specification: Grammar Fidelity Alignment

**Feature Branch**: `[002-grammar-fidelity-alignment]`

**Created**: 2026-10-11

**Status**: Implemented

**Input**: User description: "Continue the project by aligning the implemented Home-to-Grammar journey with the authorized frozen GramaGo reference evidence while preserving the product's own content, branding, architecture, and accessibility requirements."

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Practice in a Faithful Exercise Workspace (Priority: P1)

A learner opens a Grammar lesson and works in an exercise workspace whose visual hierarchy, proportions, progress treatment, prompt surface, answer surface, hint row, and submit affordance match the intended reference experience. The task remains the product's authored English sentence-correction exercise rather than copying third-party learning content.

**Why this priority**: The exercise is the core learning surface and currently carries the largest high-impact differences in proportions, alignment, progress density, and control placement.

**Independent Test**: Open the demonstration Grammar lesson at the canonical reference viewport, compare the empty and filled exercise states against the approved visual landmarks, and complete one submission without clipped content or ambiguous controls.

**Acceptance Scenarios**:

1. **Given** the first Grammar exercise is open at the canonical reference viewport, **When** the learner views the empty state, **Then** the prompt and answer surfaces use the approved vertical proportions, the task text is visually centered as specified, progress is understandable, and hints plus Submit remain reachable.
2. **Given** the answer field is empty, **When** the learner enters a nonblank response, **Then** the response remains legible on the canonical blue answer surface and Submit changes from a clearly disabled state to a clearly enabled state without moving to an unexpected location.
3. **Given** the viewport becomes compact, wide, short, or uses large text, **When** the learner continues the exercise, **Then** the same content and actions reflow without overlap, clipping, or loss of logical reading order.

---

### User Story 2 - Browse Grammar Through Faithful Contextual Screens (Priority: P2)

A learner enters Grammar from Home, chooses a topic, and chooses a lesson through screens that preserve the distinctive visual hierarchy of the reference journey: a recognizable mode card, a two-tone topic hero and filter rail, and a centered lesson-collection hero followed by a horizontal lesson carousel.

**Why this priority**: The browse journey establishes mode identity and context before practice. The current topic grid is close, but Home and Lesson List differ materially in anatomy and information hierarchy.

**Independent Test**: Navigate Home → Grammar Topic Picker → Grammar Lesson List at the canonical viewport and verify the required contextual information, card anatomy, carousel behavior, and navigation at each step.

**Acceptance Scenarios**:

1. **Given** Home is visible, **When** the learner views or activates the Grammar mode entry, **Then** its category, title, index, description, and action follow the canonical mode-card hierarchy and remain one coherent target.
2. **Given** the Grammar Topic Picker is visible, **When** the learner filters or selects a topic, **Then** the two-tone hero, horizontal filters, topic-section context, card grid, counts, and navigation remain consistent and usable.
3. **Given** a topic is selected, **When** the Lesson List opens, **Then** it shows topic-specific collection context, level, description, lesson position, title, summary, action, and decorative illustration placement in the approved hierarchy.
4. **Given** multiple lessons are present, **When** the learner uses touch, pointer, trackpad, or keyboard navigation, **Then** the carousel and its position indicator move to the same lesson and expose an accurate one-based position.

---

### User Story 3 - Understand Faithful Correct and Incorrect Feedback (Priority: P3)

A learner receives compact correct feedback or detailed incorrect feedback that visually corresponds to the exercise context, clearly identifies the verdict, and makes corrections understandable at word level while keeping recovery and progression actions obvious.

**Why this priority**: Feedback is the teaching moment. The current correct variant is structurally close, while the incorrect variant loses the reference's word-level correction model and contextual placement.

**Independent Test**: Submit one authored correct answer and one authored incorrect answer, compare both feedback states against their approved landmarks, then exercise Fix, minimize/reopen, and Next.

**Acceptance Scenarios**:

1. **Given** an incorrect response, **When** feedback appears, **Then** removed, retained, and replacement words are distinguishable without relying on color alone, followed by explanation, tips, Fix, and Next.
2. **Given** a correct response, **When** feedback appears, **Then** the compact verdict shows the learner's answer, the unavailable analysis affordance and reason, and one clear Next action.
3. **Given** either feedback variant is open, **When** the learner minimizes and reopens it, **Then** the same verdict returns without another grading operation or loss of response/progress.
4. **Given** a short viewport or large text, **When** feedback content exceeds the available area, **Then** content can be read and every action remains reachable.

---

### User Story 4 - Retain Accessible and Adaptive Equivalence (Priority: P4)

A learner using keyboard navigation, assistive technology, touch, mouse, or trackpad can complete the aligned journey with the same information and actions available in English and Vietnamese product chrome.

**Why this priority**: Visual fidelity must not regress the stronger accessibility and adaptive behavior already present in the client.

**Independent Test**: Complete the browse, exercise, and both feedback paths in both supported chrome languages using keyboard-only and semantic navigation at compact, regular, and wide layouts.

**Acceptance Scenarios**:

1. **Given** keyboard navigation is active, **When** the learner traverses the journey, **Then** focus is visible, ordered, restored to the correct trigger, and every supported action can be activated with standard keys.
2. **Given** assistive technology is active, **When** loading, errors, progress, verdicts, or carousel position changes, **Then** the change is announced with a meaningful localized role, name, state, and value.
3. **Given** Vietnamese product chrome is active, **When** the learner completes the journey, **Then** application chrome is consistently Vietnamese while authored learning content remains unchanged.

### Edge Cases

- The lesson contains fewer or more practice steps than the reference demonstration lesson; visual progress and semantic progress must both remain truthful.
- A topic has no selectable lessons or the catalog fails while browse chrome is already visible.
- The longest lesson title, description, hint, correction, explanation, or translated chrome label exceeds its reference-length sample.
- A correction contains repeated words, punctuation-only changes, insertions at sentence boundaries, or multiple adjacent replacements.
- The viewport is shorter than the feedback card, uses a software keyboard inset, or applies 200% text scaling.
- Feedback is dismissed from its initial presentation versus dismissed after reopening from the hint row; focus must return to the actual trigger in each case.
- A pointer hovers a card or control while keyboard focus is retained; neither input modality may hide the other's required state.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The aligned journey MUST cover the existing Home Grammar entry, Grammar Topic Picker, Grammar Lesson List, Grammar exercise empty/filled states, loading, correct feedback, and incorrect feedback.
- **FR-002**: The frozen evidence states S001, S008, S009, S058, S059, S060, and S061 MAY be used only as authorized read-only verification evidence; the product-independent design system MUST remain the implementation authority after reconciliation.
- **FR-003**: The feature MUST preserve the product's own branding, localized application chrome, and authored learning content; it MUST NOT copy third-party names, logos, proprietary illustrations, or lesson copy.
- **FR-004**: The feature MUST preserve the established sentence-correction task: one intentionally incorrect English source sentence, an instruction to rewrite it correctly, authored acceptable answers, and deterministic demonstration grading.
- **FR-005**: The Home Grammar entry MUST present category, index, title, description, and action using the canonical mode-card hierarchy as one accessible target, without introducing unrelated Home capabilities.
- **FR-006**: The Topic Picker MUST retain a two-tone mode hero, a horizontally navigable filter rail, topic-section context including an accurate visible count, and an adaptive topic grid whose cards expose varied meaningful icon slots, title, and exercise or lesson count.
- **FR-007**: The Topic Picker MUST omit paywall and AI-generation entry points unless a separate approved feature enables them; their absence MUST NOT leave broken spacing or inactive controls.
- **FR-008**: The Lesson List MUST present topic-specific collection context in a centered hero region, including collection label, topic title, topic description, and level where supplied.
- **FR-009**: Each Grammar lesson card MUST present lesson index, title, description, primary action, and an optional product-owned decorative illustration in the approved visual order; the entire action region MUST resolve to the same lesson selection intent.
- **FR-010**: The lesson carousel MUST reveal the next item, support direct and directional navigation, and expose an accurate localized one-based position and total.
- **FR-011**: The exercise workspace MUST preserve the reference hierarchy of progress, prompt surface, answer surface, hint row, and trailing submit control while keeping the product-specific correction instruction visible.
- **FR-012**: Exercise progress MUST accurately represent the number of authored steps in the selected lesson. The canonical demonstration lesson MUST contain enough authored steps to reproduce the approved dense Grammar progress treatment without displaying false progress.
- **FR-013**: At the canonical reference viewport, the prompt and answer surfaces MUST occupy the approved dominant vertical workspace, with sentence and response content aligned for focused reading rather than compressed into top-only utility cards.
- **FR-014**: Empty, focused, filled, submitting, and disabled answer states MUST use the canonical Grammar answer-palette pair and retain readable caret, text, placeholder, and focus treatment.
- **FR-015**: Hints and Submit MUST remain reachable at every supported viewport and text scale. Hidden hints MUST not expose their answer text before learner activation.
- **FR-016**: Incorrect feedback MUST distinguish the learner's original words from retained and replacement words at word level, including punctuation, and MUST provide non-color cues for every correction state.
- **FR-017**: Incorrect feedback MUST retain the canonical sequence of verdict, correction, explanation, tips, Fix, and Next; correct feedback MUST retain verdict, answer recap, unavailable analysis explanation, and a single Next action.
- **FR-018**: Feedback MUST appear contextually over the exercise workspace with canonical width and height limits, without a full-screen scrim, and MUST preserve visibility or recoverability of the exercise context.
- **FR-019**: Loading, grading failure, Cancel, Retry, Fix, minimize/reopen, non-final Next, and final return MUST preserve the existing deterministic workflow guarantees and MUST NOT introduce automatic mutation retries.
- **FR-020**: Visual alignment MUST preserve meaningful semantics, localized names, target sizes, contrast, visible focus, hover parity, logical traversal, Enter/Space activation, Escape behavior, and focus restoration.
- **FR-021**: The journey MUST remain usable at compact, regular, and wide widths, short height, software-keyboard inset, and 200% text scaling without clipped primary actions or horizontal content loss outside intentional carousels.
- **FR-022**: The feature MUST preserve existing typed navigation, repository ownership, route-scoped workflow disposal, invalid-identity handling, regional browse errors, and Writing behavior.
- **FR-023**: The feature MUST NOT add backend integration, AI grading, persistence, completion rewards, purchases, authentication, Conversation, Flashcards/SRS, Flow Letter, or other unimplemented product areas.
- **FR-024**: Every accepted visual change MUST be reconciled into the canonical design-system contract before or with product implementation, and unexplained raw visual values are prohibited.

### Key Entities

- **Grammar Topic Context**: The selected topic's identity, authored title, description, level, and ordered lessons used to form the Topic Picker and centered Lesson List hero.
- **Grammar Lesson**: An ordered practice collection with identity, level, title, description, optional product-owned illustration key, and non-empty ordered exercises.
- **Grammar Sentence Exercise**: One authored sentence-correction task with an incorrect English sentence, acceptable full-sentence answers, hints, explanation, and tips.
- **Correction Segment**: One ordered portion of feedback text classified as retained, removed, or inserted/replacement content, including punctuation and a non-color semantic label.
- **Visual Landmark**: A named observable region or relationship used for comparison, such as hero alignment, card bounds, workspace split, action placement, or sheet bounds.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: At the canonical 788×1083 reference viewport, at least 90% of the defined landmarks for S008, S009, S058, S059, S060, and S061 are within 8 logical pixels or 2% of the approved position/size relationship, whichever tolerance is larger.
- **SC-002**: A learner can complete Home → topic → lesson → one correct verdict → Next and one incorrect verdict → Fix/Next with no clipped content, hidden primary action, duplicate grading, or unintended extra progression.
- **SC-003**: All required controls remain reachable and readable at compact, regular, and wide widths plus a short-height 200%-text case with a nonzero software-keyboard inset.
- **SC-004**: Keyboard-only and semantic-navigation checks complete every supported action in both English and Vietnamese chrome with zero unnamed interactive targets, zero color-only verdict/correction meanings, and correct focus restoration after every feedback transition.
- **SC-005**: The existing Writing journey behavior and non-Home visual baselines remain unchanged, all previously passing Grammar behavioral scenarios continue to pass, and any shared Home mode-card baseline change is explicitly reviewed as part of this feature rather than treated as an unrelated rebaseline.
- **SC-006**: A manual side-by-side review of the seven authorized reference states records PASS/FAIL for every landmark and documents every intentional divergence; no unexplained divergence remains.

## Assumptions

- The alignment target is visual hierarchy and interaction behavior, not duplication of third-party branding, assets, or lesson copy.
- The existing English sentence-correction learning model remains an approved product decision even though the reference evidence uses Vietnamese-to-English translation prompts.
- The existing production color profile, adaptive size classes, localization boundary, and accessibility contract remain authoritative.
- The authorized reference archive remains read-only; this feature adds no screenshots or research states to it.
- Optional paywall, AI-generation, completion, and unrelated mode surfaces remain outside this feature.
- Existing uncommitted changes are user-owned and must be preserved; overlapping changes require careful reconciliation rather than replacement.
