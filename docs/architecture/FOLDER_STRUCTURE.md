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
  design_system/
    tokens/generated/        # Build-time output from canonical JSON
    theme/, primitives/      # Token theme, scaffold and surface
    adaptive/                # Size classes, content cap, chrome slot
    previews/                # Web-safe Widget Previewer fixture
    components/, patterns/   # Reserved ownership; no component library yet
  features/                  # Future capabilities; no product code
  generated/api/            # Real OpenAPI output only, when available
  l10n/                      # English and Vietnamese ARB source

test/
  architecture/, core/, design_system/, features/
  foundation_app_test.dart
integration_test/            # Production bootstrap smoke
tool/                        # Generation, verification and CI commands
docs/architecture/, docs/adr/
android/, ios/, macos/        # Flutter native hosts
```

README placeholders document reserved boundaries. They are not empty class/layer scaffolds. Generated outputs live next to their owning subsystem, apart from the future OpenAPI client.
