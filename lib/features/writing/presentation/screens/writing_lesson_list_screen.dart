import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import '../writing_copy.dart';
import '../view_models/writing_exercise_view_model.dart';

class WritingLessonListScreen extends ConsumerStatefulWidget {
  const WritingLessonListScreen({
    required this.topicId,
    required this.copy,
    required this.onBack,
    required this.onLessonPressed,
    super.key,
  });
  final String topicId;
  final WritingCopy copy;
  final VoidCallback onBack;
  final ValueChanged<String> onLessonPressed;

  @override
  ConsumerState<WritingLessonListScreen> createState() =>
      _WritingLessonListScreenState();
}

class _WritingLessonListScreenState
    extends ConsumerState<WritingLessonListScreen> {
  final _controller = ScrollController();
  var _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectPage(int page, double width, double ratio) {
    _controller.animateTo(
      page * (width * ratio + LayoutTokens.carouselGap),
      duration: MotionTokens.sheet,
      curve: Curves.easeOut,
    );
    setState(() => _page = page);
  }

  @override
  Widget build(BuildContext context) {
    final repository = ref.watch(writingRepositoryProvider);
    final lessons = repository.lessonsForTopic(widget.topicId);
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        eyebrow: widget.copy.lessonsEyebrow,
                        firstLine: widget.copy.lessonsFirstLine,
                        secondLine: widget.copy.lessonsSecondLine,
                        sizeClass: sizeClass,
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      if (lessons.isEmpty)
                        EmptyState(
                          title: widget.copy.emptyLessonsTitle,
                          body: widget.copy.emptyLessonsBody,
                        )
                      else
                        SizedBox(
                          height: LayoutTokens.lessonCardMinHeight,
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              final ratio = sizeClass == WindowSizeClass.compact
                                  ? LayoutTokens.modeCardWidthRatioCompact
                                  : LayoutTokens.lessonCardWidthRatio;
                              final pageExtent =
                                  constraints.maxWidth * ratio +
                                  LayoutTokens.carouselGap;
                              return NotificationListener<
                                ScrollUpdateNotification
                              >(
                                onNotification: (notification) {
                                  final page =
                                      (notification.metrics.pixels / pageExtent)
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
                                  separatorBuilder: (_, _) => const SizedBox(
                                    width: LayoutTokens.carouselGap,
                                  ),
                                  itemBuilder: (context, index) {
                                    final lesson = lessons[index];
                                    return SizedBox(
                                      width: constraints.maxWidth * ratio,
                                      child: LessonCard(
                                        variant: LessonCardVariant.writing,
                                        indexLabel: (index + 1)
                                            .toString()
                                            .padLeft(2, '0'),
                                        level: lesson.level,
                                        title: lesson.title,
                                        description: lesson.description,
                                        actionLabel: widget.copy.start,
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
                              semanticLabel: widget.copy.lessonPager,
                              positionLabel: widget.copy.lessonPagerPosition,
                              onSelected: (page) => _selectPage(
                                page,
                                constraints.maxWidth,
                                ratio,
                              ),
                            );
                          },
                        ),
                      ],
                      const SizedBox(height: SpaceTokens.xxl),
                    ],
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
