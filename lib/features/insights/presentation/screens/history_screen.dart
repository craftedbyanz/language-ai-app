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
            child: LayoutBuilder(
              builder: (context, constraints) {
                final compact =
                    constraints.maxWidth < LayoutTokens.breakpointCompact;
                return Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          key: const Key('app-header-leading'),
                          tooltip: widget.copy.back,
                          onPressed: widget.onBack,
                          icon: const Icon(
                            Icons.chevron_left_rounded,
                            size: IconTokens.control,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.copy.historyReviewTitle,
                            textAlign: TextAlign.center,
                            style: TypographyTokens.heading,
                          ),
                        ),
                        if (!compact)
                          SizedBox(
                            width: LayoutTokens.dialogWidth,
                            child: _searchField(),
                          ),
                        if (compact)
                          const SizedBox(width: ControlTokens.minTouchTarget),
                      ],
                    ),
                    if (compact) _searchField(),
                  ],
                );
              },
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
                      const SizedBox(height: SpaceTokens.lg),
                      if (visible.isEmpty)
                        EmptyState(
                          title: _query.isEmpty
                              ? widget.copy.historyEmptyTitle
                              : widget.copy.historyNoResults,
                          body: widget.copy.historyEmptyBody,
                        )
                      else ...[
                        _historySection(
                          widget.copy.historySectionWriting,
                          visible
                              .where(
                                (entry) => entry.mode == HistoryMode.writing,
                              )
                              .toList(),
                        ),
                        const SizedBox(height: SpaceTokens.xl),
                        _historySection(
                          widget.copy.historySectionGrammar,
                          visible
                              .where(
                                (entry) => entry.mode == HistoryMode.grammar,
                              )
                              .toList(),
                        ),
                        const SizedBox(height: SpaceTokens.xl),
                        _historySection(
                          widget.copy.historySectionConversation,
                          const [],
                        ),
                      ],
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

  Widget _searchField() => SearchField(
    label: widget.copy.historySearch,
    hint: widget.copy.historySearchHint,
    controller: _searchController,
    onChanged: (value) => setState(() => _query = value),
  );

  Widget _historySection(String title, List<HistoryEntry> entries) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(child: Text(title, style: TypographyTokens.heading)),
          if (entries.isNotEmpty)
            Text(
              widget.copy.historySeeMore,
              style: TypographyTokens.caption.copyWith(
                color: ColorTokens.textMuted,
              ),
            ),
        ],
      ),
      const SizedBox(height: SpaceTokens.sm),
      SizedBox(
        height: LayoutTokens.historyCardHeight + SpaceTokens.xxl,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: entries.length,
          separatorBuilder: (context, index) =>
              const SizedBox(width: SpaceTokens.md),
          itemBuilder: (context, index) {
            final entry = entries[index];
            return InsightHistoryCard(
              type: entry.type,
              topic: entry.topic,
              icon: Icons.history_edu_outlined,
              onPressed: () => widget.onEntryPressed(entry),
            );
          },
        ),
      ),
    ],
  );
}
