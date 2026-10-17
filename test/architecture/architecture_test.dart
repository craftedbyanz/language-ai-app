import 'package:flutter_test/flutter_test.dart';

import '../../tool/check_architecture.dart';

void main() {
  test(
    'repository respects architecture boundaries',
    () => expect(checkArchitecture(), isEmpty),
  );
  test('guards relative, package, export and conditional dependencies', () {
    final cases = <(String, String)>[
      (
        'lib/features/demo/domain/entity.dart',
        "import 'package:flutter/widgets.dart';",
      ),
      (
        'lib/features/demo/domain/entity.dart',
        "import 'package:riverpod/riverpod.dart';",
      ),
      ('lib/features/demo/domain/entity.dart', "import 'dart:convert';"),
      (
        'lib/features/demo/domain/entity.dart',
        "export '../../../generated/api/client.dart';",
      ),
      (
        'lib/features/demo/domain/entity.dart',
        "import '../data/adapter.dart';",
      ),
      (
        'packages/lingua_design_system/lib/a.dart',
        "export '../../../lib/features/demo/demo.dart';",
      ),
      ('lib/core/config/a.dart', "import '../../features/demo/demo.dart';"),
      (
        'lib/features/demo/presentation/a.dart',
        "import '../../../generated/api/client.dart';",
      ),
      (
        'lib/features/demo/presentation/a.dart',
        "export 'a.dart' if (dart.library.io) '../../../generated/api/client.dart';",
      ),
      (
        'lib/features/demo/presentation/a.dart',
        "import 'package:hifive/features/other/presentation/view.dart';",
      ),
      ('lib/features/demo/domain/a.dart', "class BaseRepository {}"),
      (
        'packages/lingua_design_system/lib/src/tokens/generated/a.dart',
        'class Tokens {}',
      ),
      (
        'packages/lingua_networking/lib/client.dart',
        "import 'package:lingua_auth/lingua_auth.dart';",
      ),
      (
        'packages/lingua_auth/lib/session.dart',
        "import 'package:lingua_networking/lingua_networking.dart';",
      ),
      (
        'packages/lingua_auth/lib/session.dart',
        "import 'package:flutter/widgets.dart';",
      ),
    ];
    for (final (path, source) in cases) {
      expect(checkSource(path, source), isNotEmpty, reason: '$path: $source');
    }
  });
  test('accepts pure domain, public contracts and ignores comments', () {
    expect(
      checkSource(
        'lib/features/demo/domain/entity.dart',
        "import 'dart:async';\nimport '../../../core/result/result.dart';\nimport 'value.dart';",
      ),
      isEmpty,
    );
    expect(
      checkSource(
        'lib/features/demo/presentation/a.dart',
        "import 'package:hifive/features/other/other.dart';",
      ),
      isEmpty,
    );
    expect(
      checkSource(
        'lib/core/a.dart',
        "/* export '../features/demo/demo.dart'; */\n// import '../features/demo/demo.dart';",
      ),
      isEmpty,
    );
  });
}
