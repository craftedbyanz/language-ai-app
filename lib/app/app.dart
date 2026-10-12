import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lingua_design_system/lingua_design_system.dart';

import 'localization/generated/app_localizations.dart';
import 'router/app_router.dart';

class LinguaApp extends ConsumerWidget {
  const LinguaApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppTheme.light(),
    themeMode: ThemeMode.light,
    routerConfig: ref.watch(appRouterProvider),
  );
}
