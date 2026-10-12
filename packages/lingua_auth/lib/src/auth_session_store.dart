import 'auth_tokens.dart';

/// Persistence boundary for credentials.
///
/// Mobile implementations should use platform-secure storage. Web storage
/// policy must be selected from the application's threat model.
abstract interface class AuthSessionStore {
  Future<AuthTokens?> read();

  Future<void> write(AuthTokens tokens);

  Future<void> clear();
}
