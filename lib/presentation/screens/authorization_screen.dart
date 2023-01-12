import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../router/custom_page_route.dart';
import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class AuthorizationScreen extends StatelessWidget {
  const AuthorizationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Event Services Marketplace.',
                      style: Theme.of(context).primaryTextTheme.displayMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: padding),
                    Text(
                      'Lucas ipsum dolor sit amet gonk darth r2-d2 darth secura lando moff dooku amidala kenobi. Bothan fett hutt windu hutt hutt boba obi-wan droid.',
                      style: Theme.of(context).primaryTextTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: padding),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomPageRoute(
                            child: const SignInScreen(),
                          ),
                        );
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
