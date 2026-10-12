import 'package:flutter/widgets.dart';

import '../tokens/generated/design_tokens.dart';

class ContentConstraints extends StatelessWidget {
  const ContentConstraints({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => Padding(
    // DD-12 default: margins are outside the capped content column.
    padding: const EdgeInsets.symmetric(horizontal: LayoutTokens.marginScreen),
    child: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: LayoutTokens.contentMaxWidth,
        ),
        child: SizedBox(width: double.infinity, child: child),
      ),
    ),
  );
}
