import 'dart:async';

import 'auth_gateway.dart';
import 'auth_session_store.dart';
import 'auth_state.dart';

final class AuthSessionManager {
  factory AuthSessionManager({
    required AuthGateway gateway,
    required AuthSessionStore store,
  }) => AuthSessionManager._(gateway, store);

  AuthSessionManager._(this._gateway, this._store);

  final AuthGateway _gateway;
  final AuthSessionStore _store;
  final StreamController<AuthState> _states =
      StreamController<AuthState>.broadcast();

  AuthState _state = const AuthUnknown();

  AuthState get state => _state;
  Stream<AuthState> get states => _states.stream;

  Future<void> initialize() async {
    final tokens = await _store.read();
    _emit(tokens == null ? const Unauthenticated() : Authenticated(tokens));
  }

  Future<void> signIn(AuthSignInRequest request) async {
    final tokens = await _gateway.signIn(request);
    await _store.write(tokens);
    _emit(Authenticated(tokens));
  }

  Future<void> signOut() async {
    final refreshToken = switch (_state) {
      Authenticated(:final tokens) => tokens.refreshToken,
      _ => null,
    };
    try {
      await _gateway.signOut(refreshToken);
    } finally {
      await expireSession();
    }
  }

  Future<String?> accessToken() async {
    if (_state case Authenticated(:final tokens)) return tokens.accessToken;
    final stored = await _store.read();
    if (stored == null) return null;
    _emit(Authenticated(stored));
    return stored.accessToken;
  }

  Future<String?> refreshAccessToken() async {
    final current = switch (_state) {
      Authenticated(:final tokens) => tokens,
      _ => await _store.read(),
    };
    if (current == null) return null;
    try {
      final refreshed = await _gateway.refresh(current.refreshToken);
      await _store.write(refreshed);
      _emit(Authenticated(refreshed));
      return refreshed.accessToken;
    } on Object {
      await expireSession();
      rethrow;
    }
  }

  Future<void> expireSession() async {
    await _store.clear();
    _emit(const Unauthenticated());
  }

  Future<void> close() => _states.close();

  void _emit(AuthState state) {
    _state = state;
    _states.add(state);
  }
}
