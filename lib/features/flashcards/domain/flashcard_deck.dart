final class FlashcardWord {
  const FlashcardWord({
    required this.term,
    required this.pronunciation,
    required this.translation,
    required this.partOfSpeech,
  });

  final String term;
  final String pronunciation;
  final String translation;
  final String partOfSpeech;
}

final class FlashcardDeck {
  const FlashcardDeck({
    required this.id,
    required this.title,
    required this.description,
    required this.words,
    required this.newCount,
    required this.learningCount,
    required this.dueCount,
  });

  final String id;
  final String title;
  final String description;
  final List<FlashcardWord> words;
  final int newCount;
  final int learningCount;
  final int dueCount;
}

abstract interface class FlashcardRepository {
  List<FlashcardDeck> loadDecks();
  FlashcardDeck? loadDeck(String id);
}
