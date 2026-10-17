// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Lingua';

  @override
  String get foundationReady => 'Sẵn sàng học hỏi.';

  @override
  String get pageUnavailable => 'Trang này hiện không khả dụng.';

  @override
  String get homeGreeting => 'Chào buổi sáng';

  @override
  String get homeCaption => 'Vài phút tập trung sẽ giúp bạn tiến bộ.';

  @override
  String get homePrompt => 'Nhờ AI tạo bài học';

  @override
  String get homePromptLabel => 'Nhờ AI tạo bài học, sắp ra mắt';

  @override
  String get learningModes => 'Chế độ học';

  @override
  String get modePager => 'Danh sách chế độ học';

  @override
  String modePagerPosition(int current, int total) {
    return 'Chế độ $current trên $total';
  }

  @override
  String get writing => 'Viết';

  @override
  String get writingDescription =>
      'Xây dựng câu tự nhiên qua bài dịch có hướng dẫn.';

  @override
  String get grammar => 'Ngữ pháp';

  @override
  String get grammarDescription => 'Rèn luyện cấu trúc qua các bài sửa nhanh.';

  @override
  String get conversation => 'Hội thoại';

  @override
  String get conversationDescription =>
      'Luyện giao tiếp hàng ngày theo nhịp độ của bạn.';

  @override
  String get explore => 'Khám phá';

  @override
  String get comingSoon => 'Sắp ra mắt';

  @override
  String streakDays(int count) {
    return 'Chuỗi: $count ngày';
  }

  @override
  String get history => 'Lịch sử';

  @override
  String get menu => 'Menu';

  @override
  String get settings => 'Cài đặt';

  @override
  String get insightTitle => 'Thống kê';

  @override
  String get insightStreak => 'Chuỗi Streak';

  @override
  String get insightWordGame => 'Trò chơi từ vựng';

  @override
  String get menuClose => 'Đóng trình đơn';

  @override
  String get menuUpgrade => 'Nâng cấp Gramify Plus';

  @override
  String get streakCurrentLabel => 'HIỆN TẠI';

  @override
  String get streakLongestLabel => 'DÀI NHẤT';

  @override
  String get streakOnFire => 'ON FIRE';

  @override
  String get streakConsecutiveDays => 'ngày liên tiếp';

  @override
  String get streakStartPrompt => 'Bắt đầu chuỗi học tập ngay hôm nay!';

  @override
  String streakStudiedDays(int count) {
    return 'Đã học $count ngày';
  }

  @override
  String get streakPreviousMonth => 'Tháng trước';

  @override
  String get streakNextMonth => 'Tháng sau';

  @override
  String get historySectionWriting => 'Đoạn văn';

  @override
  String get historyReviewTitle => 'Ôn tập';

  @override
  String get historySectionGrammar => 'Câu';

  @override
  String get historySectionConversation => 'Hội thoại';

  @override
  String get historySeeMore => 'Xem thêm';

  @override
  String get settingsProfile => 'Profile';

  @override
  String get settingsFree => 'Free';

  @override
  String get settingsUpgradeTitle => 'Dùng thử Gramify Plus';

  @override
  String get settingsUpgradeCaption => 'Nâng cấp để có giới hạn cao hơn';

  @override
  String get settingsUpgradeAction => 'Upgrade';

  @override
  String get settingsStudying => 'Đang học';

  @override
  String get settingsEditProfile => 'Chỉnh sửa hồ sơ';

  @override
  String get settingsNotifications => 'Thông báo';

  @override
  String get settingsSubscription => 'Gói đăng ký';

  @override
  String get settingsRedeem => 'Nhập mã ưu đãi';

  @override
  String get settingsInvite => 'Mời bạn bè';

  @override
  String get settingsRate => 'Đánh giá ứng dụng';

  @override
  String get settingsOther => 'Khác';

  @override
  String get settingsFeedback => 'Gửi phản hồi';

  @override
  String get settingsTerms => 'Điều khoản dịch vụ';

  @override
  String get settingsPrivacy => 'Chính sách quyền riêng tư';

  @override
  String get settingsLogout => 'Đăng xuất';

  @override
  String get insightLessons => 'Bài học';

  @override
  String get insightWords => 'Từ vựng';

  @override
  String get insightReviews => 'Lượt ôn tập';

  @override
  String get insightCurrentStreak => 'Chuỗi hiện tại';

  @override
  String get insightLongestStreak => 'Chuỗi dài nhất';

  @override
  String insightMonthYear(int month, int year) {
    return 'tháng $month năm $year';
  }

  @override
  String get insightWeekTitle => 'Tuần này';

  @override
  String get insightWeekEmpty => 'Tuần này chưa có hoạt động';

  @override
  String get weekdayMon => 'T2';

  @override
  String get weekdayTue => 'T3';

  @override
  String get weekdayWed => 'T4';

  @override
  String get weekdayThu => 'T5';

  @override
  String get weekdayFri => 'T6';

  @override
  String get weekdaySat => 'T7';

  @override
  String get weekdaySun => 'CN';

  @override
  String get insightSearch => 'Tìm lịch sử';

  @override
  String get insightSearchHint => 'Tìm bài học';

  @override
  String get insightHistoryEmptyTitle => 'Chưa có lịch sử';

  @override
  String get insightHistoryEmptyBody =>
      'Các bài học cục bộ đã hoàn thành sẽ xuất hiện ở đây khi có chức năng theo dõi tiến độ.';

  @override
  String get insightHistoryNoResults => 'Không tìm thấy bài học phù hợp';

  @override
  String get settingsGuest => 'Khách';

  @override
  String get settingsGuestCaption => 'Luyện tập cục bộ';

  @override
  String get settingsGeneral => 'Cài đặt chung';

  @override
  String get settingsLearning => 'Học tập';

  @override
  String get settingsLanguage => 'Ngôn ngữ';

  @override
  String get settingsAppLanguage => 'Ngôn ngữ ứng dụng';

  @override
  String get settingsLearningLanguage => 'Ngôn ngữ học';

  @override
  String get settingsLevel => 'Trình độ';

  @override
  String get settingsLesson => 'Cài đặt bài học';

  @override
  String get settingsAppearance => 'Giao diện';

  @override
  String get settingsVoice => 'Giọng đọc';

  @override
  String get settingsLanguageCaption =>
      'Chọn ngôn ngữ cho các nút và phần điều hướng của ứng dụng.';

  @override
  String get settingsEnglish => 'English';

  @override
  String get settingsVietnamese => 'Tiếng Việt';

  @override
  String get settingsApply => 'Áp dụng';

  @override
  String get settingsSaveFailed => 'Không thể lưu ngôn ngữ. Hãy thử lại.';

  @override
  String get settingsVersion => 'Lingua v0.1.0 (1)';

  @override
  String get settingsFooterCaption => 'Học một chút mỗi ngày.';

  @override
  String get settingsInputColor => 'Màu ô nhập';

  @override
  String get settingsDefault => 'Mặc định';

  @override
  String get settingsHintOptions => 'Cài đặt gợi ý';

  @override
  String get settingsAlwaysShowHints => 'Luôn hiển thị gợi ý';

  @override
  String get settingsAlwaysShowHintsCaption =>
      'Hiển thị từ gợi ý mà không cần chạm';

  @override
  String get settingsCardStyle => 'Kiểu thẻ';

  @override
  String get settingsRegular => 'Thường';

  @override
  String get settingsMono => 'Đơn sắc';

  @override
  String get settingsMinimal => 'Tối giản';

  @override
  String get settingsGlass => 'Kính';

  @override
  String get settingsOrange => 'Cam';

  @override
  String get settingsYellow => 'Vàng';

  @override
  String get settingsGreen => 'Xanh lá';

  @override
  String get settingsBlue => 'Xanh dương';

  @override
  String get settingsPink => 'Hồng';

  @override
  String get settingsPurple => 'Tím';

  @override
  String get settingsIndigo => 'Chàm';

  @override
  String get flashcards => 'Thẻ ghi nhớ';

  @override
  String get flashcardHomeCaption => 'Lưu những từ hữu ích để ôn tập khi cần.';

  @override
  String get flashcardExplore => 'Xem bộ thẻ';

  @override
  String flashcardDeckCount(int count) {
    return '$count bộ thẻ';
  }

  @override
  String get flashcardNew => 'Mới';

  @override
  String get flashcardLearning => 'Đang học';

  @override
  String get flashcardDue => 'Đến hạn';

  @override
  String flashcardDeckSummary(int newCount, int learningCount, int dueCount) {
    return '$newCount mới · $learningCount đang học · $dueCount đến hạn';
  }

  @override
  String flashcardReview(int count) {
    return 'Ôn tập ($count)';
  }

  @override
  String get flashcardWords => 'Từ vựng';

  @override
  String get flashcardGame => 'Trò chơi';

  @override
  String get flashcardEmptyTitle => 'Chưa có bộ thẻ';

  @override
  String get flashcardEmptyBody => 'Bộ thẻ ghi nhớ của bạn sẽ xuất hiện ở đây.';

  @override
  String get flashcardUnavailableTitle => 'Không tìm thấy bộ thẻ';

  @override
  String get flashcardUnavailableBody => 'Bộ thẻ ghi nhớ này không khả dụng.';

  @override
  String get flashcardFlipHint => 'CHẠM ĐỂ LẬT';

  @override
  String get flashcardAgain => 'Học lại';

  @override
  String get flashcardHard => 'Khó';

  @override
  String get flashcardGood => 'Tốt';

  @override
  String get flashcardEasy => 'Dễ';

  @override
  String get flashcardCompleteTitle => 'Đã luyện tập xong';

  @override
  String get flashcardCompleteBody => 'Bạn đã xem hết các thẻ trong bộ này.';

  @override
  String get flashcardDone => 'Xong';

  @override
  String get flashcardPracticeNotice =>
      'Buổi luyện tập thử. Lịch ôn tập sẽ đồng bộ khi tài khoản được kết nối.';

  @override
  String get back => 'Quay lại';

  @override
  String get close => 'Đóng';

  @override
  String get more => 'Thêm';

  @override
  String get topicsEyebrow => 'Luyện viết';

  @override
  String get topicsFirstLine => 'Chọn chủ đề';

  @override
  String get topicsSecondLine => 'Viết có mục đích';

  @override
  String get setCount => 'bộ';

  @override
  String get lessonsEyebrow => 'Bài học viết';

  @override
  String get lessonsFirstLine => 'Từng bước nhỏ';

  @override
  String get lessonsSecondLine => 'Câu văn rõ hơn';

  @override
  String get writingEmptyLessonsTitle => 'Chưa có bài học';

  @override
  String get writingEmptyLessonsBody =>
      'Bài học cho chủ đề này sẽ xuất hiện khi có nội dung.';

  @override
  String get lessonPager => 'Danh sách bài học viết';

  @override
  String lessonPagerPosition(int current, int total) {
    return 'Trang $current trên $total';
  }

  @override
  String get start => 'Bắt đầu';

  @override
  String get sourceText => 'Văn bản nguồn';

  @override
  String get answerLabel => 'Câu trả lời của bạn';

  @override
  String get answerPlaceholder => 'Nhập bản dịch…';

  @override
  String get submit => 'Gửi';

  @override
  String get grading => 'Đang chấm…';

  @override
  String get cancel => 'Hủy';

  @override
  String get correctTitle => 'Xuất sắc';

  @override
  String get writingRecapTitle => 'Chính xác';

  @override
  String get writingYourAnswer => 'Câu trả lời của bạn';

  @override
  String get writingViewAnalysis => 'Xem phân tích AI';

  @override
  String get incorrectTitle => 'Chưa chính xác';

  @override
  String get correction => 'Câu sửa';

  @override
  String get improvements => 'Điểm cần cải thiện';

  @override
  String get edit => 'Chỉnh sửa';

  @override
  String get next => 'Tiếp theo';

  @override
  String get completionTitle => 'Hoàn thành bài học';

  @override
  String get completionSteps => 'Bước đã hoàn thành';

  @override
  String get completionCorrections => 'Lượt cần sửa';

  @override
  String get completionNextLesson => 'Bài tiếp theo';

  @override
  String get completionDone => 'Xong';

  @override
  String get stepOf => 'Tiến độ bài viết';

  @override
  String get hint => 'Gợi ý';

  @override
  String get leaveExercise => 'Rời bài tập?';

  @override
  String get leaveBody => 'Câu trả lời hiện tại sẽ không được lưu.';

  @override
  String get stay => 'Ở lại';

  @override
  String get leave => 'Rời';

  @override
  String get grammarTopicsEyebrow => 'Luyện ngữ pháp';

  @override
  String get grammarTopicsFirstLine => 'Chọn chủ đề';

  @override
  String get grammarTopicsSecondLine => 'Củng cố cấu trúc';

  @override
  String get grammarCategoryAll => 'Tất cả';

  @override
  String get grammarCategoryFoundations => 'Nền tảng';

  @override
  String get grammarCategoryVerbs => 'Động từ';

  @override
  String get grammarLessonCount => 'bài học';

  @override
  String get grammarLessonsEyebrow => 'Bài học ngữ pháp';

  @override
  String get grammarLessonsFirstLine => 'Chọn bài học';

  @override
  String get grammarLessonsSecondLine => 'Luyện từng cấu trúc';

  @override
  String get grammarStart => 'Bắt đầu';

  @override
  String get grammarInstruction =>
      'Viết lại toàn bộ câu sao cho đúng ngữ pháp.';

  @override
  String get grammarSourceSentence => 'Câu cần sửa';

  @override
  String get grammarAnswerLabel => 'Câu sửa của bạn';

  @override
  String get grammarAnswerPlaceholder => 'Nhập câu đã sửa…';

  @override
  String get grammarSubmit => 'Gửi';

  @override
  String get grammarGrading => 'Đang chấm…';

  @override
  String get grammarCancel => 'Hủy';

  @override
  String get grammarRetry => 'Thử lại';

  @override
  String get grammarCorrectTitle => 'Chính xác';

  @override
  String get grammarIncorrectTitle => 'Chưa chính xác';

  @override
  String get grammarCorrection => 'Câu sửa';

  @override
  String get grammarTips => 'Mẹo';

  @override
  String get grammarFix => 'Sửa lại';

  @override
  String get grammarNext => 'Tiếp theo';

  @override
  String get grammarStepOf => 'Tiến độ ngữ pháp';

  @override
  String get grammarHint => 'Gợi ý';

  @override
  String get grammarShowFeedback => 'Xem lại phản hồi';

  @override
  String get grammarYourAnswer => 'Câu trả lời của bạn';

  @override
  String get grammarViewAnalysis => 'Xem phân tích AI';

  @override
  String get grammarAnalysisUnavailable =>
      'Phân tích AI chưa khả dụng trong bài luyện cục bộ này.';

  @override
  String get grammarEmptyTopicsTitle => 'Không có chủ đề ngữ pháp';

  @override
  String get grammarEmptyTopicsBody =>
      'Không có chủ đề phù hợp với lựa chọn này.';

  @override
  String get grammarEmptyLessonsTitle => 'Không có bài học ngữ pháp';

  @override
  String get grammarEmptyLessonsBody => 'Chủ đề này hiện chưa có bài học.';

  @override
  String get grammarUnavailableTitle => 'Nội dung ngữ pháp không khả dụng';

  @override
  String get grammarUnavailableBody => 'Không tìm thấy nội dung ngữ pháp này.';

  @override
  String get grammarErrorTitle => 'Không thể tải bài luyện ngữ pháp';

  @override
  String get grammarErrorBody =>
      'Hãy thử lại. Vị trí và câu trả lời của bạn sẽ được giữ nguyên.';

  @override
  String get grammarPager => 'Danh sách bài học';

  @override
  String grammarPagerPosition(int current, int total) {
    return 'Trang $current trên $total';
  }

  @override
  String get grammarMinimizeFeedback => 'Thu nhỏ phản hồi';

  @override
  String get grammarTopicsSection => 'Chủ đề';

  @override
  String grammarVisibleTopics(int count) {
    return '$count chủ đề';
  }

  @override
  String get grammarCollectionLabel => 'Bộ bài ngữ pháp';

  @override
  String get grammarCorrectionRetained => 'giữ lại';

  @override
  String get grammarCorrectionRemoved => 'bỏ đi';

  @override
  String get grammarCorrectionInserted => 'thêm vào';

  @override
  String get learningEnglish => 'English';

  @override
  String get learningKorean => 'Korean';

  @override
  String get learningChinese => 'Chinese';

  @override
  String get learningJapanese => 'Japanese';

  @override
  String get learningEnglishNative => 'English';

  @override
  String get learningKoreanNative => '한국어';

  @override
  String get learningChineseNative => '中文';

  @override
  String get learningJapaneseNative => '日本語';

  @override
  String get learningLevelA1 => 'A1 - Beginner';

  @override
  String get learningLevelA2 => 'A2 - Elementary';

  @override
  String get learningLevelB1 => 'B1 - Intermediate';

  @override
  String get learningLevelB2 => 'B2 - Upper Intermediate';

  @override
  String get learningLevelC1 => 'C1 - Advanced';

  @override
  String get learningLevelC2 => 'C2 - Proficient';

  @override
  String get learningLanguageTitle => 'Ngôn ngữ học';

  @override
  String get learningLanguageShortcut => 'Ngôn ngữ học: English';

  @override
  String get learningChooseLanguage => 'Chọn ngôn ngữ học';

  @override
  String get learningLanguageCaption =>
      'Chọn ngôn ngữ bạn muốn học. Các ngôn ngữ mới sẽ sớm được bổ sung.';

  @override
  String get learningLanguagesLabel => 'Ngôn ngữ';

  @override
  String get learningComingSoon => 'Coming soon';

  @override
  String get learningCurrentLevel => 'Trình độ hiện tại';

  @override
  String get learningConfirm => 'Xác nhận';

  @override
  String get learningLevelTitle => 'Chọn cấp độ';

  @override
  String get learningLevelIntro =>
      'Khung tham chiếu ngôn ngữ chung châu Âu (CEFR) chia trình độ thành 6 cấp, từ người mới bắt đầu đến thành thạo.';

  @override
  String get learningLevelPrompt =>
      'Hãy chọn mức độ phù hợp nhất với khả năng học ngôn ngữ của bạn.';

  @override
  String get learningLevelsLabel => 'Trình độ của bạn';

  @override
  String get learningLevelA1Description =>
      'Có thể viết lại và hoàn thành các câu rất ngắn với từ vựng quen thuộc. Phù hợp để luyện mẫu câu cơ bản và diễn đạt ý đơn giản.';

  @override
  String get learningLevelA2Description =>
      'Có thể viết và chỉnh sửa các câu đơn giản về chủ đề quen thuộc. Bắt đầu nối ý ngắn thành đoạn và giảm lỗi ngữ pháp cơ bản.';

  @override
  String get learningLevelB1Description =>
      'Có thể viết đoạn văn rõ ý về chủ đề quen thuộc, diễn đạt trải nghiệm, kế hoạch và quan điểm ngắn.';

  @override
  String get learningLevelB2Description =>
      'Có thể viết câu và đoạn văn khá tự nhiên, có cấu trúc rõ ràng, diễn đạt quan điểm và lập luận chi tiết hơn.';

  @override
  String get learningLevelC1Description =>
      'Có thể viết mạch lạc, linh hoạt theo nhiều mục đích học thuật, công việc và cá nhân.';

  @override
  String get learningLevelC2Description =>
      'Có thể viết chính xác, tinh tế và tự nhiên gần như người thành thạo. Có thể diễn đạt ý phức tạp và kiểm soát sắc thái ngôn ngữ tốt.';
}
