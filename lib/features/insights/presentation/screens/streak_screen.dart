import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

import '../insight_copy.dart';
import '../insight_providers.dart';

class StreakScreen extends ConsumerStatefulWidget {
  const StreakScreen({required this.copy, required this.onBack, super.key});

  final InsightCopy copy;
  final VoidCallback onBack;

  @override
  ConsumerState<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends ConsumerState<StreakScreen> {
  late DateTime _month = DateTime(DateTime.now().year, DateTime.now().month);

  void _changeMonth(int offset) => setState(() {
    _month = DateTime(_month.year, _month.month + offset);
  });

  @override
  Widget build(BuildContext context) {
    final snapshot = ref.watch(insightSnapshotProvider);
    final now = DateTime.now();
    final isCurrentMonth = _month.year == now.year && _month.month == now.month;
    final activeDays = isCurrentMonth ? snapshot.activeDaysThisMonth : <int>{};
    return AppScaffold(
      backgroundColor: ColorTokens.backgroundPlain,
      child: Column(
        children: [
          ContentConstraints(
            child: AppHeader(
              variant: AppHeaderVariant.pushed,
              title: widget.copy.streak,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: SpaceTokens.lg),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.copy.streakOnFire,
                                  style: TypographyTokens.microLabel.copyWith(
                                    color: ColorTokens.warningText,
                                  ),
                                ),
                                const SizedBox(height: SpaceTokens.sm),
                                Text(
                                  '${snapshot.currentStreak}',
                                  style: TypographyTokens.display,
                                ),
                                Text(
                                  widget.copy.streakConsecutiveDays,
                                  style: TypographyTokens.caption.copyWith(
                                    color: ColorTokens.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: SpaceTokens.sm),
                                Text(
                                  widget.copy.streakStartPrompt,
                                  style: TypographyTokens.caption.copyWith(
                                    color: ColorTokens.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          StreakFlame(isActive: snapshot.currentStreak > 0),
                        ],
                      ),
                      const SizedBox(height: SpaceTokens.xxl),
                      InsightCalendarCard(
                        title: widget.copy.monthYear(_month.month, _month.year),
                        studiedDaysLabel: widget.copy.streakStudiedDays(
                          activeDays.length,
                        ),
                        previousMonthLabel: widget.copy.streakPreviousMonth,
                        nextMonthLabel: widget.copy.streakNextMonth,
                        onPreviousMonth: () => _changeMonth(-1),
                        onNextMonth: isCurrentMonth
                            ? null
                            : () => _changeMonth(1),
                        weekdayLabels: [
                          widget.copy.weekdayLabels.last,
                          ...widget.copy.weekdayLabels.take(6),
                        ],
                        leadingBlankDays:
                            DateTime(_month.year, _month.month).weekday % 7,
                        daysInMonth: DateTime(
                          _month.year,
                          _month.month + 1,
                          0,
                        ).day,
                        activeDays: activeDays,
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      Row(
                        children: [
                          Expanded(
                            child: InsightStreakStatCard(
                              icon: Icons.local_fire_department_rounded,
                              value: '${snapshot.currentStreak}',
                              label: widget.copy.currentStreak,
                              accent: ColorTokens.warning,
                            ),
                          ),
                          const SizedBox(width: SpaceTokens.md),
                          Expanded(
                            child: InsightStreakStatCard(
                              icon: Icons.bolt_rounded,
                              value: '${snapshot.longestStreak}',
                              label: widget.copy.longestStreak,
                              accent: ColorTokens.warning,
                            ),
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
