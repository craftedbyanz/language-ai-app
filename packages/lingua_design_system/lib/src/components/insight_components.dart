import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../tokens/generated/design_tokens.dart';

class InsightStatCard extends StatelessWidget {
  const InsightStatCard({
    required this.icon,
    required this.value,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(SpaceTokens.lg),
    decoration: BoxDecoration(
      color: ColorTokens.surface,
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      boxShadow: ShadowTokens.hairline,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: IconTokens.tile, color: ColorTokens.textSecondary),
        const SizedBox(height: SpaceTokens.md),
        Text(value, style: TypographyTokens.title),
        const SizedBox(height: SpaceTokens.xs),
        Text(
          label,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TypographyTokens.caption.copyWith(
            color: ColorTokens.textSecondary,
          ),
        ),
      ],
    ),
  );
}

class InsightCalendarCard extends StatelessWidget {
  const InsightCalendarCard({
    required this.title,
    required this.weekdayLabels,
    required this.leadingBlankDays,
    required this.daysInMonth,
    this.activeDays = const {},
    super.key,
  }) : assert(weekdayLabels.length == 7);

  final String title;
  final List<String> weekdayLabels;
  final int leadingBlankDays;
  final int daysInMonth;
  final Set<int> activeDays;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(SpaceTokens.lg),
    decoration: BoxDecoration(
      color: ColorTokens.surface,
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      boxShadow: ShadowTokens.hairline,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TypographyTokens.heading),
        const SizedBox(height: SpaceTokens.lg),
        Row(
          children: [
            for (final label in weekdayLabels)
              Expanded(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TypographyTokens.microLabel.copyWith(
                    color: ColorTokens.textSecondary,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: SpaceTokens.sm),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisExtent: ControlTokens.minTouchTarget,
          ),
          itemCount: leadingBlankDays + daysInMonth,
          itemBuilder: (context, index) {
            final day = index - leadingBlankDays + 1;
            if (day < 1) return const SizedBox.shrink();
            final active = activeDays.contains(day);
            return Center(
              child: Container(
                width: IconTokens.container,
                height: IconTokens.container,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: active
                      ? ColorTokens.primaryTint
                      : ColorTokens.surfaceMuted,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$day',
                  style: TypographyTokens.microLabel.copyWith(
                    color: active
                        ? ColorTokens.primaryTextOnTint
                        : ColorTokens.textSecondary,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}

class InsightWeekChartCard extends StatelessWidget {
  const InsightWeekChartCard({
    required this.title,
    required this.dayLabels,
    required this.values,
    required this.emptyLabel,
    super.key,
  }) : assert(dayLabels.length == 7 && values.length == 7);

  final String title;
  final List<String> dayLabels;
  final List<int> values;
  final String emptyLabel;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: const EdgeInsets.all(SpaceTokens.lg),
      decoration: BoxDecoration(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        boxShadow: ShadowTokens.hairline,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TypographyTokens.heading),
          const SizedBox(height: SpaceTokens.lg),
          Semantics(
            label: maxValue == 0 ? emptyLabel : null,
            child: SizedBox(
              height: LayoutTokens.historyCardHeight,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final value in values)
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: value == 0
                            ? const SizedBox.shrink()
                            : Container(
                                width: IconTokens.inline,
                                height:
                                    LayoutTokens.historyCardHeight *
                                    value /
                                    maxValue,
                                decoration: BoxDecoration(
                                  color: ColorTokens.primaryTint,
                                  borderRadius: BorderRadius.circular(
                                    RadiusTokens.chip,
                                  ),
                                ),
                              ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          const Divider(color: ColorTokens.border),
          Row(
            children: [
              for (final label in dayLabels)
                Expanded(
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TypographyTokens.microLabel.copyWith(
                      color: ColorTokens.textSecondary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class InsightHistoryCard extends StatelessWidget {
  const InsightHistoryCard({
    required this.type,
    required this.topic,
    required this.icon,
    required this.onPressed,
    super.key,
  });

  final String type;
  final String topic;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: '$type, $topic',
    child: CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      child: Material(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(RadiusTokens.card),
          child: Container(
            width: LayoutTokens.historyCardWidth,
            height: LayoutTokens.historyCardHeight,
            padding: const EdgeInsets.all(SpaceTokens.sm),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(RadiusTokens.card),
              boxShadow: ShadowTokens.hairline,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(SpaceTokens.sm),
                  decoration: BoxDecoration(
                    color: ColorTokens.surfaceMuted,
                    borderRadius: BorderRadius.circular(RadiusTokens.xs),
                  ),
                  child: Icon(icon, size: IconTokens.tile),
                ),
                const Spacer(),
                Text(type, style: TypographyTokens.microLabel),
                Text(
                  topic,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TypographyTokens.bodyStrong,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class SearchField extends StatelessWidget {
  const SearchField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Semantics(
    label: label,
    child: TextField(
      controller: controller,
      onChanged: onChanged,
      textInputAction: TextInputAction.search,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(vertical: SpaceTokens.xs),
        prefixIcon: const Icon(Icons.search_rounded, size: IconTokens.inline),
        prefixIconConstraints: const BoxConstraints(
          minWidth: ControlTokens.minTouchTarget,
          minHeight: ControlTokens.minTouchTarget,
        ),
        suffixIcon: controller.text.isEmpty
            ? null
            : IconButton(
                tooltip: label,
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
                icon: const Icon(Icons.close_rounded, size: IconTokens.inline),
              ),
        filled: true,
        fillColor: ColorTokens.surfaceMuted,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusTokens.chip),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
