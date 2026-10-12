import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result/result.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import '../../domain/entities/grammar_content.dart';
import '../../domain/repositories/grammar_repository.dart';
import '../grammar_copy.dart';
import '../providers/grammar_providers.dart';

class GrammarTopicPickerScreen extends ConsumerStatefulWidget {
  const GrammarTopicPickerScreen({
    required this.copy,
    required this.onBack,
    required this.onTopicPressed,
    super.key,
  });

  final GrammarCopy copy;
  final VoidCallback onBack;
  final ValueChanged<String> onTopicPressed;

  @override
  ConsumerState<GrammarTopicPickerScreen> createState() =>
      _GrammarTopicPickerScreenState();
}

class _GrammarTopicPickerScreenState
    extends ConsumerState<GrammarTopicPickerScreen> {
  String _categoryId = 'all';

  String _categoryLabel(String id) => switch (id) {
    'all' => widget.copy.allCategory,
    'foundations' => widget.copy.foundationsCategory,
    'verbs' => widget.copy.verbsCategory,
    _ => id,
  };

  @override
  Widget build(BuildContext context) => AppScaffold(
    child: AdaptiveLayout(
      builder: (context, sizeClass) => Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: widget.copy.grammar,
              leadingLabel: widget.copy.back,
              onLeadingPressed: widget.onBack,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ContentConstraints(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: SpaceTokens.xxl),
                  child: _buildContent(context, sizeClass),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildContent(BuildContext context, WindowSizeClass sizeClass) {
    final repository = ref.watch(grammarRepositoryProvider);
    final categoriesResult = repository.loadCategoryIds();
    final topicsResult = repository.loadTopics();
    if (categoriesResult case Success<List<String>>(:final value)) {
      final categoryIds = value;
      if (topicsResult case Success<List<GrammarTopic>>(:final value)) {
        final topics = value;
        final visibleTopics = _categoryId == 'all'
            ? topics
            : topics
                  .where((topic) => topic.categoryId == _categoryId)
                  .toList(growable: false);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              eyebrow: widget.copy.topicsEyebrow,
              firstLine: widget.copy.topicsFirstLine,
              secondLine: widget.copy.topicsSecondLine,
              sizeClass: sizeClass,
              accent: SectionHeaderAccent.grammar,
            ),
            const SizedBox(height: SpaceTokens.xl),
            SizedBox(
              height: ControlTokens.minTouchTarget,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categoryIds.length,
                separatorBuilder: (_, _) =>
                    const SizedBox(width: SpaceTokens.sm),
                itemBuilder: (context, index) {
                  final id = categoryIds[index];
                  return CategoryChip(
                    label: _categoryLabel(id),
                    selected: id == _categoryId,
                    onSelected: () => setState(() => _categoryId = id),
                  );
                },
              ),
            ),
            const SizedBox(height: SpaceTokens.lg),
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.copy.topicsSection,
                    style: TypographyTokens.heading,
                  ),
                ),
                Text(
                  widget.copy.visibleTopics(visibleTopics.length),
                  style: TypographyTokens.caption.copyWith(
                    color: ColorTokens.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: SpaceTokens.md),
            if (visibleTopics.isEmpty)
              EmptyState(
                title: widget.copy.emptyTopicsTitle,
                body: widget.copy.emptyTopicsBody,
              )
            else
              _TopicGrid(
                topics: visibleTopics,
                columns: sizeClass == WindowSizeClass.compact ? 1 : 2,
                countLabel: widget.copy.lessonCount,
                onPressed: widget.onTopicPressed,
              ),
          ],
        );
      }
    }
    return EmptyState(
      title: widget.copy.errorTitle,
      body: widget.copy.errorBody,
      actionLabel: widget.copy.retry,
      onAction: () => setState(() {}),
      error: true,
    );
  }
}

class _TopicGrid extends StatelessWidget {
  const _TopicGrid({
    required this.topics,
    required this.columns,
    required this.countLabel,
    required this.onPressed,
  });

  final List<GrammarTopic> topics;
  final int columns;
  final String countLabel;
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) => GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: topics.length,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: columns,
      mainAxisExtent:
          LayoutTokens.topicCardHeight *
          MediaQuery.textScalerOf(context).scale(1),
      crossAxisSpacing: LayoutTokens.gridGap,
      mainAxisSpacing: LayoutTokens.gridGap,
    ),
    itemBuilder: (context, index) {
      final topic = topics[index];
      return TopicCard(
        icon: switch (topic.id) {
          'verb-agreement' => Icons.balance_rounded,
          'verb-tenses' => Icons.schedule_rounded,
          _ => Icons.rule_rounded,
        },
        title: topic.title,
        countLabel: '${topic.lessonCount} $countLabel',
        onPressed: () => onPressed(topic.id),
      );
    },
  );
}
