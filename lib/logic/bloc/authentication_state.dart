part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// un-initialized ---> initial state
class AuthenticationUninitialized extends AuthenticationState {}

// authenticated ---> emitted when verified from server
class AuthenticationAuthenticated extends AuthenticationState {}

// un-authenticated ---> emitted when not verified
class AuthenticationUnAuthenticated extends AuthenticationState {}

// loading ---> emitted while verifying
class AuthenticationLoading extends AuthenticationState {}
