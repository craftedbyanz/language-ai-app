import '../entities/writing_content.dart';

abstract interface class WritingRepository {
  List<String> get categories;
  List<WritingTopic> get topics;
  List<WritingLesson> lessonsForTopic(String topicId);
  WritingLesson lessonById(String lessonId);
  Future<WritingGrade> grade({
    required WritingExercise exercise,
    required String answer,
  });
}
