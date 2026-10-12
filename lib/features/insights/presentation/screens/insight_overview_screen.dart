import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../insight_copy.dart';
import '../insight_providers.dart';

class InsightOverviewScreen extends ConsumerWidget {
  const InsightOverviewScreen({
    required this.copy,
    required this.onBack,
    super.key,
  });

  final InsightCopy copy;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(insightSnapshotProvider);
    final now = DateTime.now();
    final stats = [
      (Icons.school_outlined, snapshot.lessons, copy.lessons),
      (Icons.edit_outlined, snapshot.writing, copy.writing),
      (Icons.auto_stories_outlined, snapshot.grammar, copy.grammar),
      (
        Icons.chat_bubble_outline_rounded,
        snapshot.conversations,
        copy.conversations,
      ),
      (Icons.style_outlined, snapshot.words, copy.words),
      (Icons.replay_rounded, snapshot.reviews, copy.reviews),
    ];
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: copy.title,
              leadingLabel: copy.back,
              onLeadingPressed: onBack,
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
                      Semantics(
                        header: true,
                        child: Text(
                          copy.title,
                          style: TypographyTokens.display,
                        ),
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final width =
                              (constraints.maxWidth - SpaceTokens.sm * 2) / 3;
                          return Wrap(
                            spacing: SpaceTokens.sm,
                            runSpacing: SpaceTokens.sm,
                            children: [
                              for (final (icon, value, label) in stats)
                                SizedBox(
                                  width: width,
                                  child: InsightStatCard(
                                    icon: icon,
                                    value: '$value',
                                    label: label,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: LayoutTokens.sheetWidth,
                        ),
                        child: InsightCalendarCard(
                          title: copy.monthYear(now.month, now.year),
                          weekdayLabels: copy.weekdayLabels,
                          leadingBlankDays:
                              DateTime(now.year, now.month).weekday - 1,
                          daysInMonth: DateTime(now.year, now.month + 1, 0).day,
                          activeDays: snapshot.activeDaysThisMonth,
                        ),
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxWidth: LayoutTokens.sheetWidth,
                        ),
                        child: InsightWeekChartCard(
                          title: copy.weekTitle,
                          dayLabels: copy.weekdayLabels,
                          values: snapshot.weekActivity,
                          emptyLabel: copy.weekEmpty,
                        ),
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
