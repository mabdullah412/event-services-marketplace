import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';
import '../widgets/user_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Header(title: 'Profile'),
            SizedBox(height: padding),
            UserCard(),
            SizedBox(height: padding),
          ],
        ),
      ),
    );
  }
}
