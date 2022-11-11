import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../widgets/header.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Header(title: 'Inbox'),
            Expanded(child: Container()),
            Text(
              'No messages yet.',
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            Text(
              'Start a conversation with the service providers, and get the job done.',
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
