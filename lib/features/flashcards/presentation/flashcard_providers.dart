import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/in_memory_flashcard_repository.dart';
import '../domain/flashcard_deck.dart';

final flashcardRepositoryProvider = Provider<FlashcardRepository>(
  (ref) => const InMemoryFlashcardRepository(),
);

final flashcardDecksProvider = Provider<List<FlashcardDeck>>(
  (ref) => ref.watch(flashcardRepositoryProvider).loadDecks(),
);

final flashcardDeckProvider = Provider.family<FlashcardDeck?, String>(
  (ref, id) => ref.watch(flashcardRepositoryProvider).loadDeck(id),
);
