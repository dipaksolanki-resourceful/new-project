import 'package:equatable/equatable.dart';

enum ApiStatus { initial, loading, success, failure }

enum AuthOperation { none, login, signup, checkAuth, logout }

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthState extends Equatable {
  final ApiStatus status;
  final AuthOperation operation;
  final AuthenticationStatus authStatus;
  final dynamic data;
  final String message;

  const AuthState({
    this.status = ApiStatus.initial,
    this.operation = AuthOperation.none,
    this.authStatus = AuthenticationStatus.unknown,
    this.data,
    this.message = '',
  });

  AuthState copyWith({
    ApiStatus? status,
    AuthOperation? operation,
    AuthenticationStatus? authStatus,
    dynamic data,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      authStatus: authStatus ?? this.authStatus,
      data: data ?? this.data,
      operation: operation ?? this.operation,
      message: message ?? this.message,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    status,
    operation,
    authStatus,
    data,
    message
  ];
}
