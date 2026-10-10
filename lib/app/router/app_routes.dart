import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home.dart';
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

@TypedGoRoute<HomeRoute>(path: '/')
class HomeRoute extends GoRouteData with $HomeRoute {
  const HomeRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      HomeDashboardScreen(
        copy: _homeCopy(context),
        onWritingPressed: () => const WritingTopicRoute().push<void>(context),
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
