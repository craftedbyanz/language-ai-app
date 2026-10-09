import 'dart:io';

import 'generate_design_tokens.dart';

Future<void> main() async {
  final expected = await formattedTokens();
  final actual = File(tokenOutput);
  if (!actual.existsSync() || actual.readAsStringSync() != expected) {
    stderr.writeln(
      'Design tokens are stale. Run dart run tool/generate_design_tokens.dart',
    );
    exitCode = 1;
    return;
  }
  stdout.writeln('Design tokens are current.');
}
