import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../insight_copy.dart';
import '../insight_providers.dart';

class StreakScreen extends ConsumerWidget {
  const StreakScreen({required this.copy, required this.onBack, super.key});

  final InsightCopy copy;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(insightSnapshotProvider);
    final now = DateTime.now();
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: copy.streak,
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
                          copy.streak,
                          style: TypographyTokens.display,
                        ),
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      Row(
                        children: [
                          Expanded(
                            child: InsightStatCard(
                              icon: Icons.local_fire_department_outlined,
                              value: '${snapshot.currentStreak}',
                              label: copy.currentStreak,
                            ),
                          ),
                          const SizedBox(width: SpaceTokens.sm),
                          Expanded(
                            child: InsightStatCard(
                              icon: Icons.emoji_events_outlined,
                              value: '${snapshot.longestStreak}',
                              label: copy.longestStreak,
                            ),
                          ),
                        ],
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
