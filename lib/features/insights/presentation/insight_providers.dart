import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/in_memory_insight_repository.dart';
import '../domain/insight_snapshot.dart';

final insightRepositoryProvider = Provider<InsightRepository>(
  (ref) => const InMemoryInsightRepository(),
);

final insightSnapshotProvider = Provider<InsightSnapshot>(
  (ref) => ref.watch(insightRepositoryProvider).load(),
);
