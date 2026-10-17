import 'package:flutter/material.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

final class HomeRecommendation {
  const HomeRecommendation({required this.kind, required this.label});
  final HomeRecommendationKind kind;
  final String label;
}

final class HomeGuide {
  const HomeGuide({
    required this.kind,
    required this.title,
    required this.body,
    this.actionLabel,
  });
  final HomeGuideKind kind;
  final String title;
  final String body;
  final String? actionLabel;
}

final class HomeDiscoveryCopy {
  const HomeDiscoveryCopy({
    required this.recommendationsTitle,
    required this.recommendationsCaption,
    required this.recommendations,
    required this.guideTitle,
    required this.guideCaption,
    required this.guides,
    required this.close,
    required this.recommendationNotice,
    required this.recommendationAction,
    required this.previewWords,
    required this.learningModesCaption,
    required this.promoTitle,
    required this.promoCaption,
  });
  final String recommendationsTitle;
  final String recommendationsCaption;
  final List<HomeRecommendation> recommendations;
  final String guideTitle;
  final String guideCaption;
  final List<HomeGuide> guides;
  final String close;
  final String recommendationNotice;
  final String recommendationAction;
  final List<({String word, String meaning})> previewWords;
  final String learningModesCaption;
  final String promoTitle;
  final String promoCaption;
}

Future<void> showHomeDiscoverySheet({
  required BuildContext context,
  required String title,
  required String body,
  required String closeLabel,
  HomeGuideKind? illustration,
  String? actionLabel,
  VoidCallback? onAction,
}) => showModalBottomSheet<void>(
  context: context,
  useSafeArea: true,
  isScrollControlled: true,
  showDragHandle: true,
  constraints: const BoxConstraints(maxWidth: LayoutTokens.sheetWidth),
  builder: (sheetContext) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(SpaceTokens.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Semantics(
                  header: true,
                  child: Text(title, style: TypographyTokens.heading),
                ),
              ),
              IconButton(
                tooltip: closeLabel,
                onPressed: () => Navigator.of(sheetContext).pop(),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          if (illustration != null)
            SizedBox(
              height: LayoutTokens.bannerFeatureHeight,
              child: HomeGuideIllustration(kind: illustration),
            ),
          const SizedBox(height: SpaceTokens.md),
          Text(body, style: TypographyTokens.body),
          if (actionLabel != null && onAction != null) ...[
            const SizedBox(height: SpaceTokens.xl),
            AppButton(
              label: actionLabel,
              onPressed: () {
                Navigator.of(sheetContext).pop();
                onAction();
              },
            ),
          ],
          SizedBox(height: MediaQuery.paddingOf(sheetContext).bottom),
        ],
      ),
    ),
  ),
);
