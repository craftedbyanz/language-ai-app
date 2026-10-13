// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Lingua';

  @override
  String get foundationReady => 'Ready to learn.';

  @override
  String get pageUnavailable => 'This page is unavailable.';

  @override
  String get homeGreeting => 'Good morning';

  @override
  String get homeCaption => 'A few focused minutes can move you forward.';

  @override
  String get homePrompt => 'Ask AI to create a lesson';

  @override
  String get homePromptLabel => 'Ask AI to create a lesson, coming soon';

  @override
  String get learningModes => 'Learning modes';

  @override
  String get modePager => 'Learning modes carousel';

  @override
  String modePagerPosition(int current, int total) {
    return 'Mode $current of $total';
  }

  @override
  String get writing => 'Writing';

  @override
  String get writingDescription =>
      'Build natural sentences through guided translation.';

  @override
  String get grammar => 'Grammar';

  @override
  String get grammarDescription => 'Sharpen patterns with quick corrections.';

  @override
  String get conversation => 'Conversation';

  @override
  String get conversationDescription =>
      'Practice everyday exchanges at your pace.';

  @override
  String get explore => 'Explore';

  @override
  String get comingSoon => 'Coming soon';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Streak: $count days',
      one: 'Streak: 1 day',
    );
    return '$_temp0';
  }

  @override
  String get history => 'History';

  @override
  String get menu => 'Menu';

  @override
  String get settings => 'Settings';

  @override
  String get insightTitle => 'Insights';

  @override
  String get insightStreak => 'Streak';

  @override
  String get insightWordGame => 'Word game';

  @override
  String get menuClose => 'Close menu';

  @override
  String get menuUpgrade => 'Upgrade Gramify Plus';

  @override
  String get streakOnFire => 'ON FIRE';

  @override
  String get streakConsecutiveDays => 'consecutive days';

  @override
  String get streakStartPrompt => 'Start your learning streak today!';

  @override
  String streakStudiedDays(int count) {
    return 'Studied $count days';
  }

  @override
  String get streakPreviousMonth => 'Previous month';

  @override
  String get streakNextMonth => 'Next month';

  @override
  String get historySectionWriting => 'Paragraphs';

  @override
  String get historyReviewTitle => 'Review';

  @override
  String get historySectionGrammar => 'Sentences';

  @override
  String get historySectionConversation => 'Conversations';

  @override
  String get historySeeMore => 'See more';

  @override
  String get settingsProfile => 'Profile';

  @override
  String get settingsFree => 'Free';

  @override
  String get settingsUpgradeTitle => 'Try Gramify Plus';

  @override
  String get settingsUpgradeCaption => 'Unlock higher limits with Plus';

  @override
  String get settingsUpgradeAction => 'Upgrade';

  @override
  String get settingsStudying => 'Studying';

  @override
  String get settingsEditProfile => 'Edit profile';

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get settingsSubscription => 'Subscription';

  @override
  String get settingsRedeem => 'Redeem code';

  @override
  String get settingsInvite => 'Invite friends';

  @override
  String get settingsRate => 'Rate app';

  @override
  String get settingsOther => 'Other';

  @override
  String get settingsFeedback => 'Send feedback';

  @override
  String get settingsTerms => 'Terms of service';

  @override
  String get settingsPrivacy => 'Privacy policy';

  @override
  String get settingsLogout => 'Sign out';

  @override
  String get insightLessons => 'Lessons';

  @override
  String get insightWords => 'Words';

  @override
  String get insightReviews => 'Reviews';

  @override
  String get insightCurrentStreak => 'Current streak';

  @override
  String get insightLongestStreak => 'Longest streak';

  @override
  String insightMonthYear(int month, int year) {
    return '$month/$year';
  }

  @override
  String get insightWeekTitle => 'This week';

  @override
  String get insightWeekEmpty => 'No activity this week';

  @override
  String get weekdayMon => 'Mon';

  @override
  String get weekdayTue => 'Tue';

  @override
  String get weekdayWed => 'Wed';

  @override
  String get weekdayThu => 'Thu';

  @override
  String get weekdayFri => 'Fri';

  @override
  String get weekdaySat => 'Sat';

  @override
  String get weekdaySun => 'Sun';

  @override
  String get insightSearch => 'Search history';

  @override
  String get insightSearchHint => 'Search lessons';

  @override
  String get insightHistoryEmptyTitle => 'No history yet';

  @override
  String get insightHistoryEmptyBody =>
      'Completed local lessons will appear here when progress tracking is connected.';

  @override
  String get insightHistoryNoResults => 'No matching lessons';

  @override
  String get settingsGuest => 'Guest';

  @override
  String get settingsGuestCaption => 'Local practice';

  @override
  String get settingsGeneral => 'General';

  @override
  String get settingsLearning => 'Learning';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsAppLanguage => 'App language';

  @override
  String get settingsLearningLanguage => 'Learning language';

  @override
  String get settingsLevel => 'Level';

  @override
  String get settingsLesson => 'Lesson settings';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsVoice => 'Voice';

  @override
  String get settingsLanguageCaption =>
      'Choose the language used for app controls and navigation.';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsVietnamese => 'Tiếng Việt';

  @override
  String get settingsApply => 'Apply';

  @override
  String get settingsSaveFailed => 'Could not save your language. Try again.';

  @override
  String get settingsVersion => 'Lingua v0.1.0 (1)';

  @override
  String get settingsFooterCaption => 'Learn a little every day.';

  @override
  String get flashcards => 'Flashcards';

  @override
  String get flashcardHomeCaption =>
      'Keep useful words close and ready to review.';

  @override
  String get flashcardExplore => 'Explore decks';

  @override
  String flashcardDeckCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count decks',
      one: '1 deck',
    );
    return '$_temp0';
  }

  @override
  String get flashcardNew => 'New';

  @override
  String get flashcardLearning => 'Learning';

  @override
  String get flashcardDue => 'Due';

  @override
  String flashcardDeckSummary(int newCount, int learningCount, int dueCount) {
    return '$newCount new · $learningCount learning · $dueCount due';
  }

  @override
  String flashcardReview(int count) {
    return 'Review ($count)';
  }

  @override
  String get flashcardWords => 'Words';

  @override
  String get flashcardGame => 'Game';

  @override
  String get flashcardEmptyTitle => 'No decks yet';

  @override
  String get flashcardEmptyBody => 'Your flashcard decks will appear here.';

  @override
  String get flashcardUnavailableTitle => 'Deck unavailable';

  @override
  String get flashcardUnavailableBody =>
      'This flashcard deck could not be found.';

  @override
  String get back => 'Back';

  @override
  String get close => 'Close';

  @override
  String get more => 'More';

  @override
  String get topicsEyebrow => 'Writing practice';

  @override
  String get topicsFirstLine => 'Choose a topic';

  @override
  String get topicsSecondLine => 'Write with purpose';

  @override
  String get setCount => 'sets';

  @override
  String get lessonsEyebrow => 'Writing lessons';

  @override
  String get lessonsFirstLine => 'Small steps';

  @override
  String get lessonsSecondLine => 'Clearer sentences';

  @override
  String get writingEmptyLessonsTitle => 'No lessons yet';

  @override
  String get writingEmptyLessonsBody =>
      'Lessons for this topic will appear here when they are available.';

  @override
  String get lessonPager => 'Lesson carousel';

  @override
  String lessonPagerPosition(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get start => 'Start';

  @override
  String get sourceText => 'Source text';

  @override
  String get answerLabel => 'Your answer';

  @override
  String get answerPlaceholder => 'Type your translation…';

  @override
  String get submit => 'Submit';

  @override
  String get grading => 'Grading…';

  @override
  String get cancel => 'Cancel';

  @override
  String get correctTitle => 'Excellent';

  @override
  String get writingRecapTitle => 'Correct';

  @override
  String get writingYourAnswer => 'Your answer';

  @override
  String get writingViewAnalysis => 'View AI analysis';

  @override
  String get incorrectTitle => 'Not correct yet';

  @override
  String get correction => 'Correction';

  @override
  String get improvements => 'Key improvements';

  @override
  String get edit => 'Edit';

  @override
  String get next => 'Next';

  @override
  String get completionTitle => 'Lesson complete';

  @override
  String get completionSteps => 'Steps completed';

  @override
  String get completionCorrections => 'Corrections';

  @override
  String get completionNextLesson => 'Next lesson';

  @override
  String get completionDone => 'Done';

  @override
  String get stepOf => 'Writing progress';

  @override
  String get hint => 'Hint';

  @override
  String get leaveExercise => 'Leave exercise?';

  @override
  String get leaveBody => 'Your current answer will not be saved.';

  @override
  String get stay => 'Stay';

  @override
  String get leave => 'Leave';

  @override
  String get grammarTopicsEyebrow => 'Grammar practice';

  @override
  String get grammarTopicsFirstLine => 'Choose a topic';

  @override
  String get grammarTopicsSecondLine => 'Strengthen your patterns';

  @override
  String get grammarCategoryAll => 'All';

  @override
  String get grammarCategoryFoundations => 'Foundations';

  @override
  String get grammarCategoryVerbs => 'Verbs';

  @override
  String get grammarLessonCount => 'lessons';

  @override
  String get grammarLessonsEyebrow => 'Grammar lessons';

  @override
  String get grammarLessonsFirstLine => 'Choose a lesson';

  @override
  String get grammarLessonsSecondLine => 'Practice one pattern';

  @override
  String get grammarStart => 'Start';

  @override
  String get grammarInstruction =>
      'Rewrite the entire sentence so it is grammatically correct.';

  @override
  String get grammarSourceSentence => 'Sentence to correct';

  @override
  String get grammarAnswerLabel => 'Your correction';

  @override
  String get grammarAnswerPlaceholder => 'Type the corrected sentence…';

  @override
  String get grammarSubmit => 'Submit';

  @override
  String get grammarGrading => 'Grading…';

  @override
  String get grammarCancel => 'Cancel';

  @override
  String get grammarRetry => 'Retry';

  @override
  String get grammarCorrectTitle => 'Correct';

  @override
  String get grammarIncorrectTitle => 'Not correct yet';

  @override
  String get grammarCorrection => 'Correction';

  @override
  String get grammarTips => 'Tips';

  @override
  String get grammarFix => 'Fix';

  @override
  String get grammarNext => 'Next';

  @override
  String get grammarStepOf => 'Grammar progress';

  @override
  String get grammarHint => 'Hint';

  @override
  String get grammarShowFeedback => 'Show last feedback';

  @override
  String get grammarYourAnswer => 'Your answer';

  @override
  String get grammarViewAnalysis => 'View AI analysis';

  @override
  String get grammarAnalysisUnavailable =>
      'AI analysis is unavailable in this local practice.';

  @override
  String get grammarEmptyTopicsTitle => 'No grammar topics';

  @override
  String get grammarEmptyTopicsBody =>
      'There are no topics available for this selection.';

  @override
  String get grammarEmptyLessonsTitle => 'No grammar lessons';

  @override
  String get grammarEmptyLessonsBody =>
      'There are no lessons available for this topic.';

  @override
  String get grammarUnavailableTitle => 'Grammar content unavailable';

  @override
  String get grammarUnavailableBody =>
      'This grammar content could not be found.';

  @override
  String get grammarErrorTitle => 'Could not load grammar practice';

  @override
  String get grammarErrorBody =>
      'Try again. Your place and answer will be kept.';

  @override
  String get grammarPager => 'Lesson carousel';

  @override
  String grammarPagerPosition(int current, int total) {
    return 'Page $current of $total';
  }

  @override
  String get grammarMinimizeFeedback => 'Minimize feedback';

  @override
  String get grammarTopicsSection => 'Topics';

  @override
  String grammarVisibleTopics(int count) {
    return '$count topics';
  }

  @override
  String get grammarCollectionLabel => 'Grammar collection';

  @override
  String get grammarCorrectionRetained => 'kept';

  @override
  String get grammarCorrectionRemoved => 'remove';

  @override
  String get grammarCorrectionInserted => 'add';
}
