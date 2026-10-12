import 'package:flutter/material.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import '../localization/generated/app_localizations.dart';

/// Boot placeholder only; product destinations are added by future slices.
class FoundationPage extends StatelessWidget {
  const FoundationPage({this.unavailable = false, super.key});
  final bool unavailable;
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return AppScaffold(
      child: AdaptiveLayout(
        builder: (context, sizeClass) => AdaptiveNavigation(
          sizeClass: sizeClass,
          content: SingleChildScrollView(
            child: ContentConstraints(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: SpaceTokens.xl),
                child: AppSurface(
                  child: Semantics(
                    header: true,
                    child: Text(
                      unavailable
                          ? strings.pageUnavailable
                          : strings.foundationReady,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
