import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../constants/enums.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({
    required this.status,
    Key? key,
  }) : super(key: key);

  final Status status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding / 3),
      decoration: BoxDecoration(
        color: status == Status.completed
            ? const Color(0xFF00a28e).withAlpha(30)
            : const Color(0xFFec6f01).withAlpha(30),
        borderRadius: const BorderRadius.all(
          Radius.circular(radius / 2),
        ),
      ),
      child: Text(
        status == Status.completed ? 'Completed' : 'Cancelled',
        style: Theme.of(context).primaryTextTheme.bodySmall!.apply(
              color: status == Status.completed
                  ? const Color(0xFF00a28e)
                  : const Color(0xFFec6f01),
            ),
      ),
    );
  }
}
