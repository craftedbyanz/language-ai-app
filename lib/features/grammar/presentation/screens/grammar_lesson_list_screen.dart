import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result/result.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import '../../domain/entities/grammar_content.dart';
import '../../domain/repositories/grammar_repository.dart';
import '../grammar_copy.dart';
import '../providers/grammar_providers.dart';

class GrammarLessonListScreen extends ConsumerStatefulWidget {
  const GrammarLessonListScreen({
    required this.topicId,
    required this.copy,
    required this.onBack,
    required this.onLessonPressed,
    super.key,
  });

  final String topicId;
  final GrammarCopy copy;
  final VoidCallback onBack;
  final ValueChanged<String> onLessonPressed;

  @override
  ConsumerState<GrammarLessonListScreen> createState() =>
      _GrammarLessonListScreenState();
}

class _GrammarLessonListScreenState
    extends ConsumerState<GrammarLessonListScreen> {
  final _controller = ScrollController();
  final _headingFocus = FocusNode();
  var _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    _headingFocus.dispose();
    super.dispose();
  }

  void _selectPage(int page, double viewportWidth, double ratio) {
    _controller.animateTo(
      page * (viewportWidth * ratio + LayoutTokens.carouselGap),
      duration: MotionTokens.sheet,
      curve: Curves.easeOut,
    );
    setState(() => _page = page);
  }

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
                child: _buildContent(context, sizeClass),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildContent(BuildContext context, WindowSizeClass sizeClass) {
    final repository = ref.watch(grammarRepositoryProvider);
    final topicResult = repository.loadTopicById(widget.topicId);
    if (topicResult case Success<GrammarTopic?>(value: final topic)) {
      if (topic == null) {
        return EmptyState(
          title: widget.copy.unavailableTitle,
          body: widget.copy.unavailableBody,
        );
      }
      final lessonsResult = repository.loadLessonsForTopic(widget.topicId);
      if (lessonsResult case Success<List<GrammarLesson>>(
        value: final lessons,
      )) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CollectionHeader(
              label: widget.copy.collectionLabel,
              title: topic.title,
              description: topic.description,
              level: topic.level,
              focusNode: _headingFocus,
              autofocus: true,
            ),
            const SizedBox(height: SpaceTokens.xl),
            if (lessons.isEmpty)
              EmptyState(
                title: widget.copy.emptyLessonsTitle,
                body: widget.copy.emptyLessonsBody,
              )
            else
              SizedBox(
                height:
                    (LayoutTokens.lessonCardMinHeight +
                        ControlTokens.minTouchTarget +
                        ControlTokens.minTouchTarget) *
                    MediaQuery.textScalerOf(context).scale(1),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final ratio = sizeClass == WindowSizeClass.compact
                        ? LayoutTokens.modeCardWidthRatioCompact
                        : LayoutTokens.lessonCardWidthRatio;
                    final pageExtent =
                        constraints.maxWidth * ratio + LayoutTokens.carouselGap;
                    return NotificationListener<ScrollUpdateNotification>(
                      onNotification: (notification) {
                        final page = (notification.metrics.pixels / pageExtent)
                            .round()
                            .clamp(0, lessons.length - 1);
                        if (page != _page) {
                          setState(() => _page = page);
                        }
                        return false;
                      },
                      child: ListView.separated(
                        controller: _controller,
                        scrollDirection: Axis.horizontal,
                        itemCount: lessons.length,
                        separatorBuilder: (_, _) =>
                            const SizedBox(width: LayoutTokens.carouselGap),
                        itemBuilder: (context, index) {
                          final lesson = lessons[index];
                          return SizedBox(
                            width: constraints.maxWidth * ratio,
                            child: LessonCard(
                              variant: LessonCardVariant.grammar,
                              indexLabel: (index + 1).toString().padLeft(
                                2,
                                '0',
                              ),
                              level: lesson.level,
                              title: lesson.title,
                              description: lesson.description,
                              actionLabel: widget.copy.start,
                              illustration: _LessonIllustration(
                                keyName: lesson.illustrationKey,
                              ),
                              onPressed: () =>
                                  widget.onLessonPressed(lesson.id),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            if (lessons.isNotEmpty) ...[
              const SizedBox(height: SpaceTokens.md),
              LayoutBuilder(
                builder: (context, constraints) {
                  final ratio = sizeClass == WindowSizeClass.compact
                      ? LayoutTokens.modeCardWidthRatioCompact
                      : LayoutTokens.lessonCardWidthRatio;
                  return PagerDots(
                    count: lessons.length,
                    index: _page.clamp(0, lessons.length - 1),
                    semanticLabel: widget.copy.pager,
                    positionLabel: widget.copy.pagerPosition,
                    onSelected: (page) =>
                        _selectPage(page, constraints.maxWidth, ratio),
                  );
                },
              ),
            ],
            const SizedBox(height: SpaceTokens.xxl),
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

class _LessonIllustration extends StatelessWidget {
  const _LessonIllustration({required this.keyName});

  final String? keyName;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(SpaceTokens.xl),
    decoration: const BoxDecoration(
      color: ColorTokens.surfaceMuted,
      shape: BoxShape.circle,
    ),
    child: Icon(
      switch (keyName) {
        'past-path' => Icons.timeline_rounded,
        'agreement-pairs' => Icons.people_alt_rounded,
        _ => Icons.hub_rounded,
      },
      size: IconTokens.tile,
      color: FeatureTokens.grammarAccent,
    ),
  );
}
