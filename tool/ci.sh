#!/bin/sh
set -eu

pinned_flutter_version=$(sed -n 's/^[[:space:]]*"flutter"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' .fvmrc)
if [ -z "$pinned_flutter_version" ]; then
  echo "Unable to read the pinned Flutter version from .fvmrc." >&2
  exit 1
fi

if command -v fvm >/dev/null 2>&1; then
  run_flutter() {
    fvm flutter "$@"
  }
  run_dart() {
    fvm dart "$@"
  }
elif [ "${CI:-}" = "true" ]; then
  if ! command -v flutter >/dev/null 2>&1 || ! command -v dart >/dev/null 2>&1; then
    echo "CI must install the Flutter version pinned by .fvmrc." >&2
    exit 1
  fi
  actual_flutter_version=$(flutter --version --machine | sed -n 's/.*"frameworkVersion"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')
  if [ "$actual_flutter_version" != "$pinned_flutter_version" ]; then
    echo "CI Flutter $actual_flutter_version does not match .fvmrc ($pinned_flutter_version)." >&2
    exit 1
  fi
  run_flutter() {
    flutter "$@"
  }
  run_dart() {
    dart "$@"
  }
else
  echo "FVM is required. Install FVM, then run: fvm install" >&2
  exit 1
fi

run_flutter pub get --enforce-lockfile
run_dart run tool/verify_design_tokens.dart
run_flutter gen-l10n
run_dart run build_runner build
git diff --exit-code -- lib/app/localization/generated lib/app/router/app_routes.g.dart packages/lingua_design_system/lib/src/tokens/generated
run_dart format --output=none --set-exit-if-changed lib test integration_test tool packages
run_flutter analyze
run_dart run tool/check_architecture.dart
run_flutter test
run_flutter test packages/lingua_auth packages/lingua_networking packages/lingua_design_system
run_flutter build web --release
