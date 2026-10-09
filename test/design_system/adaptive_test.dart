import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua/design_system/adaptive/adaptive_layout.dart';
import 'package:lingua/design_system/adaptive/adaptive_navigation.dart';
import 'package:lingua/design_system/adaptive/content_constraints.dart';
import 'package:lingua/design_system/adaptive/window_size_class.dart';
import 'package:lingua/design_system/tokens/generated/design_tokens.dart';

void main() {
  test('breakpoint endpoints follow canonical inclusive regular range', () {
    expect(WindowSizeClass.fromWidth(559), WindowSizeClass.compact);
    expect(WindowSizeClass.fromWidth(560), WindowSizeClass.regular);
    expect(WindowSizeClass.fromWidth(1024), WindowSizeClass.regular);
    expect(WindowSizeClass.fromWidth(1025), WindowSizeClass.wide);
  });
  testWidgets('responds to parent resize and constrains the content column', (
    tester,
  ) async {
    for (final width in [390.0, 788.0, 1440.0]) {
      await tester.binding.setSurfaceSize(Size(width, 900));
      WindowSizeClass? observed;
      await tester.pumpWidget(
        MaterialApp(
          home: AdaptiveLayout(
            builder: (context, size) {
              observed = size;
              return AdaptiveNavigation(
                sizeClass: size,
                content: const ContentConstraints(
                  child: SizedBox(key: ValueKey('content')),
                ),
              );
            },
          ),
        ),
      );
      expect(observed, WindowSizeClass.fromWidth(width));
      final expected = (width - LayoutTokens.marginScreen * 2).clamp(
        0,
        LayoutTokens.contentMaxWidth,
      );
      expect(
        tester.getSize(find.byKey(const ValueKey('content'))).width,
        expected,
      );
    }
    await tester.binding.setSurfaceSize(null);
  });
  testWidgets('embedded constraints win over window dimensions', (
    tester,
  ) async {
    WindowSizeClass? observed;
    await tester.pumpWidget(
      MaterialApp(
        home: Center(
          child: SizedBox(
            width: 400,
            child: AdaptiveLayout(
              builder: (context, size) {
                observed = size;
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
    expect(observed, WindowSizeClass.compact);
  });
}
