import 'package:flutter/material.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import '../../data/repositories/in_memory_writing_repository.dart';
import '../../domain/entities/writing_content.dart';
import '../writing_copy.dart';

class WritingTopicPickerScreen extends StatefulWidget {
  const WritingTopicPickerScreen({
    required this.copy,
    required this.onBack,
    required this.onTopicPressed,
    super.key,
  });
  final WritingCopy copy;
  final VoidCallback onBack;
  final ValueChanged<String> onTopicPressed;

  @override
  State<WritingTopicPickerScreen> createState() =>
      _WritingTopicPickerScreenState();
}

class _WritingTopicPickerScreenState extends State<WritingTopicPickerScreen> {
  static const _repository = InMemoryWritingRepository();
  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    final topics = _category == 'All'
        ? _repository.topics
        : _repository.topics
              .where((topic) => topic.category == _category)
              .toList();
    return AppScaffold(
      child: AdaptiveLayout(
        builder: (context, sizeClass) => Column(
          children: [
            ContentConstraints(
              child: AppHeader(
                variant: AppHeaderVariant.pushed,
                title: widget.copy.writing,
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
                        SectionHeader(
                          eyebrow: widget.copy.topicsEyebrow,
                          firstLine: widget.copy.topicsFirstLine,
                          secondLine: widget.copy.topicsSecondLine,
                          sizeClass: sizeClass,
                        ),
                        const SizedBox(height: SpaceTokens.xl),
                        Semantics(
                          container: true,
                          label: widget.copy.topicsEyebrow,
                          child: SizedBox(
                            height: ControlTokens.minTouchTarget,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: _repository.categories.length,
                              separatorBuilder: (_, _) =>
                                  const SizedBox(width: SpaceTokens.sm),
                              itemBuilder: (context, index) {
                                final category = _repository.categories[index];
                                return CategoryChip(
                                  label: category,
                                  selected: category == _category,
                                  onSelected: () =>
                                      setState(() => _category = category),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: SpaceTokens.lg),
                        _TopicGrid(
                          topics: topics,
                          columns: sizeClass == WindowSizeClass.compact ? 1 : 2,
                          countLabel: widget.copy.setCount,
                          onPressed: widget.onTopicPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
  final List<WritingTopic> topics;
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
      mainAxisExtent: LayoutTokens.topicCardHeight,
      crossAxisSpacing: LayoutTokens.gridGap,
      mainAxisSpacing: LayoutTokens.gridGap,
    ),
    itemBuilder: (context, index) {
      final topic = topics[index];
      return TopicCard(
        icon: Icons.edit_note_rounded,
        title: topic.title,
        countLabel: '${topic.setCount} $countLabel',
        onPressed: () => onPressed(topic.id),
      );
    },
  );
}
