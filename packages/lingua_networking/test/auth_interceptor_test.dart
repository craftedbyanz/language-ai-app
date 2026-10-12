import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lingua_networking/lingua_networking.dart';

void main() {
  test('refreshes once and replays a safe request', () async {
    var token = 'old-token';
    var refreshes = 0;
    var expirations = 0;
    final dio = Dio()..httpClientAdapter = _TokenAdapter();
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        loadAccessToken: () async => token,
        refreshAccessToken: () async {
          refreshes++;
          return token = 'new-token';
        },
        onSessionExpired: () async => expirations++,
      ),
    );

    final response = await dio.get<Object?>('https://example.test/profile');

    expect(response.statusCode, 200);
    expect(refreshes, 1);
    expect(expirations, 0);
    dio.close();
  });

  test('does not replay a mutation unless it explicitly opts in', () async {
    var refreshes = 0;
    final dio = Dio()..httpClientAdapter = _AlwaysUnauthorizedAdapter();
    dio.interceptors.add(
      AuthInterceptor(
        dio: dio,
        loadAccessToken: () async => 'old-token',
        refreshAccessToken: () async {
          refreshes++;
          return 'new-token';
        },
        onSessionExpired: () async {},
      ),
    );

    await expectLater(
      dio.post<Object?>('https://example.test/answer'),
      throwsA(isA<DioException>()),
    );

    expect(refreshes, 0);
    dio.close();
  });
}

final class _TokenAdapter implements HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final authorized = options.headers['Authorization'] == 'Bearer new-token';
    return ResponseBody.fromString(
      '{}',
      authorized ? 200 : 401,
      headers: {
        Headers.contentTypeHeader: ['application/json'],
      },
    );
  }
}

final class _AlwaysUnauthorizedAdapter implements HttpClientAdapter {
  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString('{}', 401);
}
