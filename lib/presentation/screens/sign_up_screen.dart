import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/pop_header.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _signupFormKey = GlobalKey<FormState>();

  final _signupNameFocusNode = FocusNode();
  final _signupEmailFocusNode = FocusNode();
  final _signupPasswordFocusNode = FocusNode();
  final _signupConfirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _signupNameFocusNode.dispose();
    _signupEmailFocusNode.dispose();
    _signupPasswordFocusNode.dispose();
    _signupConfirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Container(
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  focusNode: _signupNameFocusNode,
                                  textInputAction: TextInputAction.next,
                                  textCapitalization: TextCapitalization.words,
                                  onSaved: (value) {},
                                  keyboardType: TextInputType.name,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_signupEmailFocusNode);
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
                                  onSaved: (value) {},
                                  keyboardType: TextInputType.emailAddress,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_signupPasswordFocusNode);
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
                                  focusNode: _signupConfirmPasswordFocusNode,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (value) {
                                    _signupFormKey.currentState!.validate();
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
                          onPressed: () {},
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
