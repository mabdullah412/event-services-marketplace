import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Header(title: 'Home'),
          ],
        ),
      ),
    );
  }
}
