import 'package:flutter/material.dart';

import '../tokens/generated/design_tokens.dart';

enum HomeDockAction { history, menu, profile }

/// Template artwork for the dock; its containing control owns semantics.
class HomeDockIcon extends StatelessWidget {
  const HomeDockIcon({required this.action, super.key});
  final HomeDockAction action;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.square(
      key: ValueKey('home-dock-${action.name}-glyph'),
      dimension: action == HomeDockAction.menu
          ? IconTokens.homeDockMenu
          : IconTokens.homeDock,
      child: Image.asset(
        'assets/icons/home_dock/${switch (action) {
          HomeDockAction.history => 'review',
          HomeDockAction.menu => 'menu',
          HomeDockAction.profile => 'profile',
        }}.png',
        package: 'lingua_design_system',
        color: ColorTokens.textSecondary,
        colorBlendMode: BlendMode.srcIn,
        excludeFromSemantics: true,
      ),
    ),
  );
}
