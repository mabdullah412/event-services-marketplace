import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: Column(
          children: const [
            Header(title: 'Profile'),
          ],
        ),
      ),
    );
  }
}
