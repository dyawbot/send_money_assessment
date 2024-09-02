import 'package:equatable/equatable.dart';

enum Status {
  success,
  error,
  loading,
  initial,
  saved,
}

enum ErrorType {
  noInternet,
  serverDown,
  serverNotSupported,
  generic,
  connectionFailed,
  invalidData,
  nullData,
}

class ApiResult<T> extends Equatable {
  final Status status;
  final T? data;
  final String? message;
  final ErrorType? errorType;

  const ApiResult._({
    required this.status,
    this.data,
    this.message,
    this.errorType,
  });

  const ApiResult.success(
    this.data, {
    this.message,
    this.status = Status.success,
    this.errorType,
  });

  const ApiResult.error(
    this.message, {
    this.errorType = ErrorType.generic,
    this.data,
    this.status = Status.error,
  });

  const ApiResult.loading(
      {this.status = Status.loading, this.data, this.errorType, this.message});
  const ApiResult.connectionFailed(
      {this.data,
      this.status = Status.error,
      this.message = "Connection Failed",
      this.errorType = ErrorType.connectionFailed});

  const ApiResult.noInternetConnection(
      {this.data,
      this.message = "No Internet Connection",
      this.status = Status.error,
      this.errorType = ErrorType.noInternet});
  @override
  // TODO: implement props
  List<Object?> get props => [status, data, message, errorType];
}
