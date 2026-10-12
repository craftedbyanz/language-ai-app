import '../domain/flashcard_deck.dart';

/// Authored development content. Review scheduling stays server-owned.
final class InMemoryFlashcardRepository implements FlashcardRepository {
  const InMemoryFlashcardRepository();

  static const _decks = <FlashcardDeck>[
    FlashcardDeck(
      id: 'daily-life',
      title: 'Daily life',
      description: 'Words for everyday routines and small conversations.',
      newCount: 0,
      learningCount: 0,
      dueCount: 0,
      words: [
        FlashcardWord(
          term: 'routine',
          pronunciation: '/ruːˈtiːn/',
          translation: 'thói quen',
          partOfSpeech: 'noun',
        ),
        FlashcardWord(
          term: 'prepare',
          pronunciation: '/prɪˈpeə/',
          translation: 'chuẩn bị',
          partOfSpeech: 'verb',
        ),
        FlashcardWord(
          term: 'nearby',
          pronunciation: '/ˌnɪəˈbaɪ/',
          translation: 'gần đây',
          partOfSpeech: 'adverb',
        ),
      ],
    ),
    FlashcardDeck(
      id: 'travel',
      title: 'Travel essentials',
      description: 'Useful language for getting around.',
      newCount: 0,
      learningCount: 0,
      dueCount: 0,
      words: [
        FlashcardWord(
          term: 'departure',
          pronunciation: '/dɪˈpɑːtʃə/',
          translation: 'sự khởi hành',
          partOfSpeech: 'noun',
        ),
        FlashcardWord(
          term: 'luggage',
          pronunciation: '/ˈlʌɡɪdʒ/',
          translation: 'hành lý',
          partOfSpeech: 'noun',
        ),
      ],
    ),
  ];

  @override
  List<FlashcardDeck> loadDecks() => _decks;

  @override
  FlashcardDeck? loadDeck(String id) {
    for (final deck in _decks) {
      if (deck.id == id) return deck;
    }
    return null;
  }
}
