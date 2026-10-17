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
              centre: Semantics(
                header: true,
                child: Text(
                  widget.copy.streak,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TypographyTokens.streakNavTitle,
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: SpaceTokens.lg),
                      InsightStreakSummary(
                        onFireLabel: widget.copy.streakOnFire,
                        count: '${snapshot.currentStreak}',
                        unitLabel: widget.copy.streakConsecutiveDays,
                        prompt: widget.copy.streakStartPrompt,
                        isActive: snapshot.currentStreak > 0,
                      ),
                      const SizedBox(height: SpaceTokens.xxl),
                      InsightCalendarCard(
                        variant: InsightCalendarVariant.streak,
                        lastElapsedDay: isCurrentMonth ? now.day : null,
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
                              label: widget.copy.streakCurrentLabel,
                              accent: ColorTokens.warning,
                            ),
                          ),
                          const SizedBox(width: SpaceTokens.md),
                          Expanded(
                            child: InsightStreakStatCard(
                              icon: Icons.bolt_rounded,
                              value: '${snapshot.longestStreak}',
                              label: widget.copy.streakLongestLabel,
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
