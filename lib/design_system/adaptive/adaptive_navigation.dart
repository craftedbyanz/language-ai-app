import 'package:flutter/widgets.dart';

import 'window_size_class.dart';

/// App-owned chrome can vary without coupling the design system to routes.
/// v1 has no product navigation; absent chrome leaves content unchanged.
class AdaptiveNavigation extends StatelessWidget {
  const AdaptiveNavigation({
    required this.sizeClass,
    required this.content,
    this.chromeBuilder,
    super.key,
  });
  final WindowSizeClass sizeClass;
  final Widget content;
  final Widget Function(BuildContext, WindowSizeClass, Widget)? chromeBuilder;
  @override
  Widget build(BuildContext context) =>
      chromeBuilder?.call(context, sizeClass, content) ?? content;
}
