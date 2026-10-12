import 'package:flutter/widgets.dart';

import 'window_size_class.dart';

class AdaptiveLayout extends StatelessWidget {
  const AdaptiveLayout({required this.builder, super.key});
  final Widget Function(BuildContext, WindowSizeClass) builder;
  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final width = constraints.hasBoundedWidth
          ? constraints.maxWidth
          : MediaQuery.sizeOf(context).width;
      return builder(context, WindowSizeClass.fromWidth(width));
    },
  );
}
