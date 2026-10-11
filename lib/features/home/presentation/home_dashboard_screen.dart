import 'package:flutter/material.dart';

import '../../../design_system/adaptive/adaptive_layout.dart';
import '../../../design_system/adaptive/window_size_class.dart';
import '../../../design_system/components/home_components.dart';
import '../../../design_system/primitives/app_scaffold.dart';
import '../../../design_system/theme/app_theme.dart';
import '../../../design_system/tokens/generated/design_tokens.dart';

final class HomeDashboardCopy {
  const HomeDashboardCopy({
    required this.greeting,
    required this.caption,
    required this.prompt,
    required this.promptLabel,
    required this.learningModes,
    required this.writing,
    required this.writingDescription,
    required this.grammar,
    required this.grammarDescription,
    required this.conversation,
    required this.conversationDescription,
    required this.explore,
    required this.comingSoon,
    required this.streakLabel,
    required this.history,
    required this.menu,
    required this.settings,
  });
  final String greeting;
  final String caption;
  final String prompt;
  final String promptLabel;
  final String learningModes;
  final String writing;
  final String writingDescription;
  final String grammar;
  final String grammarDescription;
  final String conversation;
  final String conversationDescription;
  final String explore;
  final String comingSoon;
  final String streakLabel;
  final String history;
  final String menu;
  final String settings;
}

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({
    required this.copy,
    required this.onWritingPressed,
    required this.onGrammarPressed,
    super.key,
  });
  final HomeDashboardCopy copy;
  final VoidCallback onWritingPressed;
  final VoidCallback onGrammarPressed;

  @override
  Widget build(BuildContext context) {
    final accessible = Theme.of(context)
        .extension<DesignTokensTheme>()!
        .accessible;
    return AppScaffold(
      child: AdaptiveLayout(
        builder: (context, sizeClass) => Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: LayoutTokens.marginDashboard,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: LayoutTokens.contentMaxWidth,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: SpaceTokens.xl,
                        bottom: ControlTokens.minTouchTarget + SpaceTokens.xxl,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GreetingBlock(
                            greeting: copy.greeting,
                            caption: copy.caption,
                          ),
                          const SizedBox(height: SpaceTokens.xl),
                          PromptEntry(
                            label: copy.prompt,
                            semanticLabel: copy.promptLabel,
                          ),
                          const SizedBox(height: SpaceTokens.xl),
                          Text(
                            copy.learningModes,
                            style: TypographyTokens.heading,
                          ),
                          const SizedBox(height: SpaceTokens.lg),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width *
                                        (sizeClass == WindowSizeClass.compact
                                            ? LayoutTokens
                                                  .modeCardWidthRatioCompact
                                            : LayoutTokens.modeCardWidthRatio),
                                    child: ModeCard(
                                      index: '01',
                                      category: copy.learningModes,
                                      title: copy.writing,
                                      description: copy.writingDescription,
                                      actionLabel: copy.explore,
                                      fill: FeatureTokens.writingHomeCardFill,
                                      foreground: accessible.onFeatureFill,
                                      onPressed: onWritingPressed,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: LayoutTokens.carouselGap,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width *
                                        LayoutTokens.modeCardWidthRatioCompact,
                                    child: ModeCard(
                                      index: '02',
                                      category: copy.learningModes,
                                      title: copy.grammar,
                                      description: copy.grammarDescription,
                                      actionLabel: copy.explore,
                                      fill: FeatureTokens.grammarHomeCardFill,
                                      foreground: accessible.onFeatureFill,
                                      onPressed: onGrammarPressed,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: LayoutTokens.carouselGap,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width *
                                        LayoutTokens.modeCardWidthRatioCompact,
                                    child: ModeCard(
                                      index: '03',
                                      category: copy.comingSoon,
                                      title: copy.conversation,
                                      description: copy.conversationDescription,
                                      actionLabel: copy.comingSoon,
                                      fill: FeatureTokens
                                          .conversationHomeCardFill,
                                      foreground: accessible.onBrand,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: SpaceTokens.xxl),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: LayoutTokens.marginDashboard,
              right: LayoutTokens.marginDashboard,
              bottom: LayoutTokens.marginDashboard,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FloatingBottomBar(
                  streakCount: 3,
                  streakLabel: copy.streakLabel,
                  historyLabel: copy.history,
                  menuLabel: copy.menu,
                  settingsLabel: copy.settings,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
