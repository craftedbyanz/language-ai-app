import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/tokens/generated/design_tokens.dart';
import '../../data/repositories/in_memory_grammar_repository.dart';
import '../../domain/entities/grammar_content.dart';
import '../../domain/repositories/grammar_repository.dart';
import '../state/grammar_exercise_state.dart';
import '../view_models/grammar_exercise_view_model.dart';

final grammarRepositoryProvider = Provider<GrammarRepository>(
  (ref) => const InMemoryGrammarRepository(),
);

final grammarMinimumDwellProvider = Provider<Duration>(
  (ref) => MotionTokens.feedbackMinimumDwell,
);

final grammarTopicsProvider = Provider<List<GrammarTopic>>(
  (ref) => ref.watch(grammarRepositoryProvider).topics,
);

final grammarLessonsProvider = Provider.family<List<GrammarLesson>, String>(
  (ref, topicId) =>
      ref.watch(grammarRepositoryProvider).lessonsForTopic(topicId),
);

final class GrammarWorkflowArgs {
  const GrammarWorkflowArgs({required this.topicId, required this.lessonId});
  final String topicId;
  final String lessonId;

  @override
  bool operator ==(Object other) =>
      other is GrammarWorkflowArgs &&
      topicId == other.topicId &&
      lessonId == other.lessonId;

  @override
  int get hashCode => Object.hash(topicId, lessonId);
}

final grammarExerciseViewModelProvider = NotifierProvider.autoDispose
    .family<
      GrammarExerciseViewModel,
      GrammarExerciseState,
      GrammarWorkflowArgs
    >(GrammarExerciseViewModel.new);
