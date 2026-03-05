import 'failures.dart';

sealed class Result<T> {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure f) onFailure,
  }) {
    return switch (this) {
      Success(:final data) => success(data),
      FailureResult(:final failure) => onFailure(failure),
    };
  }
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

class FailureResult<T> extends Result<T> {
  final Failure failure;
  const FailureResult(this.failure);
}
