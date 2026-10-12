import 'package:lingua_auth/lingua_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('sign in persists and publishes the authenticated session', () async {
    final store = _MemoryStore();
    final gateway = _FakeGateway();
    final manager = AuthSessionManager(gateway: gateway, store: store);

    await manager.signIn(_SignInRequest());

    expect(manager.state, isA<Authenticated>());
    expect(await manager.accessToken(), 'access-1');
    expect(store.tokens?.refreshToken, 'refresh-1');
    await manager.close();
  });

  test('refresh failure expires the local session', () async {
    final store = _MemoryStore()
      ..tokens = const AuthTokens(
        accessToken: 'expired',
        refreshToken: 'invalid',
      );
    final gateway = _FakeGateway()..refreshFails = true;
    final manager = AuthSessionManager(gateway: gateway, store: store);
    await manager.initialize();

    await expectLater(manager.refreshAccessToken(), throwsStateError);

    expect(manager.state, isA<Unauthenticated>());
    expect(store.tokens, isNull);
    await manager.close();
  });

  test('sign out clears local state even when the backend fails', () async {
    final store = _MemoryStore()
      ..tokens = const AuthTokens(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
      );
    final gateway = _FakeGateway()..signOutFails = true;
    final manager = AuthSessionManager(gateway: gateway, store: store);
    await manager.initialize();

    await expectLater(manager.signOut(), throwsStateError);

    expect(manager.state, isA<Unauthenticated>());
    expect(store.tokens, isNull);
    await manager.close();
  });
}

final class _SignInRequest implements AuthSignInRequest {}

final class _MemoryStore implements AuthSessionStore {
  AuthTokens? tokens;

  @override
  Future<void> clear() async => tokens = null;

  @override
  Future<AuthTokens?> read() async => tokens;

  @override
  Future<void> write(AuthTokens tokens) async => this.tokens = tokens;
}

final class _FakeGateway implements AuthGateway {
  bool refreshFails = false;
  bool signOutFails = false;

  @override
  Future<AuthTokens> refresh(String refreshToken) async {
    if (refreshFails) throw StateError('refresh failed');
    return const AuthTokens(accessToken: 'access-2', refreshToken: 'refresh-2');
  }

  @override
  Future<void> signOut(String? refreshToken) async {
    if (signOutFails) throw StateError('sign out failed');
  }

  @override
  Future<AuthTokens> signIn(AuthSignInRequest request) async {
    return const AuthTokens(accessToken: 'access-1', refreshToken: 'refresh-1');
  }
}
