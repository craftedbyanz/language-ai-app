import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';
import 'package:lottie/lottie.dart';

void main() {
  const captureKey = Key('flame-capture');
  late Duration cycle;

  Future<void> loadAnimations(WidgetTester tester) async {
    await tester.runAsync(() async {
      for (final variant in ['inactive', 'active']) {
        final composition = await AssetLottie(
          'assets/animations/streak_flame_$variant.json',
          package: 'lingua_design_system',
        ).load();
        cycle = composition.duration;
        expect(composition.frameRate, 24);
        expect(composition.endFrame - composition.startFrame, closeTo(26, .1));
        expect(composition.warnings, isEmpty);
      }
    });
  }

  Future<void> mount(
    WidgetTester tester, {
    bool reducedMotion = false,
    bool tickerEnabled = true,
    bool active = false,
  }) async {
    await loadAnimations(tester);
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: reducedMotion),
          child: TickerMode(
            enabled: tickerEnabled,
            child: Center(
              child: RepaintBoundary(
                key: captureKey,
                child: StreakFlame(isActive: active),
              ),
            ),
          ),
        ),
      ),
    );

    await tester.pump();
  }

  Future<Uint8List> pixels(WidgetTester tester) async {
    final boundary = tester.renderObject<RenderRepaintBoundary>(
      find.byKey(captureKey),
    );
    return (await tester.runAsync(() async {
      final image = await boundary.toImage();
      final data = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
      image.dispose();
      return data!.buffer.asUint8List();
    }))!;
  }

  for (final active in [false, true]) {
    testWidgets('flame visibly changes pixels with active=$active', (
      tester,
    ) async {
      await mount(tester, active: active);
      await tester.pump();
      final before = await pixels(tester);
      final size = tester.getSize(find.byType(StreakFlame));
      await tester.pump(cycle ~/ 4);
      expect(await pixels(tester), isNot(orderedEquals(before)));
      await expectLater(
        find.byKey(captureKey),
        matchesGoldenFile(
          'goldens/streak_flame_${active ? 'active' : 'inactive'}_quarter.png',
        ),
      );
      expect(tester.getSize(find.byType(StreakFlame)), size);
      await tester.pumpWidget(const SizedBox.shrink());
      expect(tester.binding.transientCallbackCount, 0);
      expect(tester.takeException(), isNull);
    });
  }

  testWidgets('reduced motion freezes and can be switched at runtime', (
    tester,
  ) async {
    await mount(tester, reducedMotion: true);
    final before = await pixels(tester);
    await tester.pump(cycle ~/ 4);
    expect(await pixels(tester), orderedEquals(before));
    expect(tester.binding.transientCallbackCount, 0);
    await mount(tester);
    await tester.pump();
    await tester.pump(cycle ~/ 4);
    expect(await pixels(tester), isNot(orderedEquals(before)));
    await mount(tester, reducedMotion: true);
    await tester.pump();
    expect(await pixels(tester), orderedEquals(before));
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('hidden ticker and background lifecycle pause the flame', (
    tester,
  ) async {
    await mount(tester, tickerEnabled: false);
    expect(tester.binding.transientCallbackCount, 0);
    await mount(tester);
    await tester.pump();
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
    await tester.pump();
    expect(tester.binding.transientCallbackCount, 0);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    expect(tester.binding.transientCallbackCount, greaterThan(0));
    await mount(tester, tickerEnabled: false);
    await tester.pump();
    expect(tester.binding.transientCallbackCount, 0);
  });

  testWidgets('neutral and active flame visual baseline', (tester) async {
    await loadAnimations(tester);
    await tester.pumpWidget(
      const MaterialApp(
        home: MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Center(
            child: RepaintBoundary(
              key: captureKey,
              child: ColoredBox(
                color: ColorTokens.backgroundPlain,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreakFlame(isActive: false),
                    StreakFlame(isActive: true),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
    await expectLater(
      find.byKey(captureKey),
      matchesGoldenFile('goldens/streak_flame.png'),
    );
  });
}
