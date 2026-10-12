import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  for (final (name, width) in [
    ('compact', 390.0),
    ('regular', 788.0),
    ('wide', 1200.0),
  ]) {
    testWidgets('surface foundation $name', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 240));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light().copyWith(platform: TargetPlatform.android),
          home: const RepaintBoundary(
            key: ValueKey('golden'),
            child: AppScaffold(
              child: ContentConstraints(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: SpaceTokens.xl),
                  child: AppSurface(child: Text('Aa')),
                ),
              ),
            ),
          ),
        ),
      );
      await expectLater(
        find.byKey(const ValueKey('golden')),
        matchesGoldenFile('goldens/surface_$name.png'),
      );
    });
  }
}
