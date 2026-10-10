final class WritingTopic {
  const WritingTopic({
    required this.id,
    required this.category,
    required this.title,
    required this.setCount,
  });

  final String id;
  final String category;
  final String title;
  final int setCount;
}

final class WritingExercise {
  const WritingExercise({
    required this.id,
    required this.sourceText,
    required this.expectedAnswer,
    required this.hints,
    required this.explanation,
  });

  final String id;
  final String sourceText;
  final String expectedAnswer;
  final List<String> hints;
  final String explanation;
}

final class WritingLesson {
  const WritingLesson({
    required this.id,
    required this.topicId,
    required this.level,
    required this.title,
    required this.description,
    required this.exercises,
  });

  final String id;
  final String topicId;
  final String level;
  final String title;
  final String description;
  final List<WritingExercise> exercises;
}

final class WritingGrade {
  const WritingGrade({
    required this.isCorrect,
    required this.correctedAnswer,
    required this.explanation,
    required this.improvements,
  });

  final bool isCorrect;
  final String correctedAnswer;
  final String explanation;
  final List<String> improvements;
}
