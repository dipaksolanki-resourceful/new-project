import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_service.dart';
import 'auth_state.dart';
import '../repository/auth_repository.dart';
import '../auth_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  final AuthPreferences preferences;
  final AuthRepository authRepository;

  AuthCubit(this.authService, this.preferences, this.authRepository)
    : super(const AuthState());

  // LOGIN
  Future<void> login(dynamic data) async {
    emit(
      state.copyWith(
        status: ApiStatus.loading,
        operation: AuthOperation.login,
        message: '',
      ),
    );

    try {
      final result = await authRepository.loginUser(data: data);

      if (result) {
        await preferences.saveLogin(data['email']);

        emit(
          state.copyWith(
            status: ApiStatus.success,
            operation: AuthOperation.login,
            authStatus: AuthenticationStatus.authenticated,
            message: 'Login successful',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            operation: AuthOperation.login,
            message: 'Invalid email or password',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ApiStatus.failure,
          operation: AuthOperation.login,
          message: e.toString(),
        ),
      );
    }
  }

  // SIGNUP
  Future<void> signup(Map<String, dynamic> data) async {
    emit(
      state.copyWith(
        status: ApiStatus.loading,
        operation: AuthOperation.signup,
        message: '',
      ),
    );

    try {
      final response = await authRepository.createUser(data: data);

      emit(
        state.copyWith(
          status: ApiStatus.success,
          operation: AuthOperation.signup,
          data: response,
          message: 'Signup successful',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ApiStatus.failure,
          operation: AuthOperation.signup,
          message: e.toString(),
        ),
      );
    }
  }

  // CHECK SESSION
  Future<void> checkSession() async {
    emit(
      state.copyWith(
        status: ApiStatus.loading,
        operation: AuthOperation.checkAuth,
      ),
    );

    try {
      final loggedIn = await preferences.isLoggedIn();

      if (loggedIn) {
        emit(
          state.copyWith(
            status: ApiStatus.success,
            operation: AuthOperation.checkAuth,
            authStatus: AuthenticationStatus.authenticated,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: ApiStatus.success,
            operation: AuthOperation.checkAuth,
            authStatus: AuthenticationStatus.unauthenticated,
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ApiStatus.failure,
          operation: AuthOperation.checkAuth,
          message: e.toString(),
        ),
      );
    }
  }

  // LOGOUT
  Future<void> logout() async {
    try {
      emit(
        state.copyWith(
          status: ApiStatus.loading,
          operation: AuthOperation.logout,
        ),
      );
      final result = await authRepository.logoutUser();
      await preferences.logout();

      emit(
        state.copyWith(
          status: ApiStatus.success,
          operation: AuthOperation.logout,
          authStatus: AuthenticationStatus.unauthenticated,
          message: 'Logout successful',
          data: result,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ApiStatus.failure,
          operation: AuthOperation.logout,
          message: e.toString(),
        ),
      );
    }
  }
}
