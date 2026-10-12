import 'auth_tokens.dart';

/// Marker implemented by the application for its concrete sign-in method.
abstract interface class AuthSignInRequest {}

/// Backend-facing authentication operations.
///
/// Implementations belong in an adapter once the backend contract exists.
abstract interface class AuthGateway {
  Future<AuthTokens> signIn(AuthSignInRequest request);

  Future<AuthTokens> refresh(String refreshToken);

  Future<void> signOut(String? refreshToken);
}
