import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:hifive/core/firebase/firebase_providers.dart';
import 'package:hifive/features/home/home.dart';
import 'package:hifive/main_dev.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('development boots with the explicit Firebase app and auth', (
    tester,
  ) async {
    await app.main();
    await tester.pumpAndSettle();
    final home = find.byType(HomeDashboardScreen);
    expect(home, findsOneWidget);
    final container = ProviderScope.containerOf(tester.element(home));
    final firebaseApp = container.read(firebaseAppProvider);
    expect(firebaseApp.name, 'hifive-development');
    expect(firebaseApp.options.projectId, 'hifive-dev-8189c');
    final auth = container.read(firebaseAuthProvider);
    expect(auth.app.name, firebaseApp.name);
    // Read restored state only: never create, sign in, or sign out a cloud user.
    final user = await auth.authStateChanges().first.timeout(
      const Duration(seconds: 15),
    );
    expect(user?.uid, auth.currentUser?.uid);
  });
}
