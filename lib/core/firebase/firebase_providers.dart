import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The composition root must supply the app selected for this environment.
/// Tests and local previews do not initialize native Firebase implicitly.
final firebaseAppProvider = Provider<FirebaseApp>((ref) {
  throw StateError('Firebase is not configured for this application root.');
});

/// SDK-owned persistence and token refresh; no parallel credential store.
/// Feature presentation should consume its repository, not this SDK provider.
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instanceFor(app: ref.watch(firebaseAppProvider));
});
