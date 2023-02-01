import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../data/repositories/user_repository.dart';
import '../logic/bloc/authentication_bloc.dart';
import 'navigation_controller.dart';
import 'screens/authorization_screen.dart';
import 'screens/loading_screen.dart';

class AuthenticationController extends StatefulWidget {
  /// Manages the authentication by limiting access to the application to
  /// registered users only.

  const AuthenticationController({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  State<AuthenticationController> createState() =>
      _AuthenticationControllerState();
}

class _AuthenticationControllerState extends State<AuthenticationController> {
  UserRepository get userRepository => widget.userRepository;

  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    // dispatch AppStarted event
    _authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _authenticationBloc,
      builder: (context, state) {
        // as long as the state is 'Authentication-Un-Initialized',
        // the SplashScreen will remain visible
        if (state is! AuthenticationUninitialized) {
          FlutterNativeSplash.remove();
        }

        if (state is AuthenticationAuthenticated) {
          return const NavigationController();
        }

        if (state is AuthenticationUnAuthenticated) {
          return AuthorizationScreen(userRepository: userRepository);
        }

        // if state is AuthenticationLoading, or edge case
        return const LoadingScreen();
      },
    );
  }
}
