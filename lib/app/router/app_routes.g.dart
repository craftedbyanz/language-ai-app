// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $homeRoute,
  $insightRoute,
  $flashcardReviewRoute,
  $historyRoute,
  $streakRoute,
  $settingsRoute,
  $settingsLanguageRoute,
  $settingsPreferenceRoute,
  $flashcardDecksRoute,
  $flashcardDeckRoute,
  $grammarTopicRoute,
  $grammarLessonRoute,
  $grammarExerciseRoute,
  $writingTopicRoute,
  $writingLessonRoute,
  $writingExerciseRoute,
];

RouteBase get $homeRoute => GoRouteData.$route(
  path: '/',
  hasOverriddenOnExit: false,
  factory: $HomeRoute._fromState,
);

mixin $HomeRoute on GoRouteData {
  static HomeRoute _fromState(GoRouterState state) => const HomeRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $insightRoute => GoRouteData.$route(
  path: '/insights',
  hasOverriddenOnExit: false,
  factory: $InsightRoute._fromState,
);

mixin $InsightRoute on GoRouteData {
  static InsightRoute _fromState(GoRouterState state) => const InsightRoute();

  @override
  String get location => GoRouteData.$location('/insights');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $flashcardReviewRoute => GoRouteData.$route(
  path: '/flashcards/:deckId/review',
  hasOverriddenOnExit: false,
  factory: $FlashcardReviewRoute._fromState,
);

mixin $FlashcardReviewRoute on GoRouteData {
  static FlashcardReviewRoute _fromState(GoRouterState state) =>
      FlashcardReviewRoute(deckId: state.pathParameters['deckId']!);

  FlashcardReviewRoute get _self => this as FlashcardReviewRoute;

  @override
  String get location => GoRouteData.$location(
    '/flashcards/${Uri.encodeComponent(_self.deckId)}/review',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $historyRoute => GoRouteData.$route(
  path: '/history',
  hasOverriddenOnExit: false,
  factory: $HistoryRoute._fromState,
);

mixin $HistoryRoute on GoRouteData {
  static HistoryRoute _fromState(GoRouterState state) => const HistoryRoute();

  @override
  String get location => GoRouteData.$location('/history');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $streakRoute => GoRouteData.$route(
  path: '/streak',
  hasOverriddenOnExit: false,
  factory: $StreakRoute._fromState,
);

mixin $StreakRoute on GoRouteData {
  static StreakRoute _fromState(GoRouterState state) => const StreakRoute();

  @override
  String get location => GoRouteData.$location('/streak');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsRoute => GoRouteData.$route(
  path: '/settings',
  hasOverriddenOnExit: false,
  factory: $SettingsRoute._fromState,
);

mixin $SettingsRoute on GoRouteData {
  static SettingsRoute _fromState(GoRouterState state) => const SettingsRoute();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsLanguageRoute => GoRouteData.$route(
  path: '/settings/language',
  hasOverriddenOnExit: false,
  factory: $SettingsLanguageRoute._fromState,
);

mixin $SettingsLanguageRoute on GoRouteData {
  static SettingsLanguageRoute _fromState(GoRouterState state) =>
      const SettingsLanguageRoute();

  @override
  String get location => GoRouteData.$location('/settings/language');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsPreferenceRoute => GoRouteData.$route(
  path: '/settings/:section',
  hasOverriddenOnExit: false,
  factory: $SettingsPreferenceRoute._fromState,
);

mixin $SettingsPreferenceRoute on GoRouteData {
  static SettingsPreferenceRoute _fromState(GoRouterState state) =>
      SettingsPreferenceRoute(section: state.pathParameters['section']!);

  SettingsPreferenceRoute get _self => this as SettingsPreferenceRoute;

  @override
  String get location =>
      GoRouteData.$location('/settings/${Uri.encodeComponent(_self.section)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $flashcardDecksRoute => GoRouteData.$route(
  path: '/flashcards',
  hasOverriddenOnExit: false,
  factory: $FlashcardDecksRoute._fromState,
);

mixin $FlashcardDecksRoute on GoRouteData {
  static FlashcardDecksRoute _fromState(GoRouterState state) =>
      const FlashcardDecksRoute();

  @override
  String get location => GoRouteData.$location('/flashcards');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $flashcardDeckRoute => GoRouteData.$route(
  path: '/flashcards/:deckId',
  hasOverriddenOnExit: false,
  factory: $FlashcardDeckRoute._fromState,
);

mixin $FlashcardDeckRoute on GoRouteData {
  static FlashcardDeckRoute _fromState(GoRouterState state) =>
      FlashcardDeckRoute(deckId: state.pathParameters['deckId']!);

  FlashcardDeckRoute get _self => this as FlashcardDeckRoute;

  @override
  String get location =>
      GoRouteData.$location('/flashcards/${Uri.encodeComponent(_self.deckId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $grammarTopicRoute => GoRouteData.$route(
  path: '/grammar',
  hasOverriddenOnExit: false,
  factory: $GrammarTopicRoute._fromState,
);

mixin $GrammarTopicRoute on GoRouteData {
  static GrammarTopicRoute _fromState(GoRouterState state) =>
      const GrammarTopicRoute();

  @override
  String get location => GoRouteData.$location('/grammar');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $grammarLessonRoute => GoRouteData.$route(
  path: '/grammar/:topicId',
  hasOverriddenOnExit: false,
  factory: $GrammarLessonRoute._fromState,
);

mixin $GrammarLessonRoute on GoRouteData {
  static GrammarLessonRoute _fromState(GoRouterState state) =>
      GrammarLessonRoute(topicId: state.pathParameters['topicId']!);

  GrammarLessonRoute get _self => this as GrammarLessonRoute;

  @override
  String get location =>
      GoRouteData.$location('/grammar/${Uri.encodeComponent(_self.topicId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $grammarExerciseRoute => GoRouteData.$route(
  path: '/grammar/:topicId/:lessonId',
  hasOverriddenOnExit: false,
  factory: $GrammarExerciseRoute._fromState,
);

mixin $GrammarExerciseRoute on GoRouteData {
  static GrammarExerciseRoute _fromState(GoRouterState state) =>
      GrammarExerciseRoute(
        topicId: state.pathParameters['topicId']!,
        lessonId: state.pathParameters['lessonId']!,
      );

  GrammarExerciseRoute get _self => this as GrammarExerciseRoute;

  @override
  String get location => GoRouteData.$location(
    '/grammar/${Uri.encodeComponent(_self.topicId)}/${Uri.encodeComponent(_self.lessonId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $writingTopicRoute => GoRouteData.$route(
  path: '/writing',
  hasOverriddenOnExit: false,
  factory: $WritingTopicRoute._fromState,
);

mixin $WritingTopicRoute on GoRouteData {
  static WritingTopicRoute _fromState(GoRouterState state) =>
      const WritingTopicRoute();

  @override
  String get location => GoRouteData.$location('/writing');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $writingLessonRoute => GoRouteData.$route(
  path: '/writing/:topicId',
  hasOverriddenOnExit: false,
  factory: $WritingLessonRoute._fromState,
);

mixin $WritingLessonRoute on GoRouteData {
  static WritingLessonRoute _fromState(GoRouterState state) =>
      WritingLessonRoute(topicId: state.pathParameters['topicId']!);

  WritingLessonRoute get _self => this as WritingLessonRoute;

  @override
  String get location =>
      GoRouteData.$location('/writing/${Uri.encodeComponent(_self.topicId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $writingExerciseRoute => GoRouteData.$route(
  path: '/writing/:topicId/:lessonId',
  hasOverriddenOnExit: false,
  factory: $WritingExerciseRoute._fromState,
);

mixin $WritingExerciseRoute on GoRouteData {
  static WritingExerciseRoute _fromState(GoRouterState state) =>
      WritingExerciseRoute(
        topicId: state.pathParameters['topicId']!,
        lessonId: state.pathParameters['lessonId']!,
      );

  WritingExerciseRoute get _self => this as WritingExerciseRoute;

  @override
  String get location => GoRouteData.$location(
    '/writing/${Uri.encodeComponent(_self.topicId)}/${Uri.encodeComponent(_self.lessonId)}',
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
