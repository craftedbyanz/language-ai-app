import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class LocalePreferenceStore {
  Future<Locale?> load();
  Future<void> save(Locale locale);
}

final class SharedPreferencesLocaleStore implements LocalePreferenceStore {
  SharedPreferencesLocaleStore({
    SharedPreferencesAsync? preferences,
    this.key = 'app.locale',
  }) : _preferences = preferences ?? SharedPreferencesAsync();

  final String key;
  final SharedPreferencesAsync _preferences;

  @override
  Future<Locale?> load() async {
    final code = await _preferences.getString(key);
    return code == 'en' || code == 'vi' ? Locale(code!) : null;
  }

  @override
  Future<void> save(Locale locale) =>
      _preferences.setString(key, locale.languageCode);
}

final class MemoryLocaleStore implements LocalePreferenceStore {
  MemoryLocaleStore({this.value});

  Locale? value;

  @override
  Future<Locale?> load() async => value;

  @override
  Future<void> save(Locale locale) async => value = locale;
}

final initialLocaleProvider = Provider<Locale?>((ref) => null);
final localePreferenceStoreProvider = Provider<LocalePreferenceStore>(
  (ref) => MemoryLocaleStore(),
);

final localePreferenceProvider = NotifierProvider<LocalePreference, Locale?>(
  LocalePreference.new,
);

final class LocalePreference extends Notifier<Locale?> {
  @override
  Locale? build() => ref.watch(initialLocaleProvider);

  Future<void> select(Locale locale) async {
    if (locale.languageCode != 'en' && locale.languageCode != 'vi') return;
    await ref.read(localePreferenceStoreProvider).save(locale);
    state = locale;
  }
}
