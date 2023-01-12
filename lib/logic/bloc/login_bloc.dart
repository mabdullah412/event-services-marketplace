import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/user_repository.dart';
import 'authentication_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    required this.userRepository,
    required this.authenticationBloc,
  }) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
    on<SignupButtonPressed>(_onSignupButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final Response response = await userRepository.loginAndAuthenticate(
        loginData: event.loginData,
      );

      // dispatch LoggedIn so that authenticationBloc persists
      // required data and emits Authenticated() state
      authenticationBloc.add(LoggedIn(userData: response.data));

      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }

  Future<void> _onSignupButtonPressed(
    SignupButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final Response response = await userRepository.signupAndAuthenticate(
        signupData: event.signupData,
      );

      // dispatch LoggedIn so that authenticationBloc persists
      // required data and emits Authenticated() state
      authenticationBloc.add(LoggedIn(userData: response.data));

      emit(LoginInitial());
    } catch (error) {
      emit(LoginFailure(error: error.toString()));
    }
  }
}
