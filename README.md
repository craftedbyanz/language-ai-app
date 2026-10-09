# Lingua

Flutter language-learning client for Android, iPhone, iPad and native macOS.
The Go backend lives in a separate repository. Architecture v1 contains only
client foundations and a localized boot placeholder.

- Engineering contract: [AGENTS.md](AGENTS.md)
- UI/UX authority: [design-system/](design-system/README.md)
- Architecture: [docs/architecture/](docs/architecture/ARCHITECTURE.md)
- Decisions: [docs/adr/](docs/adr/0001-architecture-style.md)
- Setup: [environments and toolchain](docs/architecture/ENVIRONMENTS.md)
- Validation: [testing strategy](docs/architecture/TESTING_STRATEGY.md)

Use Flutter stable 3.47.3 / Dart 3.13.3 (`.fvmrc`). With the SDK on PATH:

```sh
flutter pub get
flutter run -t lib/main_dev.dart -d macos
sh tool/ci.sh
```

`lib/` owns application code; `android/`, `ios/`, and `macos/` own native hosts.
`design-system/` is canonical; `lib/design_system/` implements its generated tokens.
The forensic archive is frozen and is not input to normal implementation.
No product feature, backend, API integration, auth or database is implemented yet.
