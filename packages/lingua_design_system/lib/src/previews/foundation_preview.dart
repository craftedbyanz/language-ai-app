import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import '../primitives/app_scaffold.dart';
import '../primitives/app_surface.dart';
import '../theme/app_theme.dart';
import '../tokens/generated/design_tokens.dart';

@Preview(name: 'Foundation surface')
Widget foundationPreview() => MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: AppTheme.light(),
  home: AppScaffold(
    child: Padding(
      padding: const EdgeInsets.all(SpaceTokens.xl),
      // Preview-only fixture copy, never product chrome.
      child: AppSurface(child: Text('Aa', style: TypographyTokens.title)),
    ),
  ),
);
