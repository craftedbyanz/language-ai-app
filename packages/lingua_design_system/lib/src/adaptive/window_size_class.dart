import '../tokens/generated/design_tokens.dart';

enum WindowSizeClass {
  compact,
  regular,
  wide;

  // DD-12 default: canonical boundaries, including regular at exactly 1024.
  static WindowSizeClass fromWidth(double width) {
    assert(width >= 0 && width.isFinite);
    if (width < LayoutTokens.breakpointCompact) return compact;
    if (width > LayoutTokens.breakpointWide) return wide;
    return regular;
  }
}
