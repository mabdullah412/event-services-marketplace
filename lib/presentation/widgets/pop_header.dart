import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../constants/constants.dart';

class PopHeader extends StatelessWidget {
  const PopHeader({
    required this.title,
    Key? key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(PhosphorIcons.arrowBendUpLeftLight),
        ),
        const SizedBox(width: padding),
        Text(
          title,
          style: Theme.of(context).primaryTextTheme.titleMedium,
        ),
      ],
    );
  }
}
