// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $homeRoute,
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
