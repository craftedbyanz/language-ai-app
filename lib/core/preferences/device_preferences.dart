import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LessonInputPalette { defaultColor, green, blue, purple, indigo }

final class DevicePreferences {
  const DevicePreferences({
    this.answerPalette = LessonInputPalette.defaultColor,
    this.alwaysShowHints = false,
    this.cardStyle = 'regular',
  });

  final LessonInputPalette answerPalette;
  final bool alwaysShowHints;
  final String cardStyle;

  DevicePreferences copyWith({
    LessonInputPalette? answerPalette,
    bool? alwaysShowHints,
    String? cardStyle,
  }) => DevicePreferences(
    answerPalette: answerPalette ?? this.answerPalette,
    alwaysShowHints: alwaysShowHints ?? this.alwaysShowHints,
    cardStyle: cardStyle ?? this.cardStyle,
  );
}

abstract interface class DevicePreferencesStore {
  Future<DevicePreferences> load();
  Future<void> save(DevicePreferences value);
}

final class MemoryDevicePreferencesStore implements DevicePreferencesStore {
  MemoryDevicePreferencesStore([this.value = const DevicePreferences()]);

  DevicePreferences value;

  @override
  Future<DevicePreferences> load() async => value;

  @override
  Future<void> save(DevicePreferences value) async => this.value = value;
}

final class SharedDevicePreferencesStore implements DevicePreferencesStore {
  SharedDevicePreferencesStore({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _preferences;

  @override
  Future<DevicePreferences> load() async {
    final paletteName = await _preferences.getString('lesson.answerPalette');
    final palette = LessonInputPalette.values.firstWhere(
      (value) => value.name == paletteName,
      orElse: () => LessonInputPalette.defaultColor,
    );
    return DevicePreferences(
      answerPalette: palette,
      alwaysShowHints:
          await _preferences.getBool('lesson.alwaysShowHints') ?? false,
      cardStyle: await _preferences.getString('home.cardStyle') ?? 'regular',
    );
  }

  @override
  Future<void> save(DevicePreferences value) async {
    await _preferences.setString(
      'lesson.answerPalette',
      value.answerPalette.name,
    );
    await _preferences.setBool('lesson.alwaysShowHints', value.alwaysShowHints);
    await _preferences.setString('home.cardStyle', value.cardStyle);
  }
}

final initialDevicePreferencesProvider = Provider<DevicePreferences>(
  (ref) => const DevicePreferences(),
);
final devicePreferencesStoreProvider = Provider<DevicePreferencesStore>(
  (ref) => SharedDevicePreferencesStore(),
);
final devicePreferencesProvider =
    NotifierProvider<DevicePreferencesController, DevicePreferences>(
      DevicePreferencesController.new,
    );

final class DevicePreferencesController extends Notifier<DevicePreferences> {
  @override
  DevicePreferences build() => ref.watch(initialDevicePreferencesProvider);

  Future<void> selectPalette(LessonInputPalette palette) =>
      _update(state.copyWith(answerPalette: palette));

  Future<void> resetPalette() =>
      _update(state.copyWith(answerPalette: LessonInputPalette.defaultColor));

  Future<void> setAlwaysShowHints(bool enabled) =>
      _update(state.copyWith(alwaysShowHints: enabled));

  Future<void> selectCardStyle(String style) =>
      _update(state.copyWith(cardStyle: style));

  Future<void> _update(DevicePreferences value) async {
    final previous = state;
    state = value;
    try {
      await ref.read(devicePreferencesStoreProvider).save(value);
    } on Exception {
      state = previous;
      rethrow;
    }
  }
}
