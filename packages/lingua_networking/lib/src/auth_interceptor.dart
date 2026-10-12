import 'package:dio/dio.dart';

typedef AccessTokenLoader = Future<String?> Function();
typedef AccessTokenRefresher = Future<String?> Function();
typedef SessionExpiredCallback = Future<void> Function();

final class AuthInterceptor extends QueuedInterceptor {
  factory AuthInterceptor({
    required Dio dio,
    required AccessTokenLoader loadAccessToken,
    required AccessTokenRefresher refreshAccessToken,
    required SessionExpiredCallback onSessionExpired,
  }) => AuthInterceptor._(
    dio,
    loadAccessToken,
    refreshAccessToken,
    onSessionExpired,
  );

  AuthInterceptor._(
    this._dio,
    this._loadAccessToken,
    this._refreshAccessToken,
    this._onSessionExpired,
  );

  static const skipAuthenticationKey = 'skipAuthentication';
  static const retryAfterRefreshKey = 'retryAfterAuthRefresh';
  static const _alreadyRetriedKey = 'authInterceptorAlreadyRetried';
  static const _authorizationHeader = 'Authorization';

  final Dio _dio;
  final AccessTokenLoader _loadAccessToken;
  final AccessTokenRefresher _refreshAccessToken;
  final SessionExpiredCallback _onSessionExpired;
  bool _sessionExpirationReported = false;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra[skipAuthenticationKey] == true) {
      handler.next(options);
      return;
    }
    final token = await _loadAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers[_authorizationHeader] = 'Bearer $token';
      _sessionExpirationReported = false;
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final request = err.requestOptions;
    if (err.response?.statusCode != 401 ||
        request.extra[skipAuthenticationKey] == true ||
        request.extra[_alreadyRetriedKey] == true ||
        !_mayReplay(request)) {
      handler.next(err);
      return;
    }

    try {
      final sentAuthorization = request.headers[_authorizationHeader];
      var token = await _loadAccessToken();
      if (token == null || sentAuthorization == 'Bearer $token') {
        token = await _refreshAccessToken();
      }
      if (token == null || token.isEmpty) {
        await _reportExpiredSession();
        handler.next(err);
        return;
      }

      final response = await _dio.fetch<Object?>(
        request.copyWith(
          headers: <String, dynamic>{
            ...request.headers,
            _authorizationHeader: 'Bearer $token',
          },
          extra: <String, dynamic>{...request.extra, _alreadyRetriedKey: true},
        ),
      );
      handler.resolve(response);
    } on Object {
      await _reportExpiredSession();
      handler.next(err);
    }
  }

  bool _mayReplay(RequestOptions request) {
    if (request.extra[retryAfterRefreshKey] == true) return true;
    return const {
      'GET',
      'HEAD',
      'OPTIONS',
    }.contains(request.method.toUpperCase());
  }

  Future<void> _reportExpiredSession() async {
    if (_sessionExpirationReported) return;
    _sessionExpirationReported = true;
    try {
      await _onSessionExpired();
    } on Object {
      // Preserve the original transport failure if session cleanup fails.
    }
  }
}
