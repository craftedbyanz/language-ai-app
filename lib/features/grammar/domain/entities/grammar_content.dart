enum GrammarVerdictKind { correct, incorrect }

final class GrammarTopic {
  GrammarTopic({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.lessonCount,
  }) {
    _requireNonBlank(id, 'id');
    _requireNonBlank(categoryId, 'categoryId');
    _requireNonBlank(title, 'title');
    if (lessonCount < 0) {
      throw ArgumentError.value(
        lessonCount,
        'lessonCount',
        'must be non-negative',
      );
    }
  }
  final String id;
  final String categoryId;
  final String title;
  final int lessonCount;
}

final class GrammarSentenceExercise {
  GrammarSentenceExercise({
    required this.id,
    required this.incorrectSentence,
    required List<String> acceptedAnswers,
    required List<String> hints,
    required this.explanation,
    required List<String> tips,
  }) : acceptedAnswers = _immutableNonBlank(
         acceptedAnswers,
         'acceptedAnswers',
         requireNonEmpty: true,
       ),
       hints = _immutableNonBlank(hints, 'hints'),
       tips = _immutableNonBlank(tips, 'tips') {
    _requireNonBlank(id, 'id');
    _requireNonBlank(incorrectSentence, 'incorrectSentence');
    _requireNonBlank(explanation, 'explanation');
  }
  final String id;
  final String incorrectSentence;
  final List<String> acceptedAnswers;
  final List<String> hints;
  final String explanation;
  final List<String> tips;
}

final class GrammarLesson {
  GrammarLesson({
    required this.id,
    required this.topicId,
    required this.level,
    required this.title,
    required this.description,
    required List<GrammarSentenceExercise> exercises,
  }) : exercises = List<GrammarSentenceExercise>.unmodifiable(exercises) {
    _requireNonBlank(id, 'id');
    _requireNonBlank(topicId, 'topicId');
    _requireNonBlank(level, 'level');
    _requireNonBlank(title, 'title');
    _requireNonBlank(description, 'description');
    if (exercises.isEmpty) {
      throw ArgumentError.value(exercises, 'exercises', 'must not be empty');
    }
  }
  final String id;
  final String topicId;
  final String level;
  final String title;
  final String description;
  final List<GrammarSentenceExercise> exercises;
}

final class LearnerResponse {
  const LearnerResponse(this.value);
  final String value;
  bool get canSubmit => value.trim().isNotEmpty;
}

final class GrammarVerdict {
  GrammarVerdict({
    required this.kind,
    required this.originalResponse,
    required this.correctedAnswer,
    required this.explanation,
    required List<String> tips,
  }) : tips = _immutableNonBlank(tips, 'tips');
  final GrammarVerdictKind kind;
  final String originalResponse;
  final String correctedAnswer;
  final String explanation;
  final List<String> tips;
}

void _requireNonBlank(String value, String name) {
  if (value.trim().isEmpty) {
    throw ArgumentError.value(value, name, 'must not be blank');
  }
}

List<String> _immutableNonBlank(
  List<String> values,
  String name, {
  bool requireNonEmpty = false,
}) {
  if (requireNonEmpty && values.isEmpty) {
    throw ArgumentError.value(values, name, 'must not be empty');
  }
  if (values.any((value) => value.trim().isEmpty)) {
    throw ArgumentError.value(values, name, 'must not contain blank values');
  }
  return List<String>.unmodifiable(values);
}
