import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../../features/home/home.dart';
import '../../features/insights/insights.dart';
import '../../features/settings/settings.dart';
import '../../features/flashcards/flashcards.dart';
import '../../features/grammar/grammar.dart';
import '../../features/writing/presentation/writing_copy.dart';
import '../../features/writing/writing.dart';
import '../localization/generated/app_localizations.dart';

part 'app_routes.g.dart';

HomeDashboardCopy _homeCopy(BuildContext context, int streakCount) {
  final strings = AppLocalizations.of(context)!;
  return HomeDashboardCopy(
    greeting: strings.homeGreeting,
    caption: strings.homeCaption,
    prompt: strings.homePrompt,
    promptLabel: strings.homePromptLabel,
    learningModes: strings.learningModes,
    modePager: strings.modePager,
    modePagerPosition: strings.modePagerPosition,
    writing: strings.writing,
    writingDescription: strings.writingDescription,
    grammar: strings.grammar,
    grammarDescription: strings.grammarDescription,
    conversation: strings.conversation,
    conversationDescription: strings.conversationDescription,
    explore: strings.explore,
    comingSoon: strings.comingSoon,
    streakLabel: strings.streakDays(streakCount),
    history: strings.history,
    menu: strings.menu,
    settings: strings.settingsProfile,
    flashcardTitle: strings.flashcards,
    flashcardCaption: strings.flashcardHomeCaption,
    flashcardAction: strings.flashcardExplore,
    flowLetterTitle: strings.insightWordGame,
    flowLetterCaption: strings.comingSoon,
  );
}

InsightCopy _insightCopy(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  return InsightCopy(
    title: strings.insightTitle,
    history: strings.history,
    streak: strings.insightStreak,
    streakOnFire: strings.streakOnFire,
    streakConsecutiveDays: strings.streakConsecutiveDays,
    streakStartPrompt: strings.streakStartPrompt,
    streakStudiedDays: strings.streakStudiedDays,
    streakPreviousMonth: strings.streakPreviousMonth,
    streakNextMonth: strings.streakNextMonth,
    back: strings.back,
    lessons: strings.insightLessons,
    writing: strings.writing,
    grammar: strings.grammar,
    conversations: strings.conversation,
    words: strings.insightWords,
    reviews: strings.insightReviews,
    currentStreak: strings.insightCurrentStreak,
    longestStreak: strings.insightLongestStreak,
    monthYear: strings.insightMonthYear,
    weekTitle: strings.insightWeekTitle,
    weekEmpty: strings.insightWeekEmpty,
    weekdayLabels: [
      strings.weekdayMon,
      strings.weekdayTue,
      strings.weekdayWed,
      strings.weekdayThu,
      strings.weekdayFri,
      strings.weekdaySat,
      strings.weekdaySun,
    ],
    historySearch: strings.insightSearch,
    historySearchHint: strings.insightSearchHint,
    historyEmptyTitle: strings.insightHistoryEmptyTitle,
    historyEmptyBody: strings.insightHistoryEmptyBody,
    historyNoResults: strings.insightHistoryNoResults,
    historySectionWriting: strings.historySectionWriting,
    historyReviewTitle: strings.historyReviewTitle,
    historySectionGrammar: strings.historySectionGrammar,
    historySectionConversation: strings.historySectionConversation,
    historySeeMore: strings.historySeeMore,
  );
}

CompletionCopy _completionCopy(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  return CompletionCopy(
    title: strings.completionTitle,
    steps: strings.completionSteps,
    corrections: strings.completionCorrections,
    nextLesson: strings.completionNextLesson,
    done: strings.completionDone,
  );
}

void _showHomeMenu(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  void openRoute(BuildContext dialogContext, GoRouteData route) {
    Navigator.of(dialogContext).pop();
    unawaited(route.push<void>(context));
  }

  unawaited(
    showDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      barrierLabel: strings.menu,
      builder: (dialogContext) => MenuOverlay(
        title: strings.menu,
        closeLabel: strings.menuClose,
        onClose: () => Navigator.of(dialogContext).pop(),
        shortcuts: [
          MenuShortcut(
            label: strings.insightTitle,
            icon: Icons.insights_outlined,
            iconFill: ColorTokens.primary,
            onPressed: () => openRoute(dialogContext, const InsightRoute()),
          ),
          MenuShortcut(
            label: strings.menuUpgrade,
            icon: Icons.workspace_premium_rounded,
            iconFill: ColorTokens.warning,
          ),
          MenuShortcut(
            label: strings.flashcards,
            icon: Icons.style_outlined,
            iconFill: FeatureTokens.writingHomeCardFill,
            onPressed: () =>
                openRoute(dialogContext, const FlashcardDecksRoute()),
          ),
          MenuShortcut(
            label: strings.insightStreak,
            icon: Icons.local_fire_department_outlined,
            iconFill: ColorTokens.warning,
            onPressed: () => openRoute(dialogContext, const StreakRoute()),
          ),
          MenuShortcut(
            label: strings.insightWordGame,
            icon: Icons.extension_outlined,
            iconFill: ColorTokens.success,
          ),
        ],
      ),
    ),
  );
}

FlashcardCopy _flashcardCopy(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  return FlashcardCopy(
    title: strings.flashcards,
    back: strings.back,
    deckCount: strings.flashcardDeckCount,
    newLabel: strings.flashcardNew,
    learningLabel: strings.flashcardLearning,
    dueLabel: strings.flashcardDue,
    deckSummary: strings.flashcardDeckSummary,
    reviewLabel: strings.flashcardReview,
    wordsLabel: strings.flashcardWords,
    gameLabel: strings.flashcardGame,
    emptyTitle: strings.flashcardEmptyTitle,
    emptyBody: strings.flashcardEmptyBody,
    unavailableTitle: strings.flashcardUnavailableTitle,
    unavailableBody: strings.flashcardUnavailableBody,
  );
}

SettingsCopy _settingsCopy(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  return SettingsCopy(
    title: strings.settings,
    profile: strings.settingsProfile,
    free: strings.settingsFree,
    upgradeTitle: strings.settingsUpgradeTitle,
    upgradeCaption: strings.settingsUpgradeCaption,
    upgradeAction: strings.settingsUpgradeAction,
    studying: strings.settingsStudying,
    editProfile: strings.settingsEditProfile,
    notifications: strings.settingsNotifications,
    subscription: strings.settingsSubscription,
    redeem: strings.settingsRedeem,
    invite: strings.settingsInvite,
    rate: strings.settingsRate,
    other: strings.settingsOther,
    feedback: strings.settingsFeedback,
    terms: strings.settingsTerms,
    privacy: strings.settingsPrivacy,
    logout: strings.settingsLogout,
    back: strings.back,
    guest: strings.settingsGuest,
    guestCaption: strings.settingsGuestCaption,
    general: strings.settingsGeneral,
    learning: strings.settingsLearning,
    language: strings.settingsLanguage,
    appLanguage: strings.settingsAppLanguage,
    learningLanguage: strings.settingsLearningLanguage,
    level: strings.settingsLevel,
    lesson: strings.settingsLesson,
    appearance: strings.settingsAppearance,
    voice: strings.settingsVoice,
    comingSoon: strings.comingSoon,
    languageCaption: strings.settingsLanguageCaption,
    english: strings.settingsEnglish,
    vietnamese: strings.settingsVietnamese,
    apply: strings.settingsApply,
    saveFailed: strings.settingsSaveFailed,
    version: strings.settingsVersion,
    footerCaption: strings.settingsFooterCaption,
  );
}

WritingCopy _writingCopy(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  return WritingCopy(
    writing: strings.writing,
    back: strings.back,
    close: strings.close,
    more: strings.more,
    topicsEyebrow: strings.topicsEyebrow,
    topicsFirstLine: strings.topicsFirstLine,
    topicsSecondLine: strings.topicsSecondLine,
    setCount: strings.setCount,
    lessonsEyebrow: strings.lessonsEyebrow,
    lessonsFirstLine: strings.lessonsFirstLine,
    lessonsSecondLine: strings.lessonsSecondLine,
    emptyLessonsTitle: strings.writingEmptyLessonsTitle,
    emptyLessonsBody: strings.writingEmptyLessonsBody,
    lessonPager: strings.lessonPager,
    lessonPagerPosition: strings.lessonPagerPosition,
    start: strings.start,
    sourceText: strings.sourceText,
    answerLabel: strings.answerLabel,
    answerPlaceholder: strings.answerPlaceholder,
    submit: strings.submit,
    grading: strings.grading,
    cancel: strings.cancel,
    correctTitle: strings.correctTitle,
    recapTitle: strings.writingRecapTitle,
    yourAnswer: strings.writingYourAnswer,
    viewAnalysis: strings.writingViewAnalysis,
    incorrectTitle: strings.incorrectTitle,
    correction: strings.correction,
    improvements: strings.improvements,
    edit: strings.edit,
    next: strings.next,
    stepOf: strings.stepOf,
    hint: strings.hint,
    leaveExercise: strings.leaveExercise,
    leaveBody: strings.leaveBody,
    stay: strings.stay,
    leave: strings.leave,
  );
}

GrammarCopy _grammarCopy(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  return GrammarCopy(
    grammar: strings.grammar,
    back: strings.back,
    close: strings.close,
    topicsEyebrow: strings.grammarTopicsEyebrow,
    topicsFirstLine: strings.grammarTopicsFirstLine,
    topicsSecondLine: strings.grammarTopicsSecondLine,
    allCategory: strings.grammarCategoryAll,
    foundationsCategory: strings.grammarCategoryFoundations,
    verbsCategory: strings.grammarCategoryVerbs,
    lessonCount: strings.grammarLessonCount,
    lessonsEyebrow: strings.grammarLessonsEyebrow,
    lessonsFirstLine: strings.grammarLessonsFirstLine,
    lessonsSecondLine: strings.grammarLessonsSecondLine,
    start: strings.grammarStart,
    instruction: strings.grammarInstruction,
    sourceSentence: strings.grammarSourceSentence,
    answerLabel: strings.grammarAnswerLabel,
    answerPlaceholder: strings.grammarAnswerPlaceholder,
    submit: strings.grammarSubmit,
    grading: strings.grammarGrading,
    cancel: strings.grammarCancel,
    retry: strings.grammarRetry,
    correctTitle: strings.grammarCorrectTitle,
    incorrectTitle: strings.grammarIncorrectTitle,
    correction: strings.grammarCorrection,
    tips: strings.grammarTips,
    fix: strings.grammarFix,
    next: strings.grammarNext,
    stepOf: strings.grammarStepOf,
    hint: strings.grammarHint,
    showFeedback: strings.grammarShowFeedback,
    yourAnswer: strings.grammarYourAnswer,
    viewAnalysis: strings.grammarViewAnalysis,
    analysisUnavailable: strings.grammarAnalysisUnavailable,
    emptyTopicsTitle: strings.grammarEmptyTopicsTitle,
    emptyTopicsBody: strings.grammarEmptyTopicsBody,
    emptyLessonsTitle: strings.grammarEmptyLessonsTitle,
    emptyLessonsBody: strings.grammarEmptyLessonsBody,
    unavailableTitle: strings.grammarUnavailableTitle,
    unavailableBody: strings.grammarUnavailableBody,
    errorTitle: strings.grammarErrorTitle,
    errorBody: strings.grammarErrorBody,
    pager: strings.grammarPager,
    pagerPosition: strings.grammarPagerPosition,
    minimizeFeedback: strings.grammarMinimizeFeedback,
    topicsSection: strings.grammarTopicsSection,
    visibleTopics: strings.grammarVisibleTopics,
    collectionLabel: strings.grammarCollectionLabel,
    correctionRetained: strings.grammarCorrectionRetained,
    correctionRemoved: strings.grammarCorrectionRemoved,
    correctionInserted: strings.grammarCorrectionInserted,
  );
}

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => Consumer(
    builder: (context, ref, _) {
      final streakCount = ref.watch(insightSnapshotProvider).currentStreak;
      return HomeDashboardScreen(
        copy: _homeCopy(context, streakCount),
        streakCount: streakCount,
        onWritingPressed: () => const WritingTopicRoute().push<void>(context),
        onGrammarPressed: () => const GrammarTopicRoute().push<void>(context),
        onFlashcardsPressed: () =>
            const FlashcardDecksRoute().push<void>(context),
        onSettingsPressed: () => const SettingsRoute().push<void>(context),
        onHistoryPressed: () => const HistoryRoute().push<void>(context),
        onStreakPressed: () => const StreakRoute().push<void>(context),
        onMenuPressed: () => _showHomeMenu(context),
      );
    },
  );
}

@TypedGoRoute<InsightRoute>(path: '/insights')
class InsightRoute extends GoRouteData with $InsightRoute {
  const InsightRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      InsightOverviewScreen(
        copy: _insightCopy(context),
        onBack: () => context.pop(),
      );
}

@TypedGoRoute<HistoryRoute>(path: '/history')
class HistoryRoute extends GoRouteData with $HistoryRoute {
  const HistoryRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => HistoryScreen(
    copy: _insightCopy(context),
    onBack: () => context.pop(),
    onEntryPressed: (entry) => switch (entry.mode) {
      HistoryMode.writing => WritingLessonRoute(
        topicId: entry.topicId,
      ).push<void>(context),
      HistoryMode.grammar => GrammarLessonRoute(
        topicId: entry.topicId,
      ).push<void>(context),
    },
  );
}

@TypedGoRoute<StreakRoute>(path: '/streak')
class StreakRoute extends GoRouteData with $StreakRoute {
  const StreakRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      StreakScreen(copy: _insightCopy(context), onBack: () => context.pop());
}

@TypedGoRoute<SettingsRoute>(path: '/settings')
class SettingsRoute extends GoRouteData with $SettingsRoute {
  const SettingsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    final copy = _settingsCopy(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    return SettingsListScreen(
      copy: copy,
      currentLanguage: languageCode == 'vi' ? copy.vietnamese : copy.english,
      onBack: () => context.pop(),
      onLanguagePressed: () =>
          const SettingsLanguageRoute().push<void>(context),
    );
  }
}

@TypedGoRoute<SettingsLanguageRoute>(path: '/settings/language')
class SettingsLanguageRoute extends GoRouteData with $SettingsLanguageRoute {
  const SettingsLanguageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      SettingsLanguageScreen(
        copy: _settingsCopy(context),
        onBack: () => context.pop(),
      );
}

@TypedGoRoute<FlashcardDecksRoute>(path: '/flashcards')
class FlashcardDecksRoute extends GoRouteData with $FlashcardDecksRoute {
  const FlashcardDecksRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FlashcardDeckListScreen(
        copy: _flashcardCopy(context),
        onBack: () => context.pop(),
        onDeckPressed: (deckId) =>
            FlashcardDeckRoute(deckId: deckId).push<void>(context),
      );
}

@TypedGoRoute<FlashcardDeckRoute>(path: '/flashcards/:deckId')
class FlashcardDeckRoute extends GoRouteData with $FlashcardDeckRoute {
  const FlashcardDeckRoute({required this.deckId});

  final String deckId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      FlashcardDeckDetailScreen(
        deckId: deckId,
        copy: _flashcardCopy(context),
        onBack: () => context.pop(),
      );
}

@TypedGoRoute<GrammarTopicRoute>(path: '/grammar')
class GrammarTopicRoute extends GoRouteData with $GrammarTopicRoute {
  const GrammarTopicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GrammarTopicPickerScreen(
        copy: _grammarCopy(context),
        onBack: () => const HomeRoute().go(context),
        onTopicPressed: (topicId) =>
            GrammarLessonRoute(topicId: topicId).push<void>(context),
      );
}

@TypedGoRoute<GrammarLessonRoute>(path: '/grammar/:topicId')
class GrammarLessonRoute extends GoRouteData with $GrammarLessonRoute {
  const GrammarLessonRoute({required this.topicId});

  final String topicId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GrammarLessonListScreen(
        topicId: topicId,
        copy: _grammarCopy(context),
        onBack: () => const GrammarTopicRoute().go(context),
        onLessonPressed: (lessonId) => GrammarExerciseRoute(
          topicId: topicId,
          lessonId: lessonId,
        ).push<void>(context),
      );
}

@TypedGoRoute<GrammarExerciseRoute>(path: '/grammar/:topicId/:lessonId')
class GrammarExerciseRoute extends GoRouteData with $GrammarExerciseRoute {
  const GrammarExerciseRoute({required this.topicId, required this.lessonId});

  final String topicId;
  final String lessonId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      GrammarExerciseScreen(
        topicId: topicId,
        lessonId: lessonId,
        copy: _grammarCopy(context),
        onBack: () => GrammarLessonRoute(topicId: topicId).go(context),
        completionCopy: _completionCopy(context),
        onDone: () => GrammarLessonRoute(topicId: topicId).go(context),
        onNextLesson: (nextLessonId) => GrammarExerciseRoute(
          topicId: topicId,
          lessonId: nextLessonId,
        ).go(context),
      );
}

@TypedGoRoute<WritingTopicRoute>(path: '/writing')
class WritingTopicRoute extends GoRouteData with $WritingTopicRoute {
  const WritingTopicRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WritingTopicPickerScreen(
        copy: _writingCopy(context),
        onBack: () => context.pop(),
        onTopicPressed: (topicId) =>
            WritingLessonRoute(topicId: topicId).push<void>(context),
      );
}

@TypedGoRoute<WritingLessonRoute>(path: '/writing/:topicId')
class WritingLessonRoute extends GoRouteData with $WritingLessonRoute {
  const WritingLessonRoute({required this.topicId});

  final String topicId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WritingLessonListScreen(
        topicId: topicId,
        copy: _writingCopy(context),
        onBack: () => context.pop(),
        onLessonPressed: (lessonId) => WritingExerciseRoute(
          topicId: topicId,
          lessonId: lessonId,
        ).push<void>(context),
      );
}

@TypedGoRoute<WritingExerciseRoute>(path: '/writing/:topicId/:lessonId')
class WritingExerciseRoute extends GoRouteData with $WritingExerciseRoute {
  const WritingExerciseRoute({required this.topicId, required this.lessonId});

  final String topicId;
  final String lessonId;

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      WritingExerciseScreen(
        lessonId: lessonId,
        copy: _writingCopy(context),
        onClose: () => context.pop(),
        completionCopy: _completionCopy(context),
        onDone: () => WritingLessonRoute(topicId: topicId).go(context),
        onNextLesson: (nextLessonId) => WritingExerciseRoute(
          topicId: topicId,
          lessonId: nextLessonId,
        ).go(context),
      );
}
