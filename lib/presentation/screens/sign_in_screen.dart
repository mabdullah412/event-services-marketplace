import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/pop_header.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _signinFormKey = GlobalKey<FormState>();

  final _signinEmailFocusNode = FocusNode();
  final _signinPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _signinEmailFocusNode.dispose();
    _signinPasswordFocusNode.dispose();
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
                    key: _signinFormKey,
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
                                  focusNode: _signinEmailFocusNode,
                                  textInputAction: TextInputAction.next,
                                  onSaved: (value) {},
                                  keyboardType: TextInputType.emailAddress,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(_signinPasswordFocusNode);
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
                                    _signinFormKey.currentState!.validate();
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
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Sign In'),
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
