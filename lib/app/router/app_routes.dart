import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home.dart';
import '../../features/grammar/grammar.dart';
import '../../features/writing/presentation/writing_copy.dart';
import '../../features/writing/writing.dart';
import '../localization/generated/app_localizations.dart';

part 'app_routes.g.dart';

HomeDashboardCopy _homeCopy(BuildContext context) {
  final strings = AppLocalizations.of(context)!;
  return HomeDashboardCopy(
    greeting: strings.homeGreeting,
    caption: strings.homeCaption,
    prompt: strings.homePrompt,
    promptLabel: strings.homePromptLabel,
    learningModes: strings.learningModes,
    writing: strings.writing,
    writingDescription: strings.writingDescription,
    grammar: strings.grammar,
    grammarDescription: strings.grammarDescription,
    conversation: strings.conversation,
    conversationDescription: strings.conversationDescription,
    explore: strings.explore,
    comingSoon: strings.comingSoon,
    streakLabel: strings.streakDays(3),
    history: strings.history,
    menu: strings.menu,
    settings: strings.settings,
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
    start: strings.start,
    sourceText: strings.sourceText,
    answerLabel: strings.answerLabel,
    answerPlaceholder: strings.answerPlaceholder,
    submit: strings.submit,
    grading: strings.grading,
    cancel: strings.cancel,
    correctTitle: strings.correctTitle,
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
  );
}

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HomeDashboardScreen(
        copy: _homeCopy(context),
        onWritingPressed: () => const WritingTopicRoute().push<void>(context),
        onGrammarPressed: () => const GrammarTopicRoute().push<void>(context),
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
        onFinished: () => GrammarLessonRoute(topicId: topicId).go(context),
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
      );
}
