part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final Map<dynamic, dynamic> loginData;

  const LoginButtonPressed({required this.loginData});

  @override
  List<Object> get props => [];
}

class SignupButtonPressed extends LoginEvent {
  final Map<dynamic, dynamic> signupData;

  const SignupButtonPressed({required this.signupData});

  @override
  List<Object> get props => [];
}
