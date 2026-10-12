import 'package:flutter/material.dart';

import '../tokens/generated/design_tokens.dart';

class AppSurface extends StatelessWidget {
  const AppSurface({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      boxShadow: ShadowTokens.hairline,
    ),
    child: Padding(padding: const EdgeInsets.all(SpaceTokens.lg), child: child),
  );
}
