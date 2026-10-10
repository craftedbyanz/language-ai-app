import '../../domain/entities/writing_content.dart';
import '../../domain/repositories/writing_repository.dart';

/// Deterministic development data. Production grading remains backend-owned.
final class InMemoryWritingRepository implements WritingRepository {
  const InMemoryWritingRepository({this.gradingDelay = Duration.zero});

  final Duration gradingDelay;

  static const _topics = <WritingTopic>[
    WritingTopic(
      id: 'daily-life',
      category: 'Everyday',
      title: 'Daily life',
      setCount: 2,
    ),
    WritingTopic(
      id: 'travel',
      category: 'Travel',
      title: 'Travel stories',
      setCount: 2,
    ),
    WritingTopic(id: 'work', category: 'Work', title: 'At work', setCount: 1),
    WritingTopic(
      id: 'culture',
      category: 'Culture',
      title: 'Food & culture',
      setCount: 1,
    ),
  ];

  static const _lessons = <WritingLesson>[
    WritingLesson(
      id: 'morning-routine',
      topicId: 'daily-life',
      level: 'A1',
      title: 'Morning routine',
      description: 'Translate short sentences about everyday habits.',
      exercises: [
        WritingExercise(
          id: 'routine-1',
          sourceText: 'Tôi luyện tiếng Anh mỗi buổi sáng.',
          expectedAnswer: 'I practice English every morning.',
          hints: ['I practice', 'every morning'],
          explanation: 'Use the simple present for a repeated daily habit.',
        ),
        WritingExercise(
          id: 'routine-2',
          sourceText: 'Sau đó, tôi uống một tách trà.',
          expectedAnswer: 'Then I drink a cup of tea.',
          hints: ['Then', 'a cup of tea'],
          explanation: 'Then links this action to the previous routine.',
        ),
        WritingExercise(
          id: 'routine-3',
          sourceText: 'Tôi đi bộ đến chỗ làm.',
          expectedAnswer: 'I walk to work.',
          hints: ['walk', 'to work'],
          explanation: 'Use walk to work for the usual means of travel.',
        ),
      ],
    ),
    WritingLesson(
      id: 'weekend-plans',
      topicId: 'daily-life',
      level: 'A2',
      title: 'Weekend plans',
      description: 'Write clearly about plans and simple intentions.',
      exercises: [
        WritingExercise(
          id: 'weekend-1',
          sourceText: 'Cuối tuần này tôi sẽ thăm gia đình.',
          expectedAnswer: 'I will visit my family this weekend.',
          hints: ['will visit', 'this weekend'],
          explanation: 'Will can express a future intention here.',
        ),
      ],
    ),
  ];

  @override
  List<String> get categories => const [
    'All',
    'Everyday',
    'Travel',
    'Work',
    'Culture',
  ];

  @override
  List<WritingTopic> get topics => _topics;

  @override
  List<WritingLesson> lessonsForTopic(String topicId) => _lessons
      .where((lesson) => lesson.topicId == topicId)
      .toList(growable: false);

  @override
  WritingLesson lessonById(String lessonId) => _lessons.firstWhere(
    (lesson) => lesson.id == lessonId,
    orElse: () => _lessons.first,
  );

  @override
  Future<WritingGrade> grade({
    required WritingExercise exercise,
    required String answer,
  }) async {
    if (gradingDelay > Duration.zero) await Future<void>.delayed(gradingDelay);
    final correct = _normalize(answer) == _normalize(exercise.expectedAnswer);
    return WritingGrade(
      isCorrect: correct,
      correctedAnswer: exercise.expectedAnswer,
      explanation: exercise.explanation,
      improvements: correct
          ? const ['Natural word order', 'Clear, complete sentence']
          : const ['Check the verb form', 'Keep the time phrase together'],
    );
  }

  String _normalize(String value) =>
      value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');
}
