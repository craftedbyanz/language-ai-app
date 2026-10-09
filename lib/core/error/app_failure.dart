sealed class AppFailure {
  const AppFailure();
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure();
}

final class TimeoutFailure extends AppFailure {
  const TimeoutFailure();
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure();
}

/// A backend-owned semantic code, not a message or sensitive field value.
final class ValidationFailure extends AppFailure {
  const ValidationFailure({this.code});
  final String? code;
}

final class ServerFailure extends AppFailure {
  const ServerFailure({this.statusCode});
  final int? statusCode;
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure();
}
