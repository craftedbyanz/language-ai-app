import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

/// Draws the canonical keyboard focus ring around the focused descendant.
///
/// The wrapper is not itself focusable, so traversal and activation remain on
/// the real control inside it.
class CanonicalFocusIndicator extends StatefulWidget {
  const CanonicalFocusIndicator({
    required this.child,
    required this.borderRadius,
    super.key,
  });

  final Widget child;
  final BorderRadius borderRadius;

  @override
  State<CanonicalFocusIndicator> createState() =>
      _CanonicalFocusIndicatorState();
}

class _CanonicalFocusIndicatorState extends State<CanonicalFocusIndicator> {
  var _hasFocus = false;

  @override
  void initState() {
    super.initState();
    FocusManager.instance.addHighlightModeListener(_handleHighlightModeChange);
  }

  @override
  void dispose() {
    FocusManager.instance.removeHighlightModeListener(
      _handleHighlightModeChange,
    );
    super.dispose();
  }

  void _handleHighlightModeChange(FocusHighlightMode mode) {
    if (_hasFocus && mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final accessible =
        Theme.of(context).extension<DesignTokensTheme>()?.accessible ??
        const AccessibleTokens();
    final showRing =
        _hasFocus &&
        FocusManager.instance.highlightMode == FocusHighlightMode.traditional;
    return Focus(
      canRequestFocus: false,
      skipTraversal: true,
      onFocusChange: (value) {
        if (_hasFocus != value) setState(() => _hasFocus = value);
      },
      child: Stack(
        fit: StackFit.passthrough,
        clipBehavior: Clip.none,
        children: [
          if (showRing)
            Positioned.fill(
              left: -FocusTokens.ringOffset,
              top: -FocusTokens.ringOffset,
              right: -FocusTokens.ringOffset,
              bottom: -FocusTokens.ringOffset,
              child: IgnorePointer(
                child: DecoratedBox(
                  key: const Key('canonical-focus-ring'),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: accessible.focusRing,
                      width: FocusTokens.ringWidth,
                    ),
                    borderRadius: widget.borderRadius,
                  ),
                ),
              ),
            ),
          widget.child,
        ],
      ),
    );
  }
}
