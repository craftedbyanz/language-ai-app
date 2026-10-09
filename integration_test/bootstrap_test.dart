import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lingua/main_prod.dart' as app;
import 'package:lingua/app/shell/foundation_page.dart';
import 'package:lingua/app/localization/generated/app_localizations.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('production entrypoint boots without external services', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    final page = find.byType(FoundationPage);
    expect(page, findsOneWidget);
    final strings = AppLocalizations.of(tester.element(page))!;
    expect(find.text(strings.foundationReady), findsOneWidget);
  });
}
