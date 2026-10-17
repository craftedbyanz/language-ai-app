import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../primitives/canonical_focus_indicator.dart';
import '../tokens/generated/design_tokens.dart';

enum HomeRecommendationKind {
  surprise,
  travel,
  business,
  food,
  shopping,
  health,
  social,
  ielts,
  daily,
  entertainment,
}

enum HomeGuideKind {
  modes,
  assistant,
  generator,
  flashcards,
  progress,
  review,
  game,
}

class HomeDiscoveryHeading extends StatelessWidget {
  const HomeDiscoveryHeading({
    required this.title,
    required this.caption,
    super.key,
  });
  final String title;
  final String caption;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Semantics(
        header: true,
        child: Text(title, style: TypographyTokens.heading),
      ),
      const SizedBox(height: SpaceTokens.xs),
      Text(
        caption,
        style: TypographyTokens.caption.copyWith(
          color: ColorTokens.textSecondary,
        ),
      ),
    ],
  );
}

class HomeRecommendationChip extends StatelessWidget {
  const HomeRecommendationChip({
    required this.kind,
    required this.label,
    required this.onPressed,
    super.key,
  });
  final HomeRecommendationKind kind;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final highlighted = kind == HomeRecommendationKind.surprise;
    final foreground = highlighted
        ? ColorTokens.primaryTextOnTint
        : ColorTokens.textPrimary;
    return Semantics(
      button: true,
      label: label,
      excludeSemantics: true,
      onTap: onPressed,
      child: CanonicalFocusIndicator(
        borderRadius: BorderRadius.circular(RadiusTokens.full),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(RadiusTokens.full),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: ControlTokens.minTouchTarget,
              ),
              child: Center(
                widthFactor: 1,
                heightFactor: 1,
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: LayoutTokens.homeRecommendationFace,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpaceTokens.md,
                    vertical: SpaceTokens.xs,
                  ),
                  decoration: BoxDecoration(
                    color: highlighted
                        ? ColorTokens.primaryTint
                        : ColorTokens.surface,
                    borderRadius: BorderRadius.circular(RadiusTokens.full),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/icons/home_topics/${kind.name}.png',
                        package: 'lingua_design_system',
                        width: IconTokens.profileSetting,
                        height: IconTokens.profileSetting,
                        color: highlighted
                            ? ColorTokens.primary
                            : ColorTokens.textMuted,
                        colorBlendMode: BlendMode.srcIn,
                        excludeFromSemantics: true,
                      ),
                      const SizedBox(width: SpaceTokens.sm),
                      Flexible(
                        child: Text(
                          label,
                          style: TypographyTokens.homeQuickTopic.copyWith(
                            color: foreground,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeGuideTile extends StatelessWidget {
  const HomeGuideTile({
    required this.kind,
    required this.title,
    required this.onPressed,
    super.key,
  });
  final HomeGuideKind kind;
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: title,
    excludeSemantics: true,
    onTap: onPressed,
    child: CanonicalFocusIndicator(
      borderRadius: BorderRadius.circular(RadiusTokens.card),
      child: Material(
        color: ColorTokens.surface,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.all(SpaceTokens.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: HomeGuideIllustration(kind: kind)),
                const SizedBox(height: SpaceTokens.md),
                Text(title, style: TypographyTokens.homeGuideTitle),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

/// Code-native explainer artwork. Coordinates describe a 100×80 illustration,
/// not layout values; hosting widgets use canonical layout tokens.
class HomeGuideIllustration extends StatelessWidget {
  const HomeGuideIllustration({required this.kind, super.key});
  final HomeGuideKind kind;

  @override
  Widget build(BuildContext context) => ExcludeSemantics(
    child: SizedBox.expand(child: CustomPaint(painter: _GuidePainter(kind))),
  );
}

class _GuidePainter extends CustomPainter {
  const _GuidePainter(this.kind);
  final HomeGuideKind kind;

  Color get accent => switch (kind) {
    HomeGuideKind.modes ||
    HomeGuideKind.game => FeatureTokens.homeDiscoveryPurple,
    HomeGuideKind.assistant => FeatureTokens.homeDiscoveryPink,
    HomeGuideKind.generator => FeatureTokens.homeDiscoveryMint,
    HomeGuideKind.flashcards => ColorTokens.primary,
    HomeGuideKind.progress => FeatureTokens.homeDiscoveryOrange,
    HomeGuideKind.review => FeatureTokens.homeDiscoveryTeal,
  };

  @override
  void paint(Canvas canvas, Size size) {
    final factor = math.min(size.width / 100, size.height / 80);
    canvas.save();
    canvas.translate(
      (size.width - 100 * factor) / 2,
      (size.height - 80 * factor) / 2,
    );
    canvas.scale(factor);
    canvas.drawCircle(
      const Offset(50, 39),
      48,
      Paint()
        ..shader = RadialGradient(
          colors: [accent.withValues(alpha: .12), accent.withValues(alpha: 0)],
        ).createShader(const Rect.fromLTWH(2, -9, 96, 96)),
    );
    void panel(
      Rect rect, {
      double radius = 10,
      Color? fill,
      bool shadow = false,
    }) {
      final shape = RRect.fromRectAndRadius(rect, Radius.circular(radius));
      if (shadow) {
        canvas.drawShadow(
          Path()..addRRect(shape),
          accent.withValues(alpha: .18),
          4,
          true,
        );
      }
      canvas.drawRRect(shape, Paint()..color = fill ?? ColorTokens.surface);
      canvas.drawRRect(
        shape,
        Paint()
          ..color = accent.withValues(alpha: .12)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }

    void line(
      double x,
      double y,
      double width, {
      Color? color,
      double thickness = 3,
    }) {
      canvas.drawLine(
        Offset(x, y),
        Offset(x + width, y),
        Paint()
          ..color = color ?? accent.withValues(alpha: .3)
          ..strokeWidth = thickness
          ..strokeCap = StrokeCap.round,
      );
    }

    void glyph(IconData icon, Offset offset, double size, Color color) {
      final painter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode(icon.codePoint),
          style: TextStyle(
            fontFamily: icon.fontFamily,
            package: icon.fontPackage,
            fontSize: size,
            color: color,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      painter.paint(canvas, offset);
    }

    switch (kind) {
      case HomeGuideKind.modes:
        canvas.save();
        canvas.translate(50, 42);
        canvas.rotate(-.08);
        canvas.translate(-50, -42);
        panel(const Rect.fromLTWH(8, 25, 84, 32), shadow: true, radius: 16);
        for (var i = 0; i < 3; i++) {
          canvas.drawCircle(
            Offset(27 + i * 24, 41),
            10,
            Paint()..color = accent.withValues(alpha: i == 1 ? 1 : .16),
          );
          glyph(
            [
              Icons.menu_book_rounded,
              Icons.bolt_rounded,
              Icons.chat_bubble_rounded,
            ][i],
            Offset(20 + i * 24, 34),
            14,
            i == 1 ? ColorTokens.surface : accent,
          );
        }
        canvas.restore();
      case HomeGuideKind.assistant:
        panel(const Rect.fromLTWH(21, 9, 74, 25), shadow: true);
        glyph(Icons.auto_awesome, const Offset(29, 15), 12, accent);
        line(45, 21, 39);
        panel(
          const Rect.fromLTWH(8, 42, 82, 24),
          fill: accent.withValues(alpha: .05),
          radius: 12,
        );
        line(17, 54, 27);
        canvas.drawCircle(const Offset(78, 54), 6, Paint()..color = accent);
        glyph(
          Icons.arrow_upward_rounded,
          const Offset(73, 49),
          10,
          ColorTokens.surface,
        );
      case HomeGuideKind.generator:
        panel(
          const Rect.fromLTWH(9, 8, 37, 20),
          fill: accent.withValues(alpha: .06),
        );
        line(17, 15, 20);
        line(17, 21, 12, thickness: 2);
        glyph(
          Icons.arrow_downward_rounded,
          const Offset(45, 30),
          13,
          accent.withValues(alpha: .4),
        );
        panel(const Rect.fromLTWH(46, 47, 41, 20), fill: accent, shadow: true);
        line(55, 57, 23, color: ColorTokens.surface.withValues(alpha: .9));
      case HomeGuideKind.flashcards:
        canvas.save();
        canvas.translate(49, 41);
        canvas.rotate(-.12);
        canvas.translate(-49, -41);
        panel(
          const Rect.fromLTWH(28, 15, 40, 50),
          fill: ColorTokens.primaryTint,
        );
        canvas.restore();
        canvas.save();
        canvas.translate(55, 36);
        canvas.rotate(.08);
        canvas.translate(-55, -36);
        panel(
          const Rect.fromLTWH(35, 8, 40, 53),
          fill: ColorTokens.primaryTint,
        );
        canvas.restore();
        panel(const Rect.fromLTWH(35, 10, 39, 53), shadow: true, radius: 6);
        canvas.drawCircle(
          const Offset(54.5, 30),
          8,
          Paint()..color = accent.withValues(alpha: .1),
        );
        line(46, 44, 17);
        line(48, 49, 13, thickness: 2);
      case HomeGuideKind.progress:
        for (var i = 0; i < 4; i++) {
          panel(
            Rect.fromLTWH(22 + i * 8, 51 - i * 7, 5, 9 + i * 7),
            radius: 1,
            fill: accent.withValues(alpha: .35 + i * .2),
          );
        }
        glyph(
          Icons.local_fire_department_rounded,
          const Offset(55, 22),
          16,
          accent,
        );
      case HomeGuideKind.review:
        canvas.drawArc(
          const Rect.fromLTWH(31, 15, 40, 40),
          -math.pi / 2,
          math.pi * 1.65,
          false,
          Paint()
            ..color = accent.withValues(alpha: .35)
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3
            ..strokeCap = StrokeCap.round,
        );
        canvas.drawCircle(
          const Offset(51, 35),
          11,
          Paint()..color = accent.withValues(alpha: .12),
        );
        canvas.drawCircle(const Offset(51, 35), 3, Paint()..color = accent);
        canvas.drawCircle(const Offset(67, 18), 2.5, Paint()..color = accent);
        canvas.drawCircle(
          const Offset(76, 28),
          1.5,
          Paint()..color = accent.withValues(alpha: .5),
        );
      case HomeGuideKind.game:
        for (var i = 0; i < 4; i++) {
          panel(
            Rect.fromLTWH(10 + i * 21, 27, 18, 23),
            radius: 5,
            fill: accent.withValues(alpha: .8),
          );
          final painter = TextPainter(
            text: TextSpan(
              text: 'CATS'[i],
              style: const TextStyle(
                fontFamily: TypographyTokens.family,
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: ColorTokens.surface,
              ),
            ),
            textDirection: TextDirection.ltr,
          )..layout();
          painter.paint(canvas, Offset(14 + i * 21, 29));
        }
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(_GuidePainter oldDelegate) => oldDelegate.kind != kind;
}

/// A visual preview; purchasing remains outside the current client scope.
class HomePromotionPreview extends StatelessWidget {
  const HomePromotionPreview({
    required this.title,
    required this.caption,
    required this.status,
    required this.artwork,
    super.key,
  });
  final String title;
  final String caption;
  final String status;
  final Widget artwork;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '$title, $caption, $status',
    excludeSemantics: true,
    child: Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: LayoutTokens.bannerPromoHeight,
      ),
      padding: const EdgeInsets.all(SpaceTokens.lg),
      decoration: BoxDecoration(
        color: ColorTokens.primaryStrong,
        borderRadius: BorderRadius.circular(RadiusTokens.card),
      ),
      child: Row(
        children: [
          artwork,
          const SizedBox(width: SpaceTokens.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TypographyTokens.profilePromoTitle.copyWith(
                    color: ColorTokens.textOnPrimary,
                  ),
                ),
                const SizedBox(height: SpaceTokens.xs),
                Text(
                  caption,
                  style: TypographyTokens.homeFeatureCaption.copyWith(
                    color: ColorTokens.textOnPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
