import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';
import '../../logic/bloc/authentication_bloc.dart';
import '../widgets/pop_header.dart';
import '../widgets/theme_button.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void logout(BuildContext context) {
    BlocProvider.of<AuthenticationBloc>(context, listen: false)
        .add(LoggedOut());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AuthenticationBloc, AuthenticationState>(
          bloc: BlocProvider.of<AuthenticationBloc>(context),
          listener: (context, authState) {
            if (authState is AuthenticationUnAuthenticated) {
              Navigator.of(context).pop();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const PopHeader(title: 'Settings'),
                const SizedBox(height: padding),
                const ThemeButton(),
                const SizedBox(height: padding),
                ElevatedButton.icon(
                  onPressed: () => logout(context),
                  icon: const Icon(PhosphorIcons.signOutBold, size: 20),
                  label: const Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
