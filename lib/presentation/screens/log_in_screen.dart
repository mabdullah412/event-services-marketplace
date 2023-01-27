import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../logic/bloc/authentication_bloc.dart';
import '../../logic/bloc/login_bloc.dart';
import '../widgets/pop_header.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  late AuthenticationBloc _authenticationBloc;
  late LoginBloc _loginBloc;

  final _signinEmailFocusNode = FocusNode();
  final _signinPasswordFocusNode = FocusNode();

  final loginData = {};

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _signinEmailFocusNode.dispose();
    _signinPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_loginFormKey.currentState!.validate()) return;
    _loginFormKey.currentState!.save();
    _loginBloc.add(LoginButtonPressed(loginData: loginData));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          // listening to AuthenticationBloc, so that when Authentication is
          // successfull, we ca pop this LoginScreen
          body: BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: _authenticationBloc,
            listener: (context, authState) {
              if (authState is AuthenticationAuthenticated) {
                Navigator.of(context).pop();
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              bloc: _loginBloc,
              builder: (context, state) {
                if (state is LoginFailure) {
                  // _onWidgetDidBuild displays snackbar after
                  // Build() has finished building
                  _onWidgetDidBuild(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Error Occured'),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(milliseconds: 1500),
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 20,
                          bottom: 20,
                        ),
                      ),
                    );
                  });
                }

                return Container(
                  padding: const EdgeInsets.all(padding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const PopHeader(title: 'Sign In'),
                      const SizedBox(height: padding),
                      Text(
                        'Let\'s sign you in.',
                        style: Theme.of(context).primaryTextTheme.displayLarge,
                      ),
                      const SizedBox(height: padding / 2),
                      Text(
                        'Welcome back.',
                        style: Theme.of(context).primaryTextTheme.labelMedium,
                      ),
                      const SizedBox(height: padding / 2),
                      Text(
                        'You\'ve been missed.',
                        style: Theme.of(context).primaryTextTheme.labelMedium,
                      ),
                      const SizedBox(height: padding),
                      Expanded(
                        child: Form(
                          key: _loginFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  keyboardDismissBehavior:
                                      ScrollViewKeyboardDismissBehavior.onDrag,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: padding),
                                      TextFormField(
                                        focusNode: _signinEmailFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (value) {
                                          loginData['email'] = value!;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(
                                              _signinPasswordFocusNode);
                                        },
                                        decoration: const InputDecoration(
                                          label: Text('Email'),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Email cannot be empty.';
                                          } else if (!value.contains('@')) {
                                            return 'Please enter a valid email';
                                          } else if (!value.contains('.com')) {
                                            return 'Please enter a valid email';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: padding),
                                      TextFormField(
                                        focusNode: _signinPasswordFocusNode,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (value) {
                                          _loginFormKey.currentState!
                                              .validate();
                                        },
                                        onSaved: (value) {
                                          loginData['password'] = value!;
                                        },
                                        obscureText: true,
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password cannot be empty.';
                                          } else if (value.length < 6) {
                                            return 'Password must contain atleast 6 characters.';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          label: Text('Password'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: state is LoginLoading ? null : login,
                                child: state is LoginLoading
                                    ? const CircularProgressIndicator()
                                    : const Text('Log In'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _onWidgetDidBuild(VoidCallback callback) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callback();
    });
  }
}
