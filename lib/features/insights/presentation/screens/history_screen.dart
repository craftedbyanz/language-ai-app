import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../insight_copy.dart';
import '../insight_providers.dart';
import '../../domain/insight_snapshot.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({
    required this.copy,
    required this.onBack,
    required this.onEntryPressed,
    super.key,
  });

  final InsightCopy copy;
  final VoidCallback onBack;
  final ValueChanged<HistoryEntry> onEntryPressed;

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _searchController = TextEditingController();
  var _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final history = ref.watch(insightSnapshotProvider).history;
    final visible = history
        .where(
          (entry) => entry.topic.toLowerCase().contains(_query.toLowerCase()),
        )
        .toList(growable: false);
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              centre: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: LayoutTokens.dialogWidth,
                  ),
                  child: SearchField(
                    label: widget.copy.historySearch,
                    hint: widget.copy.historySearchHint,
                    controller: _searchController,
                    onChanged: (value) => setState(() => _query = value),
                  ),
                ),
              ),
              leadingLabel: widget.copy.back,
              onLeadingPressed: widget.onBack,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContentConstraints(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: SpaceTokens.xl),
                      if (visible.isEmpty)
                        EmptyState(
                          title: _query.isEmpty
                              ? widget.copy.historyEmptyTitle
                              : widget.copy.historyNoResults,
                          body: widget.copy.historyEmptyBody,
                        )
                      else
                        Wrap(
                          spacing: SpaceTokens.sm,
                          runSpacing: SpaceTokens.sm,
                          children: [
                            for (final entry in visible)
                              InsightHistoryCard(
                                type: entry.type,
                                topic: entry.topic,
                                icon: Icons.history_edu_outlined,
                                onPressed: () => widget.onEntryPressed(entry),
                              ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
