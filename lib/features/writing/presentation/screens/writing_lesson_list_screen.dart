import 'package:flutter/material.dart';

import '../../../../design_system/adaptive/adaptive_layout.dart';
import '../../../../design_system/adaptive/content_constraints.dart';
import '../../../../design_system/adaptive/window_size_class.dart';
import '../../../../design_system/components/app_header.dart';
import '../../../../design_system/components/browse_components.dart';
import '../../../../design_system/primitives/app_scaffold.dart';
import '../../../../design_system/tokens/generated/design_tokens.dart';
import '../../data/repositories/in_memory_writing_repository.dart';
import '../writing_copy.dart';

class WritingLessonListScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    const repository = InMemoryWritingRepository();
    final lessons = repository.lessonsForTopic(topicId);
    return AppScaffold(
      child: AdaptiveLayout(
        builder: (context, sizeClass) => Column(
          children: [
            ContentConstraints(
              child: AppHeader(
                variant: AppHeaderVariant.pushed,
                title: copy.writing,
                leadingLabel: copy.back,
                onLeadingPressed: onBack,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ContentConstraints(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SectionHeader(
                        eyebrow: copy.lessonsEyebrow,
                        firstLine: copy.lessonsFirstLine,
                        secondLine: copy.lessonsSecondLine,
                        sizeClass: sizeClass,
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      SizedBox(
                        height: LayoutTokens.lessonCardMinHeight,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final ratio = sizeClass == WindowSizeClass.compact
                                ? LayoutTokens.modeCardWidthRatioCompact
                                : LayoutTokens.lessonCardWidthRatio;
                            return ListView.separated(
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
                                    indexLabel: (index + 1).toString().padLeft(
                                      2,
                                      '0',
                                    ),
                                    level: lesson.level,
                                    title: lesson.title,
                                    description: lesson.description,
                                    actionLabel: copy.start,
                                    onPressed: () => onLessonPressed(lesson.id),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
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
