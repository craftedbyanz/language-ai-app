#!/bin/sh
set -eu
flutter pub get --enforce-lockfile
dart run tool/verify_design_tokens.dart
flutter gen-l10n
dart run build_runner build
git diff --exit-code -- lib/app/localization/generated lib/app/router/app_routes.g.dart
dart format --output=none --set-exit-if-changed lib test integration_test tool
flutter analyze
dart run tool/check_architecture.dart
flutter test
