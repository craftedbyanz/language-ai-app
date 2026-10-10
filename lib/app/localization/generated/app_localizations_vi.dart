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
    return 'Chuỗi ngày học: $count';
  }

  @override
  String get history => 'Lịch sử';

  @override
  String get menu => 'Trình đơn';

  @override
  String get settings => 'Cài đặt';

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
}
