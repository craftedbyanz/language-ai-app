import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Lingua'**
  String get appTitle;

  /// Temporary foundation screen; not a product feature
  ///
  /// In en, this message translates to:
  /// **'Ready to learn.'**
  String get foundationReady;

  /// Fallback for an unknown route
  ///
  /// In en, this message translates to:
  /// **'This page is unavailable.'**
  String get pageUnavailable;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get homeGreeting;

  /// No description provided for @homeCaption.
  ///
  /// In en, this message translates to:
  /// **'A few focused minutes can move you forward.'**
  String get homeCaption;

  /// No description provided for @homePrompt.
  ///
  /// In en, this message translates to:
  /// **'Ask AI to create a lesson'**
  String get homePrompt;

  /// No description provided for @homePromptLabel.
  ///
  /// In en, this message translates to:
  /// **'Ask AI to create a lesson, coming soon'**
  String get homePromptLabel;

  /// No description provided for @learningModes.
  ///
  /// In en, this message translates to:
  /// **'Learning modes'**
  String get learningModes;

  /// No description provided for @writing.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get writing;

  /// No description provided for @writingDescription.
  ///
  /// In en, this message translates to:
  /// **'Build natural sentences through guided translation.'**
  String get writingDescription;

  /// No description provided for @grammar.
  ///
  /// In en, this message translates to:
  /// **'Grammar'**
  String get grammar;

  /// No description provided for @grammarDescription.
  ///
  /// In en, this message translates to:
  /// **'Sharpen patterns with quick corrections.'**
  String get grammarDescription;

  /// No description provided for @conversation.
  ///
  /// In en, this message translates to:
  /// **'Conversation'**
  String get conversation;

  /// No description provided for @conversationDescription.
  ///
  /// In en, this message translates to:
  /// **'Practice everyday exchanges at your pace.'**
  String get conversationDescription;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoon;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Streak: 1 day} other{Streak: {count} days}}'**
  String streakDays(int count);

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @topicsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Writing practice'**
  String get topicsEyebrow;

  /// No description provided for @topicsFirstLine.
  ///
  /// In en, this message translates to:
  /// **'Choose a topic'**
  String get topicsFirstLine;

  /// No description provided for @topicsSecondLine.
  ///
  /// In en, this message translates to:
  /// **'Write with purpose'**
  String get topicsSecondLine;

  /// No description provided for @setCount.
  ///
  /// In en, this message translates to:
  /// **'sets'**
  String get setCount;

  /// No description provided for @lessonsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Writing lessons'**
  String get lessonsEyebrow;

  /// No description provided for @lessonsFirstLine.
  ///
  /// In en, this message translates to:
  /// **'Small steps'**
  String get lessonsFirstLine;

  /// No description provided for @lessonsSecondLine.
  ///
  /// In en, this message translates to:
  /// **'Clearer sentences'**
  String get lessonsSecondLine;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @sourceText.
  ///
  /// In en, this message translates to:
  /// **'Source text'**
  String get sourceText;

  /// No description provided for @answerLabel.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get answerLabel;

  /// No description provided for @answerPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type your translation…'**
  String get answerPlaceholder;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @grading.
  ///
  /// In en, this message translates to:
  /// **'Grading…'**
  String get grading;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @correctTitle.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get correctTitle;

  /// No description provided for @incorrectTitle.
  ///
  /// In en, this message translates to:
  /// **'Not correct yet'**
  String get incorrectTitle;

  /// No description provided for @correction.
  ///
  /// In en, this message translates to:
  /// **'Correction'**
  String get correction;

  /// No description provided for @improvements.
  ///
  /// In en, this message translates to:
  /// **'Key improvements'**
  String get improvements;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @stepOf.
  ///
  /// In en, this message translates to:
  /// **'Writing progress'**
  String get stepOf;

  /// No description provided for @hint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get hint;

  /// No description provided for @leaveExercise.
  ///
  /// In en, this message translates to:
  /// **'Leave exercise?'**
  String get leaveExercise;

  /// No description provided for @leaveBody.
  ///
  /// In en, this message translates to:
  /// **'Your current answer will not be saved.'**
  String get leaveBody;

  /// No description provided for @stay.
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
