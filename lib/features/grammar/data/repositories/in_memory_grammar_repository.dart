import '../../domain/entities/grammar_content.dart';
import '../../domain/repositories/grammar_repository.dart';

/// Deterministic development adapter. Production grading remains backend-owned.
final class InMemoryGrammarRepository implements GrammarRepository {
  const InMemoryGrammarRepository();

  static final List<GrammarTopic> _topics = List.unmodifiable([
    GrammarTopic(
      id: 'verb-agreement',
      categoryId: 'foundations',
      title: 'Verb agreement',
      description: 'Build dependable sentences by matching subjects and verbs.',
      level: 'A1',
      lessonCount: 1,
    ),
    GrammarTopic(
      id: 'verb-tenses',
      categoryId: 'verbs',
      title: 'Verb tenses',
      description: 'Place everyday actions clearly in the past and present.',
      level: 'A2',
      lessonCount: 1,
    ),
  ]);

  static final List<GrammarLesson> _lessons = List.unmodifiable([
    GrammarLesson(
      id: 'third-person-present',
      topicId: 'verb-agreement',
      level: 'A1',
      title: 'Third-person present',
      description: 'Correct common agreement mistakes in everyday sentences.',
      illustrationKey: 'agreement-orbit',
      exercises: [
        GrammarSentenceExercise(
          id: 'agreement-1',
          incorrectSentence: 'She work at the library every day.',
          acceptedAnswers: [
            'She works at the library every day.',
            'She works at the library each day.',
          ],
          hints: ['Look at the subject.', 'Check the present-tense verb.'],
          explanation: 'Use works with the third-person singular subject she.',
          tips: ['Add -s to most present-tense verbs after he, she, or it.'],
        ),
        GrammarSentenceExercise(
          id: 'agreement-2',
          incorrectSentence: 'My brother play football on Sundays.',
          acceptedAnswers: ['My brother plays football on Sundays.'],
          hints: ['My brother is singular.', 'Check the verb ending.'],
          explanation: 'A singular third-person subject takes plays.',
          tips: ['Use the base verb with I, you, we, and they.'],
        ),
        _exercise(
          'agreement-3',
          'The dog chase birds in the park.',
          'The dog chases birds in the park.',
          'A singular subject takes chases.',
          'The dog is singular.',
        ),
        _exercise(
          'agreement-4',
          'He wash his bike on Saturdays.',
          'He washes his bike on Saturdays.',
          'Add -es to wash after he.',
          'Verbs ending in -sh take -es.',
        ),
        _exercise(
          'agreement-5',
          'Mina study English after dinner.',
          'Mina studies English after dinner.',
          'Change study to studies after a singular name.',
          'A consonant before y changes the ending.',
        ),
        _exercise(
          'agreement-6',
          'Our teacher explain the rule clearly.',
          'Our teacher explains the rule clearly.',
          'Teacher is singular, so use explains.',
          'Identify the head noun of the subject.',
        ),
        _exercise(
          'agreement-7',
          'This train stop at every station.',
          'This train stops at every station.',
          'This train takes the singular verb stops.',
          'This points to one train.',
        ),
        _exercise(
          'agreement-8',
          'Her friend carry a small notebook.',
          'Her friend carries a small notebook.',
          'Carry becomes carries with a singular subject.',
          'Check the -y ending.',
        ),
        _exercise(
          'agreement-9',
          'The baby cry before bedtime.',
          'The baby cries before bedtime.',
          'Baby is singular, so cry becomes cries.',
          'Replace consonant-y with -ies.',
        ),
        _exercise(
          'agreement-10',
          'My phone need a new battery.',
          'My phone needs a new battery.',
          'Phone is singular, so use needs.',
          'Add -s to the present-tense verb.',
        ),
        _exercise(
          'agreement-11',
          'Sam enjoy quiet mornings.',
          'Sam enjoys quiet mornings.',
          'A singular name takes enjoys.',
          'Match the verb to Sam.',
        ),
        _exercise(
          'agreement-12',
          'The café close at nine.',
          'The café closes at nine.',
          'The singular subject café takes closes.',
          'Verbs ending in -se add -s.',
        ),
        _exercise(
          'agreement-13',
          'My sister teach music online.',
          'My sister teaches music online.',
          'Teach becomes teaches after a singular subject.',
          'Verbs ending in -ch take -es.',
        ),
        _exercise(
          'agreement-14',
          'A good map help travelers.',
          'A good map helps travelers.',
          'Map is singular, so use helps.',
          'The subject is map, not travelers.',
        ),
        _exercise(
          'agreement-15',
          'His jacket look very warm.',
          'His jacket looks very warm.',
          'Jacket takes the singular verb looks.',
          'Add -s after it.',
        ),
        _exercise(
          'agreement-16',
          'Every student bring a pencil.',
          'Every student brings a pencil.',
          'Every student is grammatically singular.',
          'Every takes a singular verb.',
        ),
        _exercise(
          'agreement-17',
          'The river flow through the city.',
          'The river flows through the city.',
          'River is singular, so use flows.',
          'Match flow to one river.',
        ),
        _exercise(
          'agreement-18',
          'Nora go to work by bus.',
          'Nora goes to work by bus.',
          'Go becomes goes after a singular name.',
          'Go takes -es in third-person singular.',
        ),
        _exercise(
          'agreement-19',
          'That machine make a soft sound.',
          'That machine makes a soft sound.',
          'That machine takes makes.',
          'That refers to one machine.',
        ),
        _exercise(
          'agreement-20',
          'The final lesson finish at noon.',
          'The final lesson finishes at noon.',
          'Finish becomes finishes after a singular subject.',
          'Verbs ending in -sh take -es.',
        ),
      ],
    ),
    GrammarLesson(
      id: 'simple-past',
      topicId: 'verb-tenses',
      level: 'A2',
      title: 'Simple past',
      description: 'Repair past-tense sentences with clear time markers.',
      illustrationKey: 'past-path',
      exercises: [
        GrammarSentenceExercise(
          id: 'past-1',
          incorrectSentence: 'Yesterday I walk to the market.',
          acceptedAnswers: ['Yesterday I walked to the market.'],
          hints: ['Yesterday signals the past.'],
          explanation: 'Use walked for a completed past action.',
          tips: ['Regular past-tense verbs commonly end in -ed.'],
        ),
        GrammarSentenceExercise(
          id: 'past-2',
          incorrectSentence: 'They goes home early last night.',
          acceptedAnswers: ['They went home early last night.'],
          hints: ['Go is irregular in the past.'],
          explanation: 'The past form of go is went.',
          tips: ['Learn common irregular past-tense forms as authored pairs.'],
        ),
      ],
    ),
  ]);

  @override
  List<String> get categoryIds => const ['all', 'foundations', 'verbs'];

  @override
  List<GrammarTopic> get topics => _topics;

  @override
  List<GrammarLesson> lessonsForTopic(String topicId) =>
      List.unmodifiable(_lessons.where((lesson) => lesson.topicId == topicId));

  @override
  GrammarTopic? topicById(String topicId) =>
      _firstOrNull(_topics.where((topic) => topic.id == topicId));

  @override
  GrammarLesson? lessonById(String lessonId) =>
      _firstOrNull(_lessons.where((lesson) => lesson.id == lessonId));

  @override
  GrammarSentenceExercise? exerciseById(String lessonId, String exerciseId) {
    final lesson = lessonById(lessonId);
    if (lesson == null) return null;
    return _firstOrNull(
      lesson.exercises.where((exercise) => exercise.id == exerciseId),
    );
  }

  @override
  Future<GrammarVerdict> grade({
    required GrammarSentenceExercise exercise,
    required String response,
  }) async {
    final correct = exercise.acceptedAnswers.any(
      (answer) => _normalize(answer) == _normalize(response),
    );
    return GrammarVerdict(
      kind: correct ? GrammarVerdictKind.correct : GrammarVerdictKind.incorrect,
      originalResponse: response,
      correctedAnswer: exercise.acceptedAnswers.first,
      explanation: exercise.explanation,
      tips: exercise.tips,
    );
  }

  String _normalize(String value) =>
      value.trim().toLowerCase().replaceAll(RegExp(r'\s+'), ' ');

  T? _firstOrNull<T>(Iterable<T> values) {
    final iterator = values.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}

GrammarSentenceExercise _exercise(
  String id,
  String incorrectSentence,
  String acceptedAnswer,
  String explanation,
  String hint,
) => GrammarSentenceExercise(
  id: id,
  incorrectSentence: incorrectSentence,
  acceptedAnswers: [acceptedAnswer],
  hints: [hint],
  explanation: explanation,
  tips: const [
    'Match a singular third-person subject with its present-tense verb.',
  ],
);
