import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/auth/bloc/auth_service.dart';
import 'package:new_project/auth/bloc/auth_state.dart';

import '../auth_preferences.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  final AuthPreferences preferences;

  AuthCubit(this.authService,this.preferences) : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    final result = authService.login(email, password);

    if (result) {
      await preferences.saveLogin(email);
      emit(AuthSuccess());
    } else {
      emit(AuthFailure('Invalid email or password'));
    }
  }

  Future<void> signup(String email, String password) async {
    emit(AuthLoading());

    final result = authService.signup(email, password);

    if (result) {
      await preferences.saveLogin(email);
      emit(AuthSuccess());
    } else {
      emit(AuthFailure('User already exists'));
    }
  }

  Future<void> checkSession() async {
    emit(AuthLoading());

    final loggedIn = await preferences.isLoggedIn();

    if (loggedIn) {
      emit(AuthSuccess());
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> logout() async {
    await preferences.logout();
    emit(AuthUnauthenticated());
  }
}
