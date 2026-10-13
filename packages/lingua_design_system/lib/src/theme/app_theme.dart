import 'package:flutter/material.dart';

import '../tokens/generated/design_tokens.dart';

abstract final class AppTheme {
  static ThemeData light({ColorProfile profile = ColorProfile.production}) {
    final accessible = AccessibleTokens(profile: profile);
    final base = ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      fontFamily: TypographyTokens.family,
    );
    final typography =
        TextTheme(
          displayLarge: TypographyTokens.display,
          displayMedium: TypographyTokens.display,
          displaySmall: TypographyTokens.displayCompact,
          headlineLarge: TypographyTokens.title,
          headlineMedium: TypographyTokens.title,
          headlineSmall: TypographyTokens.title,
          titleLarge: TypographyTokens.title,
          titleMedium: TypographyTokens.heading,
          titleSmall: TypographyTokens.bodyStrong,
          bodyLarge: TypographyTokens.body,
          bodyMedium: TypographyTokens.body,
          bodySmall: TypographyTokens.caption,
          labelLarge: TypographyTokens.bodyStrong,
          labelMedium: TypographyTokens.caption,
          labelSmall: TypographyTokens.microLabel,
        ).apply(
          bodyColor: ColorTokens.textPrimary,
          displayColor: ColorTokens.textPrimary,
        );
    return base.copyWith(
      scaffoldBackgroundColor: ColorTokens.background,
      colorScheme: ColorScheme.light(
        primary: accessible.brandFill,
        onPrimary: accessible.onBrand,
        primaryContainer: ColorTokens.primaryTint,
        onPrimaryContainer: accessible.textOnPrimaryTint,
        secondary: accessible.brandFill,
        onSecondary: accessible.onBrand,
        secondaryContainer: ColorTokens.surfaceMuted,
        onSecondaryContainer: ColorTokens.textPrimary,
        tertiary: accessible.brandFill,
        onTertiary: accessible.onBrand,
        tertiaryContainer: ColorTokens.surfaceMuted,
        onTertiaryContainer: ColorTokens.textPrimary,
        error: accessible.errorText,
        onError: ColorTokens.textOnPrimary,
        errorContainer: ColorTokens.errorTint,
        onErrorContainer: accessible.errorTextOnTint,
        surface: ColorTokens.surface,
        onSurface: ColorTokens.textPrimary,
        onSurfaceVariant: ColorTokens.textSecondary,
        outline: ColorTokens.textMuted,
        outlineVariant: ColorTokens.border,
        surfaceContainerLowest: ColorTokens.surface,
        surfaceContainerLow: ColorTokens.surface,
        surfaceContainer: ColorTokens.surfaceMuted,
        surfaceContainerHigh: ColorTokens.surfaceElevated,
        surfaceContainerHighest: ColorTokens.surfaceElevated,
        surfaceDim: ColorTokens.surfaceMuted,
        surfaceBright: ColorTokens.surface,
        inverseSurface: ColorTokens.textPrimary,
        onInverseSurface: ColorTokens.textOnPrimary,
        inversePrimary: ColorTokens.primaryTint,
        shadow: ColorTokens.textPrimary,
        scrim: ColorTokens.overlayScrimDefault,
        surfaceTint: ColorTokens.surface,
      ),
      textTheme: typography,
      primaryTextTheme: typography.apply(
        bodyColor: accessible.onBrand,
        displayColor: accessible.onBrand,
      ),
      focusColor: accessible.focusRing,
      disabledColor: ColorTokens.textMuted,
      dividerColor: ColorTokens.border,
      extensions: [DesignTokensTheme(profile: profile)],
    );
  }
}

/// Custom semantic access without letting Material generate product colors.
class DesignTokensTheme extends ThemeExtension<DesignTokensTheme> {
  const DesignTokensTheme({this.profile = ColorProfile.production});
  final ColorProfile profile;
  AccessibleTokens get accessible => AccessibleTokens(profile: profile);
  @override
  DesignTokensTheme copyWith({ColorProfile? profile}) =>
      DesignTokensTheme(profile: profile ?? this.profile);
  @override
  DesignTokensTheme lerp(covariant DesignTokensTheme? other, double t) =>
      t < 0.5 ? this : other ?? this;
}
