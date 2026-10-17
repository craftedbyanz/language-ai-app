import 'package:flutter/material.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

final class HomeDashboardCopy {
  const HomeDashboardCopy({
    required this.greeting,
    required this.caption,
    required this.prompt,
    required this.promptLabel,
    required this.learningModes,
    required this.modePager,
    required this.modePagerPosition,
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
    required this.flashcardTitle,
    required this.flashcardCaption,
    required this.flashcardAction,
    required this.flowLetterTitle,
    required this.flowLetterCaption,
  });
  final String greeting;
  final String caption;
  final String prompt;
  final String promptLabel;
  final String learningModes;
  final String modePager;
  final String Function(int current, int total) modePagerPosition;
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
  final String flashcardTitle;
  final String flashcardCaption;
  final String flashcardAction;
  final String flowLetterTitle;
  final String flowLetterCaption;
}

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({
    required this.copy,
    required this.onWritingPressed,
    required this.onGrammarPressed,
    required this.onFlashcardsPressed,
    required this.onSettingsPressed,
    required this.onHistoryPressed,
    required this.onStreakPressed,
    required this.onMenuPressed,
    required this.onLearningLanguagePressed,
    required this.learningLanguageLabel,
    required this.streakCount,
    this.cardStyle = 'regular',
    super.key,
  });
  final HomeDashboardCopy copy;
  final VoidCallback onWritingPressed;
  final VoidCallback onGrammarPressed;
  final VoidCallback onFlashcardsPressed;
  final VoidCallback onSettingsPressed;
  final VoidCallback onHistoryPressed;
  final VoidCallback onStreakPressed;
  final VoidCallback onMenuPressed;
  final VoidCallback onLearningLanguagePressed;
  final String learningLanguageLabel;
  final int streakCount;
  final String cardStyle;

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  final _modeController = ScrollController();
  var _modePage = 0;

  @override
  void dispose() {
    _modeController.dispose();
    super.dispose();
  }

  void _selectMode(int page, double width, double ratio) {
    final target = (page * (width * ratio + LayoutTokens.carouselGap)).clamp(
      _modeController.position.minScrollExtent,
      _modeController.position.maxScrollExtent,
    );
    if (MediaQuery.disableAnimationsOf(context)) {
      _modeController.jumpTo(target);
    } else {
      _modeController.animateTo(
        target,
        duration: MotionTokens.sheet,
        curve: MotionTokens.easing,
      );
    }
    setState(() => _modePage = page);
  }

  void _snapMode(double pageExtent) {
    if (!_modeController.hasClients) return;
    final position = _modeController.position;
    final page = (position.pixels / pageExtent).round().clamp(0, 2);
    final target = (page * pageExtent).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
    if ((position.pixels - target).abs() < SpaceTokens.xs) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      _modeController.jumpTo(target);
    } else {
      _modeController.animateTo(
        target,
        duration: MotionTokens.sheet,
        curve: MotionTokens.easing,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color modeFill(Color regular) => switch (widget.cardStyle) {
      'mono' => ColorTokens.textPrimary,
      'minimal' => ColorTokens.surfaceMuted,
      'glass' => GlassTokens.barFill,
      _ => regular,
    };
    final modeForeground = switch (widget.cardStyle) {
      'mono' || 'regular' => ColorTokens.textOnPrimary,
      _ => ColorTokens.textPrimary,
    };
    return AppScaffold(
      child: AdaptiveLayout(
        builder: (context, sizeClass) => Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: LayoutTokens.marginDashboard,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: SpaceTokens.md,
                    bottom:
                        LayoutTokens.homeDockHeight +
                        LayoutTokens.homeDockFadeHeight +
                        SpaceTokens.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RepaintBoundary(
                        key: const Key('home-greeting-row'),
                        child: ColoredBox(
                          color: ColorTokens.background,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: GreetingBlock(
                                  greeting: widget.copy.greeting,
                                  caption: widget.copy.caption,
                                ),
                              ),
                              const SizedBox(width: SpaceTokens.md),
                              LearningLanguageButton(
                                label: widget.learningLanguageLabel,
                                onPressed: widget.onLearningLanguagePressed,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      PromptEntry(
                        variant: PromptEntryVariant.inline,
                        label: widget.copy.prompt,
                        semanticLabel: widget.copy.promptLabel,
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      Text(
                        widget.copy.learningModes,
                        style: TypographyTokens.heading,
                      ),
                      const SizedBox(height: SpaceTokens.lg),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final ratio = sizeClass == WindowSizeClass.compact
                              ? LayoutTokens.modeCardWidthRatioCompact
                              : LayoutTokens.modeCardWidthRatio;
                          final pageExtent =
                              constraints.maxWidth * ratio +
                              LayoutTokens.carouselGap;
                          return SizedBox(
                            height:
                                (constraints.maxWidth *
                                            ratio /
                                            LayoutTokens
                                                .homeModeCardAspectRatio)
                                        .clamp(
                                          LayoutTokens.modeCardMinHeight,
                                          double.infinity,
                                        ) *
                                    MediaQuery.textScalerOf(context).scale(1) +
                                SpaceTokens.xl,
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (notification) {
                                if (notification is ScrollUpdateNotification) {
                                  final page =
                                      (notification.metrics.pixels / pageExtent)
                                          .round()
                                          .clamp(0, 2);
                                  if (page != _modePage) {
                                    setState(() => _modePage = page);
                                  }
                                } else if (notification
                                    is ScrollEndNotification) {
                                  _snapMode(pageExtent);
                                }
                                return false;
                              },
                              child: ListView.separated(
                                controller: _modeController,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                separatorBuilder: (_, _) => const SizedBox(
                                  width: LayoutTokens.carouselGap,
                                ),
                                itemBuilder: (context, index) {
                                  final active = index == _modePage;
                                  return SizedBox(
                                    width: constraints.maxWidth * ratio,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: SpaceTokens.sm,
                                      ),
                                      child: HomeModeDepth(
                                        active: active,
                                        child: switch (index) {
                                          0 => ModeCard(
                                            index: '01',
                                            category: widget.copy.learningModes,
                                            title: widget.copy.writing,
                                            description:
                                                widget.copy.writingDescription,
                                            actionLabel: widget.copy.explore,
                                            fill: modeFill(
                                              FeatureTokens.homeWritingFill,
                                            ),
                                            foreground: modeForeground,
                                            onPressed: widget.onWritingPressed,
                                          ),
                                          1 => ModeCard(
                                            index: '02',
                                            category: widget.copy.learningModes,
                                            title: widget.copy.grammar,
                                            description:
                                                widget.copy.grammarDescription,
                                            actionLabel: widget.copy.explore,
                                            fill: modeFill(
                                              FeatureTokens.homeGrammarFill,
                                            ),
                                            foreground: modeForeground,
                                            onPressed: widget.onGrammarPressed,
                                          ),
                                          _ => ModeCard(
                                            index: '03',
                                            category: widget.copy.comingSoon,
                                            title: widget.copy.conversation,
                                            description: widget
                                                .copy
                                                .conversationDescription,
                                            actionLabel: widget.copy.comingSoon,
                                            fill: modeFill(
                                              FeatureTokens
                                                  .homeConversationFill,
                                            ),
                                            foreground: modeForeground,
                                          ),
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: SpaceTokens.sm),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          final ratio = sizeClass == WindowSizeClass.compact
                              ? LayoutTokens.modeCardWidthRatioCompact
                              : LayoutTokens.modeCardWidthRatio;
                          return PagerDots(
                            count: 3,
                            index: _modePage,
                            semanticLabel: widget.copy.modePager,
                            positionLabel: widget.copy.modePagerPosition,
                            variant: PagerDotsVariant.dashboard,
                            onSelected: (page) =>
                                _selectMode(page, constraints.maxWidth, ratio),
                          );
                        },
                      ),
                      const SizedBox(height: SpaceTokens.xxl),
                      FeatureBanner(
                        title: widget.copy.flashcardTitle,
                        caption: widget.copy.flashcardCaption,
                        actionLabel: widget.copy.flashcardAction,
                        onPressed: widget.onFlashcardsPressed,
                      ),
                      const SizedBox(height: SpaceTokens.xl),
                      FlowLetterTile(
                        title: widget.copy.flowLetterTitle,
                        caption: widget.copy.flowLetterCaption,
                      ),
                      const SizedBox(height: SpaceTokens.xxl),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: FloatingBottomBar(
                streakCount: widget.streakCount,
                streakLabel: widget.copy.streakLabel,
                historyLabel: widget.copy.history,
                menuLabel: widget.copy.menu,
                settingsLabel: widget.copy.settings,
                onSettings: widget.onSettingsPressed,
                onHistory: widget.onHistoryPressed,
                onStreak: widget.onStreakPressed,
                onMenu: widget.onMenuPressed,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
