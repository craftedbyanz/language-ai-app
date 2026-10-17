// GENERATED CODE - DO NOT EDIT.
// Source: design-system/TOKENS.json

import 'package:flutter/material.dart';

enum ColorProfile { production, fidelity }

/// Canonical paired colors; never derive a foreground from a background.
class AnswerColors {
  const AnswerColors({required this.background, required this.foreground});
  final Color background;
  final Color foreground;
}

class AccessibleTokens {
  const AccessibleTokens({this.profile = ColorProfile.production});
  final ColorProfile profile;

  /// accessible.brandFill
  Color get brandFill =>
      profile == ColorProfile.fidelity ? Color(0xFF3B82F6) : Color(0xFF2563EB);

  /// accessible.diffAddedText
  Color get diffAddedText =>
      profile == ColorProfile.fidelity ? Color(0xFF10B981) : Color(0xFF047857);

  /// accessible.diffRemovedText
  Color get diffRemovedText =>
      profile == ColorProfile.fidelity ? Color(0xFFEF4444) : Color(0xFFDC2626);

  /// accessible.errorText
  Color get errorText =>
      profile == ColorProfile.fidelity ? Color(0xFFEF4444) : Color(0xFFDC2626);

  /// accessible.errorTextOnTint
  Color get errorTextOnTint =>
      profile == ColorProfile.fidelity ? Color(0xFFEF4444) : Color(0xFFB91C1C);

  /// accessible.focusRing
  Color get focusRing =>
      profile == ColorProfile.fidelity ? Color(0xFF3B82F6) : Color(0xFF2563EB);

  /// accessible.heroSecondLine
  Color get heroSecondLine =>
      profile == ColorProfile.fidelity ? Color(0xFF9AA0AB) : Color(0xFF676D7A);

  /// accessible.link
  Color get link =>
      profile == ColorProfile.fidelity ? Color(0xFF3B82F6) : Color(0xFF2563EB);

  /// accessible.onBrand
  Color get onBrand =>
      profile == ColorProfile.fidelity ? Color(0xFFFFFFFF) : Color(0xFFFFFFFF);

  /// accessible.onFeatureFill
  Color get onFeatureFill =>
      profile == ColorProfile.fidelity ? Color(0xFFFFFFFF) : Color(0xFF0B0F21);

  /// accessible.onGradeFill
  Color get onGradeFill =>
      profile == ColorProfile.fidelity ? Color(0xFFFFFFFF) : Color(0xFF0B0F21);

  /// accessible.partialText
  Color get partialText =>
      profile == ColorProfile.fidelity ? Color(0xFF3B82F6) : Color(0xFF2563EB);

  /// accessible.scoreHighText
  Color get scoreHighText =>
      profile == ColorProfile.fidelity ? Color(0xFF10B981) : Color(0xFF047857);

  /// accessible.scoreLowText
  Color get scoreLowText =>
      profile == ColorProfile.fidelity ? Color(0xFFEF4444) : Color(0xFFDC2626);

  /// accessible.scoreMidText
  Color get scoreMidText =>
      profile == ColorProfile.fidelity ? Color(0xFFF97316) : Color(0xFFC2410C);

  /// accessible.selectedIndicator
  Color get selectedIndicator =>
      profile == ColorProfile.fidelity ? Color(0xFF10B981) : Color(0xFF047857);

  /// accessible.successText
  Color get successText =>
      profile == ColorProfile.fidelity ? Color(0xFF10B981) : Color(0xFF047857);

  /// accessible.textOnPrimaryTint
  Color get textOnPrimaryTint =>
      profile == ColorProfile.fidelity ? Color(0xFF3B82F6) : Color(0xFF1D4ED8);

  /// accessible.toggleOff
  Color get toggleOff =>
      profile == ColorProfile.fidelity ? Color(0xFFB9B9BA) : Color(0xFF8E8E93);

  /// accessible.toggleOn
  Color get toggleOn =>
      profile == ColorProfile.fidelity ? Color(0xFF10B981) : Color(0xFF047857);

  /// accessible.warningText
  Color get warningText =>
      profile == ColorProfile.fidelity ? Color(0xFFF97316) : Color(0xFFC2410C);
}

abstract final class AnswerPaletteTokens {
  /// answerPalette.defaults.grammar
  static const String defaultsGrammar = "blue";

  /// answerPalette.defaults.writing
  static const String defaultsWriting = "purple";

  /// answerPalette.order
  static const List<String> order = <String>[
    "purple",
    "blue",
    "indigo",
    "green",
    "lime",
    "ink",
    "white",
  ];
  static const AnswerColors purple = AnswerColors(
    background: Color(0xFFA855F7),
    foreground: Color(0xFF0B0F21),
  );
  static const AnswerColors blue = AnswerColors(
    background: Color(0xFF007AFF),
    foreground: Color(0xFF0B0F21),
  );
  static const AnswerColors indigo = AnswerColors(
    background: Color(0xFF2563EB),
    foreground: Color(0xFFFFFFFF),
  );
  static const AnswerColors green = AnswerColors(
    background: Color(0xFF047857),
    foreground: Color(0xFFFFFFFF),
  );
  static const AnswerColors lime = AnswerColors(
    background: Color(0xFFCDFD1A),
    foreground: Color(0xFF0B0F21),
  );
  static const AnswerColors ink = AnswerColors(
    background: Color(0xFF0B0F21),
    foreground: Color(0xFFFFFFFF),
  );
  static const AnswerColors white = AnswerColors(
    background: Color(0xFFFFFFFF),
    foreground: Color(0xFF0B0F21),
  );
}

abstract final class CefrTokens {
  /// cefr.A1
  static const Color a1 = Color(0xFF2BC25C);

  /// cefr.A2
  static const Color a2 = Color(0xFF7FCA25);

  /// cefr.B1
  static const Color b1 = Color(0xFFE3B425);

  /// cefr.B2
  static const Color b2 = Color(0xFFF27626);

  /// cefr.C1
  static const Color c1 = Color(0xFFE74B46);

  /// cefr.C2
  static const Color c2 = Color(0xFFD4322A);
}

abstract final class ColorTokens {
  /// color.background
  static const Color background = Color(0xFFF9FAFB);

  /// color.backgroundPlain
  static const Color backgroundPlain = Color(0xFFFFFFFF);

  /// color.border
  static const Color border = Color(0xFFE5E7EB);

  /// color.error
  static const Color error = Color(0xFFEF4444);

  /// color.errorText
  static const Color errorText = Color(0xFFDC2626);

  /// color.errorTextOnTint
  static const Color errorTextOnTint = Color(0xFFB91C1C);

  /// color.errorTint
  static const Color errorTint = Color.fromRGBO(239, 68, 68, 0.12);

  /// color.highlight
  static const Color highlight = Color(0xFFFEF9C3);

  /// color.overlayScrim.default
  static const Color overlayScrimDefault = Color.fromRGBO(0, 0, 0, 0.20);

  /// color.overlayScrim.strong
  static const Color overlayScrimStrong = Color.fromRGBO(0, 0, 0, 0.40);

  /// color.primary
  static const Color primary = Color(0xFF3B82F6);

  /// color.primaryStrong
  static const Color primaryStrong = Color(0xFF2563EB);

  /// color.primaryTextOnTint
  static const Color primaryTextOnTint = Color(0xFF1D4ED8);

  /// color.primaryTint
  static const Color primaryTint = Color(0xFFDBEAFE);

  /// color.streakBadgeBackground
  static const Color streakBadgeBackground = Color(0xFFFFF7ED);

  /// color.success
  static const Color success = Color(0xFF10B981);

  /// color.successText
  static const Color successText = Color(0xFF047857);

  /// color.successTint
  static const Color successTint = Color(0xFFDCEEEA);

  /// color.surface
  static const Color surface = Color(0xFFFFFFFF);

  /// color.surfaceElevated
  static const Color surfaceElevated = Color(0xFFFFFFFF);

  /// color.surfaceMuted
  static const Color surfaceMuted = Color(0xFFF3F4F6);

  /// color.textFaint
  static const Color textFaint = Color(0xFF9AA0AB);

  /// color.textMuted
  static const Color textMuted = Color(0xFF676D7A);

  /// color.textOnPrimary
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  /// color.textPrimary
  static const Color textPrimary = Color(0xFF0B0F21);

  /// color.textSecondary
  static const Color textSecondary = Color(0xFF505A6C);

  /// color.warning
  static const Color warning = Color(0xFFF97316);

  /// color.warningText
  static const Color warningText = Color(0xFFC2410C);
}

abstract final class ControlTokens {
  /// control.backButton
  static const double backButton = 33.0;

  /// control.buttonLgHeight
  static const double buttonLgHeight = 42.0;

  /// control.buttonMdHeight
  static const double buttonMdHeight = 38.0;

  /// control.buttonSmHeight
  static const double buttonSmHeight = 30.0;

  /// control.chipHeight
  static const double chipHeight = 30.0;

  /// control.composerHeight
  static const double composerHeight = 31.0;

  /// control.gradeButton
  static const double gradeButton = 49.0;

  /// control.homeDockButton
  static const double homeDockButton = 38.0;

  /// control.homeDockMenuMinWidth
  static const double homeDockMenuMinWidth = 94.0;

  /// control.iconButton
  static const double iconButton = 36.0;

  /// control.learningFlagHeight
  static const double learningFlagHeight = 30.0;

  /// control.learningFlagWidth
  static const double learningFlagWidth = 40.0;

  /// control.minTouchTarget
  static const double minTouchTarget = 44.0;

  /// control.pillSmallHeight
  static const double pillSmallHeight = 24.0;

  /// control.sendButton
  static const double sendButton = 26.0;

  /// control.submitButton
  static const double submitButton = 26.0;
}

abstract final class ControlStateTokens {
  /// control_state.actionFill
  static const Color actionFill = Color(0xFF131A29);

  /// control_state.actionText
  static const Color actionText = Color(0xFFFFFFFF);

  /// control_state.secondaryFill
  static const Color secondaryFill = Color(0xFFF3F4F6);

  /// control_state.sendDisabled
  static const Color sendDisabled = Color(0xFFD2D5DB);

  /// control_state.submitDisabled
  static const Color submitDisabled = Color(0xFF898990);

  /// control_state.submitEnabled
  static const Color submitEnabled = Color(0xFF000318);

  /// control_state.toggleOff
  static const Color toggleOff = Color(0xFFB9B9BA);

  /// control_state.toggleOffStrong
  static const Color toggleOffStrong = Color(0xFF8E8E93);
}

abstract final class FeatureTokens {
  /// feature.conversation.accent
  static const Color conversationAccent = Color(0xFF2563EB);

  /// feature.conversation.cta
  static const Color conversationCta = Color(0xFF2563EB);

  /// feature.conversation.homeCardFill
  static const Color conversationHomeCardFill = Color(0xFF7FD7E7);

  /// feature.conversation.userBubble
  static const Color conversationUserBubble = Color(0xFF2563EB);

  /// feature.flowLetter.glassFill
  static const Color flowLetterGlassFill = Color.fromRGBO(255, 255, 255, 0.20);

  /// feature.flowLetter.glassText
  static const Color flowLetterGlassText = Color(0xFFFFFFFF);

  /// feature.flowLetter.gradient.lobby
  static const List<Color> flowLetterGradientLobby = <Color>[
    Color(0xFFBB438D),
    Color(0xFF68294D),
    Color(0xFF29111F),
  ];

  /// feature.flowLetter.gradient.options
  static const List<Color> flowLetterGradientOptions = <Color>[
    Color(0xFF6326AE),
    Color(0xFF3C1082),
    Color(0xFF000001),
  ];

  /// feature.flowLetter.gradient.round
  static const List<Color> flowLetterGradientRound = <Color>[
    Color(0xFF7EAB49),
    Color(0xFF719B3E),
    Color(0xFF000100),
  ];

  /// feature.flowLetter.gradient.roundDeck
  static const List<Color> flowLetterGradientRoundDeck = <Color>[
    Color(0xFF6326AE),
    Color(0xFF3C1082),
    Color(0xFF000001),
  ];

  /// feature.flowLetter.gradient.settings
  static const List<Color> flowLetterGradientSettings = <Color>[
    Color(0xFF405DB6),
    Color(0xFF213787),
    Color(0xFF000102),
  ];

  /// feature.grammar.accent
  static const Color grammarAccent = Color(0xFFCDFD1A);

  /// feature.grammar.answerCard
  static const Color grammarAnswerCard = Color(0xFF007AFF);

  /// feature.grammar.cta
  static const Color grammarCta = Color(0xFFCDFD1A);

  /// feature.grammar.homeCardFill
  static const Color grammarHomeCardFill = Color(0xFF8D5EF7);

  /// feature.grammar.progress
  static const Color grammarProgress = Color(0xFF10B981);

  /// feature.grammar.progressCurrent
  static const Color grammarProgressCurrent = Color(0xFFDCEEEA);

  /// feature.home.conversationFill
  static const Color homeConversationFill = Color(0xFF0E7490);

  /// feature.home.flashcardGradient
  static const List<Color> homeFlashcardGradient = <Color>[
    Color(0xFF0B0F21),
    Color(0xFF1D4ED8),
    Color(0xFF2563EB),
  ];

  /// feature.home.grammarFill
  static const Color homeGrammarFill = Color(0xFF7C3AED);

  /// feature.home.promptEntryFill
  static const Color homePromptEntryFill = Color(0xFFFFFFFF);

  /// feature.home.writingFill
  static const Color homeWritingFill = Color(0xFF2563EB);

  /// feature.homeDiscovery.flowGradient
  static const List<Color> homeDiscoveryFlowGradient = <Color>[
    Color(0xFF000000),
    Color(0xFF48207E),
    Color(0xFF000000),
  ];

  /// feature.homeDiscovery.mint
  static const Color homeDiscoveryMint = Color(0xFF10B981);

  /// feature.homeDiscovery.orange
  static const Color homeDiscoveryOrange = Color(0xFFFB923C);

  /// feature.homeDiscovery.pink
  static const Color homeDiscoveryPink = Color(0xFFED4BA6);

  /// feature.homeDiscovery.purple
  static const Color homeDiscoveryPurple = Color(0xFF8B5CF6);

  /// feature.homeDiscovery.teal
  static const Color homeDiscoveryTeal = Color(0xFF14B8A6);

  /// feature.learningLanguage.cta
  static const Color learningLanguageCta = Color(0xFF19CCE5);

  /// feature.profile.avatarFill
  static const Color profileAvatarFill = Color(0xFFEEEEF0);

  /// feature.profile.avatarGlyph
  static const Color profileAvatarGlyph = Color(0xFFBFC0C6);

  /// feature.profile.divider
  static const Color profileDivider = Color(0xFFFAFAFB);

  /// feature.profile.groupBorder
  static const Color profileGroupBorder = Color(0xFFF1F2F4);

  /// feature.profile.iconFill
  static const Color profileIconFill = Color(0xFFF8F9FA);

  /// feature.profile.levelFill
  static const Color profileLevelFill = Color(0xFFF0E8FF);

  /// feature.profile.levelText
  static const Color profileLevelText = Color(0xFF7040B5);

  /// feature.profile.promoEnd
  static const Color profilePromoEnd = Color(0xFF087BA4);

  /// feature.scenario.accent
  static const Color scenarioAccent = Color(0xFF3B82F6);

  /// feature.scenario.aiBubble
  static const Color scenarioAiBubble = Color(0xFFF3F4F6);

  /// feature.scenario.progress
  static const Color scenarioProgress = Color(0xFF3B82F6);

  /// feature.scenario.progressCurrent
  static const Color scenarioProgressCurrent = Color(0xFFDBEAFE);

  /// feature.scenario.taskBubble
  static const Color scenarioTaskBubble = Color(0xFF3B82F6);

  /// feature.srs.accent
  static const Color srsAccent = Color(0xFF3B82F6);

  /// feature.srs.cardFill
  static const Color srsCardFill = Color(0xFFFFFFFF);

  /// feature.srs.posBadgeBg
  static const Color srsPosBadgeBg = Color(0xFFDBE9FE);

  /// feature.writing.accent
  static const Color writingAccent = Color(0xFF3B82F6);

  /// feature.writing.answerCard
  static const Color writingAnswerCard = Color(0xFFA855F7);

  /// feature.writing.cta
  static const Color writingCta = Color(0xFF131A29);

  /// feature.writing.homeCardFill
  static const Color writingHomeCardFill = Color(0xFF3B82F6);

  /// feature.writing.progress
  static const Color writingProgress = Color(0xFF10B981);

  /// feature.writing.progressCurrent
  static const Color writingProgressCurrent = Color(0xFFDCEEEA);
}

abstract final class FeedbackTokens {
  /// feedback.bullet.improvement
  static const Color bulletImprovement = Color(0xFFA855F7);

  /// feedback.bullet.mistake
  static const Color bulletMistake = Color(0xFFF97316);

  /// feedback.bullet.tip
  static const Color bulletTip = Color(0xFFCDFD1A);

  /// feedback.correct
  static const Color correct = Color(0xFF10B981);

  /// feedback.diff.addedBg
  static const Color diffAddedBg = Color(0xFFDCEEEA);

  /// feedback.diff.addedText
  static const Color diffAddedText = Color(0xFF10B981);

  /// feedback.diff.removedText
  static const Color diffRemovedText = Color(0xFFEF4444);

  /// feedback.incorrect
  static const Color incorrect = Color(0xFFEF4444);

  /// feedback.partial
  static const Color partial = Color(0xFF3B82F6);
}

abstract final class FocusTokens {
  /// focus.ringOffset
  static const double ringOffset = 2.0;

  /// focus.ringWidth
  static const double ringWidth = 2.0;
}

abstract final class GlassTokens {
  /// glass.bar.blur
  static const double barBlur = 20.0;

  /// glass.bar.fill
  static const Color barFill = Color.fromRGBO(255, 255, 255, 0.70);

  /// glass.button.blur
  static const double buttonBlur = 12.0;

  /// glass.button.fill
  static const Color buttonFill = Color.fromRGBO(255, 255, 255, 0.20);

  /// glass.homeDockButtonBorder
  static const Color homeDockButtonBorder = Color.fromRGBO(255, 255, 255, 0.38);

  /// glass.homeDockButtonFill
  static const Color homeDockButtonFill = Color.fromRGBO(255, 255, 255, 0.58);

  /// glass.homeDockTint
  static const Color homeDockTint = Color.fromRGBO(255, 255, 255, 0.42);

  /// glass.menu.blur
  static const double menuBlur = 20.0;

  /// glass.menu.fill
  static const Color menuFill = Color.fromRGBO(255, 255, 255, 0.55);
}

abstract final class GradeTokens {
  /// grade.again
  static const Color again = Color(0xFFEE3437);

  /// grade.easy
  static const Color easy = Color(0xFF7BC800);

  /// grade.good
  static const Color good = Color(0xFF307CF5);

  /// grade.hard
  static const Color hard = Color(0xFFF59800);
}

abstract final class IconTokens {
  /// icon.container
  static const double container = 36.0;

  /// icon.control
  static const double control = 27.0;

  /// icon.homeDock
  static const double homeDock = 18.0;

  /// icon.homeDockMenu
  static const double homeDockMenu = 16.0;

  /// icon.homeFlowLetter
  static const double homeFlowLetter = 28.0;

  /// icon.inline
  static const double inline = 15.0;

  /// icon.learningLanguageHero
  static const double learningLanguageHero = 48.0;

  /// icon.profileAvatar
  static const double profileAvatar = 40.0;

  /// icon.profilePromo
  static const double profilePromo = 44.0;

  /// icon.profileSetting
  static const double profileSetting = 14.0;

  /// icon.streakHero
  static const double streakHero = 96.0;

  /// icon.tile
  static const double tile = 30.0;
}

abstract final class LayoutTokens {
  /// layout.answerCardMinHeight
  static const double answerCardMinHeight = 224.0;

  /// layout.bannerFeatureHeight
  static const double bannerFeatureHeight = 160.0;

  /// layout.bannerPromoHeight
  static const double bannerPromoHeight = 77.0;

  /// layout.breakpointCompact
  static const double breakpointCompact = 560.0;

  /// layout.breakpointWide
  static const double breakpointWide = 1024.0;

  /// layout.carouselGap
  static const double carouselGap = 12.0;

  /// layout.chatBubbleMaxWidthRatio
  static const double chatBubbleMaxWidthRatio = 0.94;

  /// layout.contentMaxWidth
  static const double contentMaxWidth = 764.0;

  /// layout.contentWidthDashboard
  static const double contentWidthDashboard = 764.0;

  /// layout.deckCardHeight
  static const double deckCardHeight = 98.0;

  /// layout.dialogWidth
  static const double dialogWidth = 260.0;

  /// layout.feedbackCompactAlignmentY
  static const double feedbackCompactAlignmentY = 0.4;

  /// layout.feedbackDetailedAlignmentY
  static const double feedbackDetailedAlignmentY = 1.0;

  /// layout.gridColumns
  static const double gridColumns = 2.0;

  /// layout.gridGap
  static const double gridGap = 8.0;

  /// layout.hideBarCaptionsBelow
  static const double hideBarCaptionsBelow = 360.0;

  /// layout.hintChipBlur
  static const double hintChipBlur = 4.0;

  /// layout.historyCardHeight
  static const double historyCardHeight = 142.0;

  /// layout.historyCardWidth
  static const double historyCardWidth = 123.0;

  /// layout.homeDockControlsBottomInset
  static const double homeDockControlsBottomInset = 2.0;

  /// layout.homeDockFadeHeight
  static const double homeDockFadeHeight = 32.0;

  /// layout.homeDockHeight
  static const double homeDockHeight = 62.0;

  /// layout.homeFlashPreviewHeight
  static const double homeFlashPreviewHeight = 128.0;

  /// layout.homeFlashPreviewWidth
  static const double homeFlashPreviewWidth = 100.0;

  /// layout.homeFlowHeight
  static const double homeFlowHeight = 92.0;

  /// layout.homeGuideArtHeight
  static const double homeGuideArtHeight = 88.0;

  /// layout.homeGuideHeight
  static const double homeGuideHeight = 146.0;

  /// layout.homeGuideWidth
  static const double homeGuideWidth = 123.0;

  /// layout.homeModeCardAspectRatio
  static const double homeModeCardAspectRatio = 1.75;

  /// layout.homeModeMotifSize
  static const double homeModeMotifSize = 160.0;

  /// layout.homeRecommendationFace
  static const double homeRecommendationFace = 30.0;

  /// layout.inlinePopoverOffset
  static const double inlinePopoverOffset = 4.0;

  /// layout.lessonCardMinHeight
  static const double lessonCardMinHeight = 290.0;

  /// layout.lessonCardWidthRatio
  static const double lessonCardWidthRatio = 0.83;

  /// layout.letterTileSize
  static const double letterTileSize = 44.0;

  /// layout.marginDashboard
  static const double marginDashboard = 12.0;

  /// layout.marginScreen
  static const double marginScreen = 18.0;

  /// layout.menuListAlignmentY
  static const double menuListAlignmentY = 0.35;

  /// layout.modeCardMinHeight
  static const double modeCardMinHeight = 370.0;

  /// layout.modeCardWidthRatio
  static const double modeCardWidthRatio = 0.85;

  /// layout.modeCardWidthRatioCompact
  static const double modeCardWidthRatioCompact = 0.9;

  /// layout.navBarHeight
  static const double navBarHeight = 41.0;

  /// layout.popupMenuWidth
  static const double popupMenuWidth = 144.0;

  /// layout.profileAvatar
  static const double profileAvatar = 76.0;

  /// layout.profilePromoHeight
  static const double profilePromoHeight = 68.0;

  /// layout.profilePromoSectionGap
  static const double profilePromoSectionGap = 36.0;

  /// layout.rowMenu
  static const double rowMenu = 54.0;

  /// layout.rowSettings
  static const double rowSettings = 62.0;

  /// layout.rowWord
  static const double rowWord = 87.0;

  /// layout.sheetMaxHeightRatio
  static const double sheetMaxHeightRatio = 0.5;

  /// layout.sheetMaxHeightRatioCompact
  static const double sheetMaxHeightRatioCompact = 0.7;

  /// layout.sheetMaxHeightRatioShort
  static const double sheetMaxHeightRatioShort = 0.9;

  /// layout.sheetWidth
  static const double sheetWidth = 446.0;

  /// layout.srsCardAspect
  static const double srsCardAspect = 0.79;

  /// layout.srsCardWidthRatio
  static const double srsCardWidthRatio = 0.58;

  /// layout.stackActionsBelow
  static const double stackActionsBelow = 280.0;

  /// layout.stepperHeight
  static const double stepperHeight = 6.0;

  /// layout.stepperSegmentMinWidth
  static const double stepperSegmentMinWidth = 4.0;

  /// layout.streakPromptMaxWidth
  static const double streakPromptMaxWidth = 168.0;

  /// layout.topicCardHeight
  static const double topicCardHeight = 123.0;
}

abstract final class MotionTokens {
  /// motion.carouselActiveScale
  static const double carouselActiveScale = 1.04;

  /// motion.easing
  static const Curve easing = Curves.easeOut;

  /// motion.fast
  static const Duration fast = Duration(milliseconds: 150);

  /// motion.feedbackMinimumDwell
  static const Duration feedbackMinimumDwell = Duration(milliseconds: 300);

  /// motion.sheet
  static const Duration sheet = Duration(milliseconds: 220);

  /// motion.sheetEnterOffset
  static const double sheetEnterOffset = 12.0;
}

abstract final class RadiusTokens {
  /// radius.card
  static const double card = 18.0;

  /// radius.chip
  static const double chip = 9999.0;

  /// radius.control
  static const double control = 14.0;

  /// radius.dialog
  static const double dialog = 24.0;

  /// radius.full
  static const double full = 9999.0;

  /// radius.heroCard
  static const double heroCard = 28.0;

  /// radius.largeCard
  static const double largeCard = 24.0;

  /// radius.sheet
  static const double sheet = 20.0;

  /// radius.xs
  static const double xs = 8.0;
}

abstract final class ScoreTokens {
  /// score.high
  static const Color high = Color(0xFF10B981);

  /// score.low
  static const Color low = Color(0xFFEF4444);

  /// score.mid
  static const Color mid = Color(0xFFF97316);
}

abstract final class ShadowTokens {
  /// shadow.floating
  static const List<BoxShadow> floating = <BoxShadow>[
    BoxShadow(
      offset: Offset(0, 10),
      blurRadius: 48,
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.22),
    ),
  ];

  /// shadow.hairline
  static const List<BoxShadow> hairline = <BoxShadow>[
    BoxShadow(
      offset: Offset(0, 0),
      blurRadius: 0,
      spreadRadius: 1,
      color: Color(0xFFE5E7EB),
    ),
  ];

  /// shadow.homeStreak
  static const List<BoxShadow> homeStreak = <BoxShadow>[
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color.fromRGBO(11, 15, 33, 0.10),
    ),
  ];

  /// shadow.none
  static const List<BoxShadow> none = <BoxShadow>[];

  /// shadow.raised
  static const List<BoxShadow> raised = <BoxShadow>[
    BoxShadow(
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: 0,
      color: Color.fromRGBO(0, 0, 0, 0.08),
    ),
  ];
}

abstract final class SpaceTokens {
  /// space.lg
  static const double lg = 16.0;

  /// space.md
  static const double md = 12.0;

  /// space.sm
  static const double sm = 8.0;

  /// space.xl
  static const double xl = 24.0;

  /// space.xs
  static const double xs = 4.0;

  /// space.xxl
  static const double xxl = 32.0;
}

abstract final class StateTokens {
  /// state.disabledOpacity
  static const double disabledOpacity = 0.4;

  /// state.homeCardMotifOpacity
  static const double homeCardMotifOpacity = 0.08;

  /// state.homeInactiveCardBlur
  static const double homeInactiveCardBlur = 1.5;

  /// state.homeInactiveCardOpacity
  static const double homeInactiveCardOpacity = 0.46;

  /// state.homeInactiveCardScale
  static const double homeInactiveCardScale = 0.96;

  /// state.modeCardDividerOpacity
  static const double modeCardDividerOpacity = 0.25;

  /// state.modeCardIndexOpacity
  static const double modeCardIndexOpacity = 0.24;

  /// state.pressedOverlay
  static const Color pressedOverlay = Color.fromRGBO(11, 15, 33, 0.08);
}

abstract final class TypographyTokens {
  /// typography.body
  static const TextStyle body = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.4285714285714286,
    fontWeight: FontWeight.w400,
  );

  /// typography.bodyStrong
  static const TextStyle bodyStrong = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.4285714285714286,
    fontWeight: FontWeight.w600,
  );

  /// typography.caption
  static const TextStyle caption = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.3333333333333333,
    fontWeight: FontWeight.w400,
  );

  /// typography.display
  static const TextStyle display = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 32,
    height: 1.125,
    fontWeight: FontWeight.w800,
  );

  /// typography.displayCompact
  static const TextStyle displayCompact = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 28,
    height: 1.1428571428571428,
    fontWeight: FontWeight.w800,
  );

  /// typography.family
  static const String family = "PlusJakartaSans";

  /// typography.heading
  static const TextStyle heading = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 17,
    height: 1.2941176470588236,
    fontWeight: FontWeight.w700,
  );

  /// typography.homeDockLabel
  static const TextStyle homeDockLabel = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.2857142857142858,
    fontWeight: FontWeight.w600,
  );

  /// typography.homeFeatureCaption
  static const TextStyle homeFeatureCaption = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );

  /// typography.homeGuideTitle
  static const TextStyle homeGuideTitle = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.3333333333333333,
    fontWeight: FontWeight.w600,
  );

  /// typography.homeModeIndex
  static const TextStyle homeModeIndex = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 96,
    height: 1.1458333333333333,
    fontWeight: FontWeight.w800,
  );

  /// typography.homePreviewMeaning
  static const TextStyle homePreviewMeaning = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 9,
    height: 1.3333333333333333,
    fontWeight: FontWeight.w400,
  );

  /// typography.homePreviewWord
  static const TextStyle homePreviewWord = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 10,
    height: 1.4,
    fontWeight: FontWeight.w700,
  );

  /// typography.homeQuickTopic
  static const TextStyle homeQuickTopic = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.3333333333333333,
    fontWeight: FontWeight.w500,
  );

  /// typography.microLabel
  static const TextStyle microLabel = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 10,
    height: 1.2,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.8,
  );
  static const String microLabelTransform = "uppercase";

  /// typography.profileBadge
  static const TextStyle profileBadge = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 10,
    height: 1.4,
    fontWeight: FontWeight.w600,
  );

  /// typography.profileLanguage
  static const TextStyle profileLanguage = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.4285714285714286,
    fontWeight: FontWeight.w600,
  );

  /// typography.profileName
  static const TextStyle profileName = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w700,
  );

  /// typography.profileNav
  static const TextStyle profileNav = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.4285714285714286,
    fontWeight: FontWeight.w600,
  );

  /// typography.profilePromoTitle
  static const TextStyle profilePromoTitle = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.2857142857142858,
    fontWeight: FontWeight.w700,
  );

  /// typography.profileRow
  static const TextStyle profileRow = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );

  /// typography.profileSection
  static const TextStyle profileSection = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.5,
    fontWeight: FontWeight.w500,
  );

  /// typography.streakCount
  static const TextStyle streakCount = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 56,
    height: 1.25,
    fontWeight: FontWeight.w800,
  );

  /// typography.streakDay
  static const TextStyle streakDay = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.3333333333333333,
    fontWeight: FontWeight.w600,
  );

  /// typography.streakMonth
  static const TextStyle streakMonth = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.2857142857142858,
    fontWeight: FontWeight.w800,
  );

  /// typography.streakNavTitle
  static const TextStyle streakNavTitle = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 14,
    height: 1.2857142857142858,
    fontWeight: FontWeight.w600,
  );

  /// typography.streakPrompt
  static const TextStyle streakPrompt = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.3333333333333333,
    fontWeight: FontWeight.w500,
  );

  /// typography.streakStatValue
  static const TextStyle streakStatValue = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 20,
    height: 1.3,
    fontWeight: FontWeight.w800,
  );

  /// typography.streakUnit
  static const TextStyle streakUnit = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 12,
    height: 1.3333333333333333,
    fontWeight: FontWeight.w700,
  );

  /// typography.title
  static const TextStyle title = TextStyle(
    fontFamily: TypographyTokens.family,
    fontSize: 24,
    height: 1.1666666666666667,
    fontWeight: FontWeight.w700,
  );
}
