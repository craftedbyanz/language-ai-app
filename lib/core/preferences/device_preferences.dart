import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum LearningLevel { a1, a2, b1, b2, c1, c2 }

enum LessonInputPalette { defaultColor, green, blue, purple, indigo }

final class DevicePreferences {
  const DevicePreferences({
    this.answerPalette = LessonInputPalette.defaultColor,
    this.alwaysShowHints = false,
    this.cardStyle = 'regular',
    this.learningLevel = LearningLevel.a1,
  });

  final LessonInputPalette answerPalette;
  final bool alwaysShowHints;
  final String cardStyle;
  final LearningLevel learningLevel;

  DevicePreferences copyWith({
    LessonInputPalette? answerPalette,
    bool? alwaysShowHints,
    String? cardStyle,
    LearningLevel? learningLevel,
  }) => DevicePreferences(
    answerPalette: answerPalette ?? this.answerPalette,
    alwaysShowHints: alwaysShowHints ?? this.alwaysShowHints,
    cardStyle: cardStyle ?? this.cardStyle,
    learningLevel: learningLevel ?? this.learningLevel,
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
    final learningLevelName = await _preferences.getString('learning.level');
    final palette = LessonInputPalette.values.firstWhere(
      (value) => value.name == paletteName,
      orElse: () => LessonInputPalette.defaultColor,
    );
    return DevicePreferences(
      answerPalette: palette,
      alwaysShowHints:
          await _preferences.getBool('lesson.alwaysShowHints') ?? false,
      cardStyle: await _preferences.getString('home.cardStyle') ?? 'regular',
      learningLevel: LearningLevel.values.firstWhere(
        (level) => level.name == learningLevelName,
        orElse: () => LearningLevel.a1,
      ),
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
    await _preferences.setString('learning.level', value.learningLevel.name);
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

  Future<void> selectLearningLevel(LearningLevel level) =>
      _update(state.copyWith(learningLevel: level));

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
