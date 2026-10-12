import 'auth_tokens.dart';

sealed class AuthState {
  const AuthState();
}

final class AuthUnknown extends AuthState {
  const AuthUnknown();
}

final class Authenticated extends AuthState {
  const Authenticated(this.tokens);

  final AuthTokens tokens;
}

final class Unauthenticated extends AuthState {
  const Unauthenticated();
}
