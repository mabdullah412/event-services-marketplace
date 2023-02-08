import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../data/repositories/user_repository.dart';
import '../../logic/bloc/authentication_bloc.dart';
import '../../logic/bloc/login_bloc.dart';
import '../router/custom_page_route.dart';
import 'log_in_screen.dart';
import 'sign_up_screen.dart';

class AuthorizationScreen extends StatefulWidget {
  /// Handles the SignUp and Login functionality of the application. This screen
  /// is displayed when the user is not logged in authentication fails for some
  /// reason.

  const AuthorizationScreen({
    Key? key,
    required this.userRepository,
  }) : super(key: key);

  final UserRepository userRepository;

  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}

class _AuthorizationScreenState extends State<AuthorizationScreen> {
  UserRepository get userRepository => widget.userRepository;

  late AuthenticationBloc _authenticationBloc;
  late LoginBloc _loginBloc;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
      userRepository: userRepository,
      authenticationBloc: _authenticationBloc,
    );
    super.initState();
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Marketplace.',
                    style: Theme.of(context).primaryTextTheme.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: padding * 2),
                  Image.asset(
                    'assets/illustrations/auth_screen.png',
                    fit: BoxFit.cover,
                    scale: 3,
                  ),
                  const SizedBox(height: padding * 2),
                  Text(
                    'One stop shop for all your event planning needs. Create a package that contains your favorite services and pay everyone with just one click.',
                    style: Theme.of(context).primaryTextTheme.bodyMedium!.apply(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .bodyLarge!
                              .color,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CustomPageRoute(
                          child: BlocProvider.value(
                            value: _loginBloc,
                            child: const SignupScreen(),
                          ),
                        ),
                      );
                    },
                    child: const Text('Get Started'),
                  ),
                  const SizedBox(height: padding / 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .bodyMedium!
                            .apply(
                              fontSizeDelta: 1,
                              fontWeightDelta: 0,
                              color: Theme.of(context)
                                  .primaryTextTheme
                                  .bodyLarge!
                                  .color,
                            ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            CustomPageRoute(
                              child: BlocProvider.value(
                                value: _loginBloc,
                                child: const LoginScreen(),
                              ),
                            ),
                          );
                        },
                        child: Text(
                          'Log in',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .bodyMedium!
                              .apply(
                                color: Theme.of(context).colorScheme.primary,
                                fontSizeDelta: 1,
                                fontWeightDelta: 2,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
