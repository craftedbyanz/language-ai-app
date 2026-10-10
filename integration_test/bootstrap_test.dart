import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:lingua/main_prod.dart' as app;
import 'package:lingua/app/localization/generated/app_localizations.dart';
import 'package:lingua/features/home/home.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('production entrypoint boots without external services', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();
    final page = find.byType(HomeDashboardScreen);
    expect(page, findsOneWidget);
    final strings = AppLocalizations.of(tester.element(page))!;
    expect(find.text(strings.homeGreeting), findsOneWidget);
    expect(find.text(strings.writing), findsOneWidget);
  });
}
