import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Header(title: 'Home'),

              // ! add a block showing total number of services being on sale
              // ! open fiverr website for ideas
              // ! user mini-dashboard

              // ! maybe create a single bloc that gets all user
              // ! dashboard data. => getUserDashboard
              // ! the dashboard will contain all the above mentioned
              // ! things.
            ],
          ),
        ),
      ),
    );
  }
}
