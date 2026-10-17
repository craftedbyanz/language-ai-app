import 'package:firebase_core/firebase_core.dart';

import '../config/app_environment.dart';
import 'firebase_options_dev.dart';

/// Only development has a Firebase project configured at this stage.
/// Other entrypoints retain their local preview behavior, without a dev fallback.
FirebaseOptions? firebaseOptionsForEnvironment(AppEnvironment environment) =>
    switch (environment) {
      AppEnvironment.development => DefaultFirebaseOptions.currentPlatform,
      AppEnvironment.staging || AppEnvironment.production => null,
    };

/// Use an explicit app so auth never falls back to native default credentials.
Future<FirebaseApp?> initializeFirebase(AppEnvironment environment) async {
  final options = firebaseOptionsForEnvironment(environment);
  if (options == null) return null;
  return Firebase.initializeApp(name: 'hifive-development', options: options);
}
