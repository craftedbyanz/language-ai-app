import 'package:flutter_test/flutter_test.dart';
import 'package:hifive/core/error/app_failure.dart';
import 'package:hifive/core/result/result.dart';

void main() {
  test('result forces explicit success and failure handling', () {
    String describe(Result<int> result) => switch (result) {
      Success(:final value) => '$value',
      Failure(:final failure) => switch (failure) {
        NetworkFailure() => 'network',
        TimeoutFailure() => 'timeout',
        UnauthorizedFailure() => 'unauthorized',
        ValidationFailure(:final code) => code ?? 'validation',
        ServerFailure(:final statusCode) => '$statusCode',
        UnknownFailure() => 'unknown',
      },
    };
    expect(describe(const Success(42)), '42');
    expect(describe(const Failure(NetworkFailure())), 'network');
    expect(describe(const Failure(TimeoutFailure())), 'timeout');
    expect(describe(const Failure(UnauthorizedFailure())), 'unauthorized');
    expect(
      describe(const Failure(ValidationFailure(code: 'invalid'))),
      'invalid',
    );
    expect(describe(const Failure(ServerFailure(statusCode: 503))), '503');
    expect(describe(const Failure(UnknownFailure())), 'unknown');
  });
}
