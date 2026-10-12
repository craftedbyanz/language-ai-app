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

  /// No description provided for @grammarTopicsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Grammar practice'**
  String get grammarTopicsEyebrow;

  /// No description provided for @grammarTopicsFirstLine.
  ///
  /// In en, this message translates to:
  /// **'Choose a topic'**
  String get grammarTopicsFirstLine;

  /// No description provided for @grammarTopicsSecondLine.
  ///
  /// In en, this message translates to:
  /// **'Strengthen your patterns'**
  String get grammarTopicsSecondLine;

  /// No description provided for @grammarCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get grammarCategoryAll;

  /// No description provided for @grammarCategoryFoundations.
  ///
  /// In en, this message translates to:
  /// **'Foundations'**
  String get grammarCategoryFoundations;

  /// No description provided for @grammarCategoryVerbs.
  ///
  /// In en, this message translates to:
  /// **'Verbs'**
  String get grammarCategoryVerbs;

  /// No description provided for @grammarLessonCount.
  ///
  /// In en, this message translates to:
  /// **'lessons'**
  String get grammarLessonCount;

  /// No description provided for @grammarLessonsEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Grammar lessons'**
  String get grammarLessonsEyebrow;

  /// No description provided for @grammarLessonsFirstLine.
  ///
  /// In en, this message translates to:
  /// **'Choose a lesson'**
  String get grammarLessonsFirstLine;

  /// No description provided for @grammarLessonsSecondLine.
  ///
  /// In en, this message translates to:
  /// **'Practice one pattern'**
  String get grammarLessonsSecondLine;

  /// No description provided for @grammarStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get grammarStart;

  /// No description provided for @grammarInstruction.
  ///
  /// In en, this message translates to:
  /// **'Rewrite the entire sentence so it is grammatically correct.'**
  String get grammarInstruction;

  /// No description provided for @grammarSourceSentence.
  ///
  /// In en, this message translates to:
  /// **'Sentence to correct'**
  String get grammarSourceSentence;

  /// No description provided for @grammarAnswerLabel.
  ///
  /// In en, this message translates to:
  /// **'Your correction'**
  String get grammarAnswerLabel;

  /// No description provided for @grammarAnswerPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Type the corrected sentence…'**
  String get grammarAnswerPlaceholder;

  /// No description provided for @grammarSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get grammarSubmit;

  /// No description provided for @grammarGrading.
  ///
  /// In en, this message translates to:
  /// **'Grading…'**
  String get grammarGrading;

  /// No description provided for @grammarCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get grammarCancel;

  /// No description provided for @grammarRetry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get grammarRetry;

  /// No description provided for @grammarCorrectTitle.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get grammarCorrectTitle;

  /// No description provided for @grammarIncorrectTitle.
  ///
  /// In en, this message translates to:
  /// **'Not correct yet'**
  String get grammarIncorrectTitle;

  /// No description provided for @grammarCorrection.
  ///
  /// In en, this message translates to:
  /// **'Correction'**
  String get grammarCorrection;

  /// No description provided for @grammarTips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get grammarTips;

  /// No description provided for @grammarFix.
  ///
  /// In en, this message translates to:
  /// **'Fix'**
  String get grammarFix;

  /// No description provided for @grammarNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get grammarNext;

  /// No description provided for @grammarStepOf.
  ///
  /// In en, this message translates to:
  /// **'Grammar progress'**
  String get grammarStepOf;

  /// No description provided for @grammarHint.
  ///
  /// In en, this message translates to:
  /// **'Hint'**
  String get grammarHint;

  /// No description provided for @grammarShowFeedback.
  ///
  /// In en, this message translates to:
  /// **'Show last feedback'**
  String get grammarShowFeedback;

  /// No description provided for @grammarYourAnswer.
  ///
  /// In en, this message translates to:
  /// **'Your answer'**
  String get grammarYourAnswer;

  /// No description provided for @grammarViewAnalysis.
  ///
  /// In en, this message translates to:
  /// **'View AI analysis'**
  String get grammarViewAnalysis;

  /// No description provided for @grammarAnalysisUnavailable.
  ///
  /// In en, this message translates to:
  /// **'AI analysis is unavailable in this local practice.'**
  String get grammarAnalysisUnavailable;

  /// No description provided for @grammarEmptyTopicsTitle.
  ///
  /// In en, this message translates to:
  /// **'No grammar topics'**
  String get grammarEmptyTopicsTitle;

  /// No description provided for @grammarEmptyTopicsBody.
  ///
  /// In en, this message translates to:
  /// **'There are no topics available for this selection.'**
  String get grammarEmptyTopicsBody;

  /// No description provided for @grammarEmptyLessonsTitle.
  ///
  /// In en, this message translates to:
  /// **'No grammar lessons'**
  String get grammarEmptyLessonsTitle;

  /// No description provided for @grammarEmptyLessonsBody.
  ///
  /// In en, this message translates to:
  /// **'There are no lessons available for this topic.'**
  String get grammarEmptyLessonsBody;

  /// No description provided for @grammarUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Grammar content unavailable'**
  String get grammarUnavailableTitle;

  /// No description provided for @grammarUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'This grammar content could not be found.'**
  String get grammarUnavailableBody;

  /// No description provided for @grammarErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Could not load grammar practice'**
  String get grammarErrorTitle;

  /// No description provided for @grammarErrorBody.
  ///
  /// In en, this message translates to:
  /// **'Try again. Your place and answer will be kept.'**
  String get grammarErrorBody;

  /// No description provided for @grammarPager.
  ///
  /// In en, this message translates to:
  /// **'Lesson carousel'**
  String get grammarPager;

  /// No description provided for @grammarPagerPosition.
  ///
  /// In en, this message translates to:
  /// **'Page {current} of {total}'**
  String grammarPagerPosition(int current, int total);

  /// No description provided for @grammarMinimizeFeedback.
  ///
  /// In en, this message translates to:
  /// **'Minimize feedback'**
  String get grammarMinimizeFeedback;

  /// No description provided for @grammarTopicsSection.
  ///
  /// In en, this message translates to:
  /// **'Topics'**
  String get grammarTopicsSection;

  /// No description provided for @grammarVisibleTopics.
  ///
  /// In en, this message translates to:
  /// **'{count} topics'**
  String grammarVisibleTopics(int count);

  /// No description provided for @grammarCollectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Grammar collection'**
  String get grammarCollectionLabel;

  /// No description provided for @grammarCorrectionRetained.
  ///
  /// In en, this message translates to:
  /// **'kept'**
  String get grammarCorrectionRetained;

  /// No description provided for @grammarCorrectionRemoved.
  ///
  /// In en, this message translates to:
  /// **'remove'**
  String get grammarCorrectionRemoved;

  /// No description provided for @grammarCorrectionInserted.
  ///
  /// In en, this message translates to:
  /// **'add'**
  String get grammarCorrectionInserted;
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
