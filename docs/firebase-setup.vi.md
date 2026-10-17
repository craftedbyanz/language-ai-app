# Setup Firebase cho HiFive

Hướng dẫn ngày 18/10/2026. Đây là lộ trình tích hợp; phần bootstrap Firebase dev
đã được triển khai theo tiến độ bên dưới. Chưa triển khai backend, màn hình auth
hoặc thay dữ liệu mẫu trong app.
Các tên project và endpoint bên dưới là ví dụ, không phải tài nguyên đã tồn tại.

Project dev do người dùng cung cấp: `hifive-dev-8189c`. Dùng ID này thay
`YOUR_DEV_PROJECT_ID` trong các lệnh bên dưới. Việc có Project ID chưa xác nhận
CLI đã được cấp quyền, Authentication đã bật hoặc database đã được tạo.

Tiến độ trên máy ngày 18/10/2026:

- Đã cài Firebase CLI `15.34.0` và FlutterFire CLI `1.4.1`.
- `firebase --version` chạy thành công. Dependency cài đặt cảnh báo Node v25;
  nếu gặp lỗi tương thích tiếp theo, dùng Node LTS phù hợp.
- Đã xác nhận CLI đăng nhập và có quyền truy cập `hifive-dev-8189c`.
- Đã thêm `firebase_core` 5.0.0, `firebase_auth` 7.0.0 và sinh options cho
  Android, iOS, macOS, web. Hai nền tảng Apple dùng chung Firebase Apple app
  do cùng bundle ID hiện tại.
- Đã chuẩn hóa thương hiệu theo yêu cầu: Flutter package `hifive`, widget gốc
  `HiFiveApp`, application/bundle ID `com.anznguyen.hifive`. Các package thư viện
  nội bộ `lingua_*` giữ tên kỹ thuật hiện tại, không phải tên app hiển thị.
- Firebase dùng `HiFive Android (Dev)`, `HiFive Apple (Dev)` và
  `HiFive Web (Dev)`. Đã đăng ký lại Android/Apple app theo ID mới và sinh lại
  toàn bộ cấu hình bằng FlutterFire. Web giữ app ID hiện có và đổi nickname.
- Hai đăng ký native với ID cũ được đổi nickname thành `HiFive Android (Legacy ID)`
  và `HiFive Apple (Legacy ID)`; client không dùng chúng nữa. Chưa xóa các đăng ký
  cũ hoặc dữ liệu cloud. Project, Auth provider và database không đổi theo rename.
- `google-services.json` được Firebase sinh có thể chứa cả client Android legacy
  của cùng project. Không sửa tay file này: Gradle chọn client khớp application ID
  mới; đã xác minh resource `google_app_id` dùng Firebase Android app mới.
- Dev bootstrap khởi tạo named app `hifive-development` và inject qua Riverpod.
  Staging/production vẫn là local preview, không được cấp Firebase provider.
- Đã thêm quyền mạng và Keychain Sharing cho macOS; native config hiện chỉ dành
  cho dev, chưa tách resources theo môi trường phát hành.
- Đã kiểm tra Firebase Console: provider Email/Password có trạng thái Enabled.
- Lần kiểm tra Firestore đầu tiên bị từ chối vì API chưa bật. Người dùng đang
  được hướng dẫn tạo database theo bước 4; chưa xác nhận database đã tạo.
- Chưa có màn hình auth, repository hồ sơ hoặc endpoint backend.

Chạy bản dev đã tích hợp:

```sh
fvm flutter run -t lib/main_dev.dart -d macos
```

Mặc định `lib/main.dart` trỏ production/local preview, không bật Firebase dev.
Quyết định hạ tầng được ghi tại [ADR-0009](adr/0009-firebase-development-bootstrap.md).

Kiểm tra client sau tích hợp:

- Format và static analysis: đạt.
- `tool/check_architecture.dart`: đạt.
- `fvm flutter test --no-pub`: 116 tests đạt.
- Build web dev release: đạt. Có cảnh báo font Cupertino từ UI hiện tại.
- Build Android dev debug (`android-arm64`): đạt, APK tại
  `build/app/outputs/flutter-apk/app-debug.apk`. Gradle đã cài Android SDK Platform
  34 cần cho plugin. Có cảnh báo Firebase plugins còn dùng Kotlin Gradle Plugin
  thay Built-in Kotlin; build hiện tại thành công, cần kiểm tra khi nâng SDK/plugin.
- Sau đổi thương hiệu, đã chạy lại 116 tests, analysis và architecture checks.
  Build lại APK và đọc manifest trong artifact: package `com.anznguyen.hifive`,
  application label `HiFive`, launcher `com.anznguyen.hifive.MainActivity`.
  Firebase Management API xác nhận các nickname HiFive và native IDs mới.
  Build web dev release sau đổi tên cũng đạt.
- Integration test macOS: chưa chạy được test; đã dừng sau hơn 6 phút còn tải
  repository Firebase SDK qua Swift Package Manager, chưa tới biên dịch/chạy app.
  Không coi mã thoát sau khi ngắt tiến trình là test pass. Chạy lại khi tải xong
  dependency và kiểm tra signing/Keychain trên máy.
- Chưa xác minh runtime Android, iPhone hoặc iPad.

## 1. Phân chia trách nhiệm

Đề xuất phù hợp với `AGENTS.md` và ADR-0004:

```text
Flutter → Firebase Authentication
Flutter → Repository → HTTP adapter → OpenAPI client
                                      ↓ Bearer Firebase ID token
                             Backend riêng → Firestore
                                           → Dịch vụ AI
```

- Firebase Authentication: đăng ký, đăng nhập, khôi phục mật khẩu, phiên người dùng.
- Cloud Firestore: dữ liệu người dùng, nội dung học, kết quả và tiến độ trên server.
- Backend riêng: xác thực token, phân quyền, chấm bài, điểm, hoàn thành bài,
  SRS và entitlement. README hiện định hướng backend Go; có thể dùng Go trên
  Cloud Run với Firebase Admin SDK. Không cần đổi sang TypeScript để dùng Firebase.
- Storage: chỉ bật khi có yêu cầu upload/audio/avatar cụ thể.
- Thiết lập ngôn ngữ/thiết bị hiện tại tiếp tục dùng cơ chế preferences của app.

Ở giai đoạn đầu, app chỉ cần `firebase_core` và `firebase_auth`. Chưa cần
`cloud_firestore`: backend truy cập database qua Admin SDK. Nếu sau này cần
realtime trực tiếp cho một tính năng cụ thể, ghi ADR và thiết kế rules tương ứng.
Đường truy cập database trực tiếp cũng phải qua adapter/repository.

Firebase không tự cung cấp logic chấm bài hoặc conversation AI. Những phần này
vẫn cần triển khai server. Mô hình này dùng Firebase cho hạ tầng và giữ nguyên
ranh giới client/backend của dự án.

## 2. Tạo project dev

1. Mở [Firebase Console](https://console.firebase.google.com/), tạo project dev.
2. Dùng tên hiển thị như `HiFive Dev`; ghi lại **Project ID** thực tế.
   Project ID phải duy nhất, không mặc định có sẵn `hifive-dev`.
3. Có thể chưa bật Google Analytics cho mốc Auth đầu tiên.
4. Tạo production project riêng trước khi phát hành; staging thêm khi cần.
5. Auth/Firestore có hạn mức miễn phí. Trước khi triển khai Cloud Run/Functions,
   kiểm tra billing và bật gói/tài khoản thanh toán phù hợp.
   Budget alerts chỉ cảnh báo, không phải giới hạn cứng tự ngắt chi phí.

Máy hiện tại có FVM và Node; Firebase CLI và FlutterFire CLI đã được cài ở mốc
tiến độ trên. FlutterFire nằm trong Dart pub cache, cần PATH như bước 5.
Không cần thay SDK Flutter đã pin.

Tài liệu: [pricing plans](https://firebase.google.com/docs/projects/billing/firebase-pricing-plans),
[budget alerts](https://firebase.google.com/docs/projects/billing/budget-alerts).

## 3. Bật Authentication

1. Trong project dev, vào **Authentication → Get started**.
2. Trong phương thức đăng nhập, bật **Email/Password** trước.
3. Dùng email thử nghiệm do bạn kiểm soát; không dùng tài khoản production để test.
4. Chốt luồng đăng ký, đăng nhập, xác minh email, quên mật khẩu và đăng xuất.
5. Khi cần Google/Apple sign-in, bổ sung cấu hình nhà cung cấp và từng nền tảng;
   không coi việc bật provider trong Console là đã xong tích hợp native.

Tài liệu: [Firebase Auth cho Flutter](https://firebase.google.com/docs/auth/flutter/start).

## 4. Tạo database

1. Vào **Firestore Database → Create database**.
2. Chọn Standard edition nếu Console yêu cầu edition; dùng database `(default)`.
3. Chọn **Production mode**.
4. Với nhóm người dùng đầu tiên ở Việt Nam, đề xuất `asia-southeast1` (Singapore).
   Chọn theo vị trí người dùng, yêu cầu dữ liệu và backend; không thể đổi location
   của database đã tạo. Đặt backend gần database.
5. Với kiến trúc backend truy cập database, giữ rules chặn toàn bộ mobile/web:

```text
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

Admin SDK phía server không chịu các rules này: backend phải tự phân quyền
theo UID đã xác minh, và service account phải có IAM tối thiểu cần thiết.
Không mở `allow read, write: if true` để chữa lỗi kết nối.

Tài liệu: [locations](https://firebase.google.com/docs/firestore/locations),
[Security Rules và server SDK](https://firebase.google.com/docs/firestore/security/rules-conditions).

## 5. Cài công cụ và liên kết Flutter với project dev

Chạy tại thư mục gốc repo, lần lượt từng lệnh:

```sh
fvm install
fvm flutter pub get
npm install -g firebase-tools
firebase login
firebase projects:list
fvm dart pub global activate flutterfire_cli
```

Để FlutterFire tìm đúng Flutter của FVM và executable Dart global trong terminal
hiện tại:

```sh
export PATH="$PWD/.fvm/flutter_sdk/bin:$HOME/.pub-cache/bin:$PATH"
firebase --version
flutterfire --version
```

Nếu máy đã tùy chỉnh `PUB_CACHE`, thay đường dẫn cache bằng đường dẫn thực tế.
`firebase login` yêu cầu bạn đăng nhập Google trong trình duyệt.

Thêm hai SDK cần thiết: Flutter/Dart hiện không cung cấp API Firebase; SDK chính
thức phụ trách kết nối native và vòng đời auth trên các nền tảng mục tiêu.
Kiểm tra phiên bản giải được với FVM pin và thay đổi native trước khi tiếp tục.

```sh
fvm flutter pub add firebase_core firebase_auth
```

Thay `YOUR_DEV_PROJECT_ID` bằng Project ID thật rồi chạy:

```sh
flutterfire configure --project=YOUR_DEV_PROJECT_ID --platforms=android,ios,macos --out=lib/core/firebase/firebase_options_dev.dart
```

Nếu tiếp tục hỗ trợ web như repo hiện có, thêm `web` vào `--platforms`.
iPhone/iPad dùng chung app iOS. Các native app hiện dùng ID
`com.anznguyen.hifive`; xác nhận CLI liên kết đúng các ID này. Không tự đổi ID.

CLI sinh options và có thể cập nhật cấu hình native. Review diff; không sửa tay
file generated. Đây mới chỉ là cấu hình dev; chưa chạy production bằng options dev.
Tài liệu: [Firebase CLI](https://firebase.google.com/docs/cli),
[Flutter setup](https://firebase.google.com/docs/flutter/setup).

Trên máy này, FlutterFire ban đầu gặp `cannot load such file -- xcodeproj` vì
chọn Ruby hệ thống. Đã chạy lại thành công bằng Ruby và gems sẵn có của Homebrew
CocoaPods, không cần cài thêm gem vào Ruby hệ thống. Khi tái sinh trên máy này,
thêm vào PATH Ruby Homebrew và đặt `GEM_HOME` tương ứng bản CocoaPods đang cài;
không hardcode đường dẫn phiên bản của máy này vào script dùng chung.

## 6. Tích hợp bootstrap và môi trường

Các điểm tích hợp (đã làm phần khởi tạo dev; backend URL còn chờ hợp đồng):

- `lib/app/bootstrap/bootstrap.dart`: sau `WidgetsFlutterBinding.ensureInitialized()`
  và trước khi dùng Firebase, gọi `Firebase.initializeApp` với options đúng môi trường.
- `lib/core/firebase/`: đặt options được sinh và adapter hạ tầng; không đặt code
  Firebase vào domain hoặc design system.
- `lib/core/config/app_config.dart`: thêm URL backend được kiểm tra hợp lệ khi
  bật backend thật; không hardcode URL giả.
- `lib/app/bootstrap/app_providers.dart`: lắp ráp dependencies qua Riverpod.

Mẫu vị trí khởi tạo cho **dev** (chưa phải patch có thể dùng cho mọi entrypoint):

```dart
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

Import `firebase_core` và file `firebase_options_dev.dart` đã được CLI sinh.
Bootstrap dùng chung hiện gọi `initializeFirebase(environment)`: dev chọn options
dev, các môi trường khác chưa cấu hình không khởi tạo SDK từ Dart. Truy cập provider
ở root không được inject sẽ báo lỗi rõ ràng; không fallback ngầm sang dev.
Khi bật tính năng Firebase cho staging/prod, phải thêm options và chọn native
resources tương ứng trước. Widget tests không gọi native Firebase.

Hiện ba entrypoint chỉ là môi trường Dart, chưa có native flavors, cùng bundle ID
và không cài song song. Khi thêm project môi trường khác, cần kiểm tra cả native
configuration theo build configuration/flavor, không chỉ chọn file Dart options.
Không chạy cấu hình các project liên tiếp rồi mặc định file native cuối cùng
sẽ hoạt động đúng cho mọi môi trường.

macOS: mở `macos/Runner.xcworkspace`, Runner → Signing & Capabilities:

- Thêm **Keychain Sharing** theo tài liệu Firebase.
- Bật **Outgoing Connections (Client)** cho Debug/Profile và Release. Hiện cả
  hai file entitlements chưa có `com.apple.security.network.client`.
- Chọn signing phù hợp với máy của bạn; không đưa khóa ký vào repo.

Tài liệu: [Flutter setup](https://firebase.google.com/docs/flutter/setup).

## 7. Nối auth đúng với code hiện có

`packages/lingua_auth` hiện có `AuthGateway`/`AuthSessionManager` dành cho backend
tự cấp access token và refresh token. Không ép Firebase vào hợp đồng này bằng
refresh token giả hoặc ghi Firebase refresh token vào SharedPreferences.

Trước thay đổi hợp đồng auth dùng chung, viết ADR giải thích Firebase SDK quản lý
phiên và token; giữ pure Dart boundary và cập nhật tests/call sites liên quan.

Luồng đề xuất:

1. Adapter Firebase Auth gọi đăng ký/đăng nhập/đăng xuất.
2. Chuyển user của SDK thành model session thuần Dart chỉ chứa thông tin cần dùng.
3. Riverpod theo dõi stream auth; trạng thái loading/signed-out/signed-in/error rõ ràng.
4. ViewModel và UI đăng nhập dùng localization và design-system tokens hiện có.
5. Typed router xử lý trạng thái đang khôi phục phiên, chưa đăng nhập và đã đăng nhập.
6. Khi gọi API, lấy ID token hiện tại bằng `currentUser?.getIdToken()`.
7. `AuthInterceptor` hiện có nhận callback: nối load token vào API trên,
   refresh vào `getIdToken(true)`. Không log token, mật khẩu hoặc nội dung nhạy cảm.
8. Phân biệt lỗi mạng tạm thời với phiên bị vô hiệu trước khi quyết định sign-out.
   Callback cleanup không được biến mọi lỗi transport thành mất phiên.

SDK quản lý persistence/refresh phiên. Không triển khai thêm một token store song
song. Mutation như gửi đáp án, gửi tin nhắn không tự replay sau 401; interceptor
hiện mặc định chỉ replay GET/HEAD/OPTIONS. Giữ hành vi đó.

## 8. Xây backend trong repository riêng

Mốc đầu tiên chỉ cần một luồng Auth → hồ sơ:

1. Khởi tạo backend riêng, kết nối Firebase Admin SDK bằng credentials của môi
   trường server. Khi deploy Google Cloud, ưu tiên service identity/ADC.
2. Middleware nhận `Authorization: Bearer <Firebase ID token>` và verify bằng
   Admin SDK. Dùng UID đã xác minh; không tin UID do body/query gửi lên.
3. Định nghĩa OpenAPI cho endpoint hồ sơ, ví dụ `GET /v1/me` và
   `PUT /v1/me/profile` với semantics idempotent và các field được phép sửa.
4. Chỉ backend tạo timestamps và cập nhật trường server-owned; profile update
   không được cho phép ghi điểm, entitlement hay role.
5. Tạo/lấy hồ sơ theo UID; không dùng email làm document ID.
6. Sinh Dart API vào `lib/generated/api/`, không viết client giả bằng tay.
7. Repository profile gọi service adapter/generated client, ViewModel gọi repository.

Schema khởi đầu để thảo luận, chưa phải schema đã deploy:

```text
users/{uid}                       hồ sơ; chỉ server ghi
users/{uid}/progress/{lessonId}    tiến độ do server tính
users/{uid}/attempts/{attemptId}   lần nộp và kết quả do server lưu
lessons/{lessonId}                nội dung được xuất bản cho client
lessonAnswerKeys/{lessonId}       đáp án/rubric chỉ server được đọc
```

Không gửi đáp án nội bộ/rubric bí mật trong payload bài tập. Trước feature AI,
thêm giới hạn sử dụng phía server, quản lý secret phía server và hợp đồng kết quả
ngữ nghĩa; client không giữ API key dịch vụ AI.

Tài liệu: [verify ID tokens](https://firebase.google.com/docs/auth/admin/verify-id-tokens).

## 9. Thay dữ liệu mẫu theo từng feature

Thứ tự đề xuất: Auth + profile → Grammar → Writing → Flashcards/SRS → Insights.

- Grammar: `lib/features/grammar/presentation/providers/grammar_providers.dart`.
- Writing: `lib/features/writing/presentation/view_models/writing_exercise_view_model.dart`.
- Flashcards: `lib/features/flashcards/presentation/flashcard_providers.dart`.
- Insights: `lib/features/insights/presentation/insight_providers.dart`.

Grammar/Writing catalog hiện có getters đồng bộ. Cần đổi hợp đồng tải qua
Future/stream và thêm loading/error/empty state, không chỉ thay constructor
InMemory bằng HTTP repository. Writing topic picker còn tự giữ
`InMemoryWritingRepository`; đưa về provider khi chuyển feature này.
Lưu ý các đường đọc nội dung bên ngoài provider để không còn dữ liệu mẫu xen kẽ.

Giữ fake/in-memory cho test/demo được chọn rõ ràng. Khi bật backend production,
không fallback về chấm điểm local nếu server lỗi. Chỉ đưa một feature sang server
sau khi hợp đồng và test tương ứng sẵn sàng.

## 10. Chạy và xác minh

Trong backend repo, quản lý `firebase.json`, Firestore rules/indexes và emulator
configuration cùng với backend. Khởi tạo emulator Auth/Firestore ở repo đó:

```sh
firebase init emulators
firebase emulators:start --only auth,firestore --project YOUR_DEV_PROJECT_ID
```

Emulator không thay thế backend HTTP local: khởi động backend riêng, kết nối nó
với Auth/Firestore emulators theo cấu hình server, và trỏ Flutter API base URL
về backend local. Nếu bật Functions/Storage sau này, thêm emulator tương ứng.

Trong Flutter dev bootstrap, trước auth operation đầu tiên, dùng
`useAuthEmulator(host, 9099)`. Chỉ bật qua cấu hình dev rõ ràng. Android Emulator
thường dùng `10.0.2.2`; iOS simulator/macOS dùng `127.0.0.1`; thiết bị thật dùng
IP LAN của máy và cần cấu hình kết nối local phù hợp. Không đưa chế độ emulator
vào production. Vì client chưa đọc Firestore trực tiếp, chưa cần Firestore SDK
hoặc `useFirestoreEmulator` trong app.

Kiểm thử mốc Auth + profile:

- Đăng ký → đăng nhập → gọi API profile thành công.
- Tắt/mở app vẫn khôi phục đúng phiên; đăng xuất xóa state/cache theo người dùng.
- Tài khoản A không đọc/sửa được hồ sơ B; token thiếu/sai bị từ chối.
- Timeout không tự tạo lại mutation; lỗi mạng không gây logout vô cớ.
- Kiểm tra Android, iPhone, iPad và macOS; kiểm tra web nếu tiếp tục hỗ trợ.

Sau mỗi thay đổi client:

```sh
fvm dart format lib packages test
fvm flutter analyze
fvm dart run tool/check_architecture.dart
fvm flutter test
git diff --check
```

Khi thêm routes/localization/API, chạy generator tương ứng trước kiểm tra.
Không chạy thay đổi golden hàng loạt để che regression. Sau test, smoke-build các
nền tảng bị ảnh hưởng và chạy integration test luồng auth/profile trên emulator.

Tài liệu: [Emulator Suite](https://firebase.google.com/docs/emulator-suite/install_and_configure).

## Đầu vào còn thiếu để tích hợp thật

- Project ID dev và native apps được đăng ký đúng bundle/application ID.
- Provider Auth đầu tiên (đề xuất Email/Password).
- Repository backend riêng, OpenAPI contract và URL backend dev.
- Quyết định/ADR auth Firebase thay hợp đồng refresh-token hiện tại.

Không cần gửi mật khẩu, service-account JSON, refresh token hoặc private key vào
chat. Chưa có các đầu vào trên thì không thể khẳng định app đã kết nối Firebase.
