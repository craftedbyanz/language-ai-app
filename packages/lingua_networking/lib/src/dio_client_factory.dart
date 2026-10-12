import 'package:dio/dio.dart';

import 'network_client_config.dart';

abstract final class DioClientFactory {
  static Dio create(
    NetworkClientConfig config, {
    Iterable<Interceptor> interceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: config.baseUrl,
        connectTimeout: config.connectTimeout,
        sendTimeout: config.sendTimeout,
        receiveTimeout: config.receiveTimeout,
      ),
    );
    dio.interceptors.addAll(interceptors);
    return dio;
  }
}
