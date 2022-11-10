import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'logic/providers/theme_provider.dart';
import 'presentation/navigation_controller.dart';
import 'presentation/themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
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
    );
  }
}
