# HiFive

Flutter language-learning client for Android, iPhone, iPad, web and native macOS.
The Flutter application package is `hifive`; native application/bundle IDs are
`com.anznguyen.hifive`. The internal `lingua_*` libraries retain their package names.
The Go backend lives in a separate repository. Architecture v1 contains only
client foundations and a localized boot placeholder.

- Engineering contract: [AGENTS.md](AGENTS.md)
- UI/UX authority: [design-system/](design-system/README.md)
- Architecture: [docs/architecture/](docs/architecture/ARCHITECTURE.md)
- Decisions: [docs/adr/](docs/adr/0001-architecture-style.md)
- Setup: [environments and toolchain](docs/architecture/ENVIRONMENTS.md)
- Firebase setup (Vietnamese): [step-by-step guide](docs/firebase-setup.vi.md)
- Validation: [testing strategy](docs/architecture/TESTING_STRATEGY.md)

Flutter stable 3.47.3 / Dart 3.13.3 is pinned by `.fvmrc`. Install FVM,
then initialize the project SDK link with `fvm install`:

```sh
fvm flutter pub get
fvm flutter run -t lib/main_dev.dart -d macos
sh tool/ci.sh
```

Do not depend on a globally installed Flutter SDK. IDEs should resolve Flutter
through `.fvm/flutter_sdk`; the tracked VS Code setting already does so.

`lib/` owns application code; `android/`, `ios/`, `macos/`, and `web/` own
platform hosts. `design-system/` is canonical; `packages/lingua_design_system/`
implements its generated tokens. Internal packages use the root Pub Workspace.
The forensic archive is frozen and is not input to normal implementation.
Grammar and writing vertical slices are local-only. Development bootstrap now
initializes the named Firebase app for `hifive-dev-8189c` and supplies its Auth SDK
through Riverpod. Use `lib/main_dev.dart` for this configuration. Staging and
production retain local preview behavior; they have no configured Firebase
provider. Native Firebase resources currently describe dev only and must be
separated before a production release. Login UI, backend endpoints and database
integration are not implemented yet.
