import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_design_system/lingua_design_system.dart';

void main() {
  testWidgets(
    'Home glass responds to content below instead of painting opaque blue',
    (tester) async {
      const key = Key('capture');
      Future<Uint8List> capture(
        Color background, {
        bool striped = false,
      }) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Center(
              child: RepaintBoundary(
                key: key,
                child: SizedBox(
                  width: 320,
                  height: 400,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: striped
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: List.generate(
                                  64,
                                  (index) => Expanded(
                                    child: ColoredBox(
                                      color: index.isEven
                                          ? ColorTokens.textPrimary
                                          : ColorTokens.surface,
                                    ),
                                  ),
                                ),
                              )
                            : ColoredBox(color: background),
                      ),
                      const Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: FloatingBottomBar(
                          streakCount: 0,
                          streakLabel: 'Streak: 0 days',
                          historyLabel: 'History',
                          menuLabel: 'Menu',
                          settingsLabel: 'Profile',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        final boundary = tester.renderObject<RenderRepaintBoundary>(
          find.byKey(key),
        );
        return (await tester.runAsync(() async {
          final image = await boundary.toImage();
          final bytes = await image.toByteData();
          image.dispose();
          return bytes!.buffer.asUint8List();
        }))!;
      }

      final blue = await capture(ColorTokens.primaryStrong);
      final red = await capture(ColorTokens.error);
      // Sample the open gap between Review and Menu, clear of their painted rims.
      // The same location must retain background hue.
      const offset = (380 * 320 + 81) * 4;
      expect(
        blue.sublist(offset, offset + 3),
        isNot(orderedEquals(red.sublist(offset, offset + 3))),
      );
      expect(blue[offset + 2], greaterThan(blue[offset]));
      expect(red[offset], greaterThan(red[offset + 2]));
      final stripes = await capture(ColorTokens.surface, striped: true);
      int channelAt(int x, int y) => stripes[(y * 320 + x) * 4];
      expect((channelAt(81, 100) - channelAt(86, 100)).abs(), greaterThan(200));
      expect(
        (channelAt(81, 380) - channelAt(86, 380)).abs(),
        lessThan(50),
        reason: 'The dock must blur sharp content, not merely tint it.',
      );
      expect(tester.takeException(), isNull);
    },
  );
}
