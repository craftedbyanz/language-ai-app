# Folder ownership

```text
lib/
  main.dart, main_dev.dart, main_staging.dart, main_prod.dart
  app/
    app.dart
    bootstrap/               # Config injection and root error hooks
    router/                  # Typed routes and generated route helpers
    shell/                   # Temporary localized foundation page
    localization/generated/ # gen_l10n output
  core/
    config/                  # Environment and typed disabled flags
    error/, result/          # Pure Dart repository outcomes
    logging/, analytics/     # No-vendor contracts and no-op adapters
    network/, storage/, platform/ # Documented integration boundaries
  features/                  # Future capabilities; no product code
  generated/api/            # Real OpenAPI output only, when available
  l10n/                      # English and Vietnamese ARB source

packages/
  lingua_design_system/      # Flutter tokens, adaptive UI and components
  lingua_auth/               # Pure-Dart session contracts/coordinator
  lingua_networking/         # Dio factory and auth interceptor

test/
  architecture/, core/, features/
  foundation_app_test.dart
integration_test/            # Production bootstrap smoke
tool/                        # Generation, verification and CI commands
docs/architecture/, docs/adr/
android/, ios/, macos/, web/  # Flutter platform hosts
```

README placeholders document reserved boundaries. They are not empty class/layer scaffolds. Generated outputs live next to their owning subsystem, apart from the future OpenAPI client.
