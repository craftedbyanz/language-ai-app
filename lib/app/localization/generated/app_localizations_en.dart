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
