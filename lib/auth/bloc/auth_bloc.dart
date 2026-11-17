// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'auth_service.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';
//
// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthService authService;
//
//   AuthBloc(this.authService) : super(AuthInitial()) {
//     on<LoginEvent>((event, emit) {
//       // emit(AuthLoading());
//       final result = authService.login(event.email, event.password);
//
//       if (result) {
//         // emit(AuthSuccess());
//         emit(AuthFailure('Invalid Credentials'));
//       }
//     });
//
//     on<SignupEvent>((event, emit) {
//       emit(AuthLoading());
//
//       final result = authService.signup(event.email, event.password);
//       if (result) {
//         // emit(AuthSuccess());
//       } else {
//         emit(AuthFailure('User already exists'));
//       }
//     });
//     on<LogoutEvent>((event, emit) {
//       emit(AuthInitial());
//     });
//   }
// }
