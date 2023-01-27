import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/constants.dart';
import '../../logic/bloc/authentication_bloc.dart';
import '../../logic/bloc/login_bloc.dart';
import '../widgets/custom_snack_bar.dart';
import '../widgets/pop_header.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _signupFormKey = GlobalKey<FormState>();
  late AuthenticationBloc _authenticationBloc;
  late LoginBloc _loginBloc;

  final _signupNameFocusNode = FocusNode();
  final _signupEmailFocusNode = FocusNode();
  final _signupPasswordFocusNode = FocusNode();
  final _signupConfirmPasswordFocusNode = FocusNode();

  final signupData = {};

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    _signupNameFocusNode.dispose();
    _signupEmailFocusNode.dispose();
    _signupPasswordFocusNode.dispose();
    _signupConfirmPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> signup() async {
    if (!_signupFormKey.currentState!.validate()) return;
    _signupFormKey.currentState!.save();
    _loginBloc.add(SignupButtonPressed(signupData: signupData));
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
                      SnackBar(
                        action: SnackBarAction(
                          label: 'close',
                          onPressed: () {},
                        ),
                        content: const CustomSnackbar(
                          snackbarType: SnackbarType.error,
                          title: 'Error.',
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
                      const PopHeader(title: 'Sign Up'),
                      const SizedBox(height: padding),
                      Text(
                        'Let\'s register you.',
                        style: Theme.of(context).primaryTextTheme.displayLarge,
                      ),
                      const SizedBox(height: padding / 2),
                      Text(
                        'Enter details to.',
                        style: Theme.of(context).primaryTextTheme.labelMedium,
                      ),
                      const SizedBox(height: padding / 2),
                      Text(
                        'Buy and Sell Services.',
                        style: Theme.of(context).primaryTextTheme.labelMedium,
                      ),
                      const SizedBox(height: padding),
                      Expanded(
                        child: Form(
                          key: _signupFormKey,
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
                                        focusNode: _signupNameFocusNode,
                                        textInputAction: TextInputAction.next,
                                        textCapitalization:
                                            TextCapitalization.words,
                                        onSaved: (value) {
                                          signupData['name'] = value!;
                                        },
                                        keyboardType: TextInputType.name,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(
                                              _signupEmailFocusNode);
                                        },
                                        decoration: const InputDecoration(
                                          label: Text('Name'),
                                        ),
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Name cannot be empty.';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: padding),
                                      TextFormField(
                                        focusNode: _signupEmailFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (value) {
                                          signupData['email'] = value!;
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(
                                              _signupPasswordFocusNode);
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
                                        focusNode: _signupPasswordFocusNode,
                                        textInputAction: TextInputAction.next,
                                        onSaved: (value) {
                                          signupData['password'] = value!;
                                        },
                                        onFieldSubmitted: (value) {
                                          FocusScope.of(context).requestFocus(
                                              _signupConfirmPasswordFocusNode);
                                        },
                                        obscureText: true,
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password cannot be empty.';
                                          } else if (value.length < 5) {
                                            return 'Password must contain atleast 5 characters.';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          label: Text('Password'),
                                        ),
                                      ),
                                      const SizedBox(height: padding),
                                      TextFormField(
                                        focusNode:
                                            _signupConfirmPasswordFocusNode,
                                        textInputAction: TextInputAction.done,
                                        onSaved: (value) {
                                          signupData['passwordConfirm'] =
                                              value!;
                                        },
                                        onFieldSubmitted: (value) {
                                          _signupFormKey.currentState!
                                              .validate();
                                        },
                                        obscureText: true,
                                        autocorrect: false,
                                        enableSuggestions: false,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Password cannot be empty.';
                                          } else if (value.length < 5) {
                                            return 'Password must contain atleast 5 characters.';
                                          } else {
                                            return null;
                                          }
                                        },
                                        decoration: const InputDecoration(
                                          label: Text('Confirm Password'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed:
                                    state is LoginLoading ? null : signup,
                                child: state is LoginLoading
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 2,
                                      )
                                    : const Text('Sign Up'),
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
