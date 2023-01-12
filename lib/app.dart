import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/repositories/user_repository.dart';
import 'logic/bloc/authentication_bloc.dart';
import 'logic/providers/theme_provider.dart';
import 'presentation/navigation_controller.dart';
import 'presentation/themes.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.userRepository,
  });

  final UserRepository userRepository;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  UserRepository get userRepository => widget.userRepository;

  late AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    _authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    super.initState();
  }

  @override
  void dispose() {
    _authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => _authenticationBloc,
        ),
      ],
      child: ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Event Planner',
            themeMode: Provider.of<ThemeProvider>(context).themeMode,
            theme: Themes.lightTheme,
            darkTheme: Themes.darkTheme,
            home: const NavigationController(),
          );
        },
      ),
    );
  }
}
