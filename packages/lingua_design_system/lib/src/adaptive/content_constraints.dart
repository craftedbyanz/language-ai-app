import 'package:flutter/widgets.dart';

import '../tokens/generated/design_tokens.dart';

class ContentConstraints extends StatelessWidget {
  const ContentConstraints({required this.child, super.key})
    : _fullWidth = false;

  /// Window-filling overview pages use the same gutters as Home.
  const ContentConstraints.fullWidth({required this.child, super.key})
    : _fullWidth = true;

  final bool _fullWidth;
  final Widget child;
  @override
  Widget build(BuildContext context) => Padding(
    // DD-12 caps reading columns; DD-29 fills overview pages.
    padding: EdgeInsets.symmetric(
      horizontal: _fullWidth
          ? LayoutTokens.marginDashboard
          : LayoutTokens.marginScreen,
    ),
    child: Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: _fullWidth ? double.infinity : LayoutTokens.contentMaxWidth,
        ),
        child: SizedBox(width: double.infinity, child: child),
      ),
    ),
  );
}
